//
//  FavouritesViewController.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 9/21/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import UIKit

class FavouritesViewController: BaseViewController {
    typealias DataSource = UICollectionViewDiffableDataSource<Section, Cartoon>
    typealias SnapShot = NSDiffableDataSourceSnapshot<Section, Cartoon>
    
    let generator = UISelectionFeedbackGenerator()
    
    weak var transitionDelegate: FavouritesTransitionDelegate?
    var presenter: FavouritesViewPresenterProtocol?
    private var collectionView: UICollectionView?
    private var dataSource: DataSource?
    private var snapshot: SnapShot?
    private lazy var backgroundView: UIView = {
        var view = UIView()
        var textLabel = UILabel()
        textLabel.attributedText = NSAttributedString(string: R.string.localizable.favourites_collection_background(),
                                                      attributes: [ .foregroundColor: UIColor.darkGray,
                                                                    .font: R.font.aliceRegular(size: 17).unwrapped])
        textLabel.numberOfLines = .zero
        textLabel.textAlignment = .center
        view.addSubview(textLabel)
        textLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(50)
        }
        return view
    }()
    private var cartoonsList = [Cartoon]() {
        didSet {
            cartoonsList.isEmpty ? (backgroundView.isHidden = false) : (backgroundView.isHidden = true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(didBecomeActive), name: UIApplication.didBecomeActiveNotification, object: nil)
        makeDataSource()
        showActivityIndicator()
        presenter?.getDataList()
    }
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        (navigationController as? BaseNavigationController)?.navigationBar.isHidden = false
        navigationController?.hidesBarsOnSwipe = true
        title = R.string.localizable.favourites_screen()
        (navigationController as? BaseNavigationController)?.setupCustomizedUI(image: R.image.favourites().unwrapped,
                                                                               subtitle: R.string.localizable.favourites_screen_subtitle(),
                                                                               isUserInteractionEnabled: false)
    }
    
    override func setupUI() {
        super.setupUI()
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: configureLayout())
        collectionView?.delaysContentTouches = false
        collectionView?.delegate = self
        collectionView?.showsVerticalScrollIndicator = false
        collectionView?.backgroundColor = R.color.main_orange()
        collectionView?.backgroundView = backgroundView
        view.addSubview(UIView(frame: .zero))
        view.addSubview(collectionView ?? UICollectionView())
        collectionView?.register(FavouritesCollectionViewCell.self, forCellWithReuseIdentifier: "cellId")
    }
    
    override func showError(error: Error) {
        super.showError(error: error)
        stopActivityIndicator()
    }
}

extension FavouritesViewController: FavouritesViewProtocol {
    func transit(with videoUrl: URL) {
        hidesBottomBarWhenPushed = true
        transitionDelegate?.transit(with: videoUrl)
        hidesBottomBarWhenPushed = false
    }
    
    func showSuccess(success: String) {
        let alertVC = AlertService.alert(title: R.string.localizable.success(), body: success, alertType: .success) { _ in
            return
        }
        present(alertVC, animated: true)
    }
    
    func updateDataList(data: [Cartoon]) {
        cartoonsList = data
        if activityIndicator.isAnimating {
            stopActivityIndicator()
        }
        applySnapshot()
    }
    
    func setBytesLoadedPercentage(_ progress: Float) {
        if let downloadingCell = collectionView?.cellForItem(at: IndexPath(item: cartoonsList.count - 1, section: 0)) as? FavouritesCollectionViewCell {
            downloadingCell.progress = progress
            downloadingCell.setNeedsDisplay()
            downloadingCell.isUserInteractionEnabled = false
        }
    }
}

extension FavouritesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cartoon = dataSource?.itemIdentifier(for: indexPath), let link = cartoon.localCartoonLink else {
            return
        }
        generator.selectionChanged()
        presenter?.transit(with: link)
    }
}

extension FavouritesViewController {
    @objc func didBecomeActive() {
        presenter?.getDataList()
    }
    
    func makeDataSource() {
        dataSource = DataSource(collectionView: collectionView ?? UICollectionView()) { collectionView, indexPath, cartoon -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId",
                                                          for: indexPath) as? FavouritesCollectionViewCell
            cell?.video = cartoon
            if cartoon.loadingState == .inProgress {
                cell?.setProgressView()
                cell?.progress = cartoon.loadedBytesCount
            }
            return cell
        }
    }
    
    func applySnapshot(animatingDifferences: Bool = true) {
        snapshot = SnapShot()
        snapshot?.appendSections([.main])
        snapshot?.appendItems(cartoonsList, toSection: .main)
        dataSource?.apply(snapshot ?? SnapShot())
    }
    
    func configureLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { _, _ -> NSCollectionLayoutSection in
            return self.createMainSection()
        }
        return layout
    }
    
    func createMainSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),
                                              heightDimension: .fractionalWidth(0.5))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 10.0, leading: 10.0, bottom: 10.0, trailing: 10.0)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalWidth(0.5))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
}
