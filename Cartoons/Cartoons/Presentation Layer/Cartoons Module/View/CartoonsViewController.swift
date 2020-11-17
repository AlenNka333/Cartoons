//
//  CartoonsViewController.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 10/13/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//
import AVFoundation
import AVKit
import Foundation
import UIKit

class CartoonsViewController: BaseViewController {
    typealias DataSource = UICollectionViewDiffableDataSource<Section, Cartoon>
    typealias SnapShot = NSDiffableDataSourceSnapshot<Section, Cartoon>
    
    let generator = UISelectionFeedbackGenerator()
    
    private lazy var backgroundView: UIView = {
        var view = UIView()
        var text = UILabel()
        text.attributedText = NSAttributedString(string: R.string.localizable.cartoons_collection_background(),
                                                 attributes: [ .foregroundColor: UIColor.darkGray,
                                                               .font: R.font.aliceRegular(size: 17).unwrapped])
        text.numberOfLines = .zero
        text.textAlignment = .center
        view.addSubview(text)
        view.backgroundColor = R.color.main_orange()
        text.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(50)
        }
        return view
    }()
    private var collectionView: UICollectionView?
    private lazy var dataSource = makeDataSource()
    weak var transitionDelegate: CartoonsTransitionDelegate?
    var videos = [Cartoon]() {
        didSet {
            videos.isEmpty ? (backgroundView.isHidden = false) : (backgroundView.isHidden = true)
        }
    }
    var snapshot = SnapShot()
    var presenter: CartoonsViewPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applySnapshot(animatingDifferences: true)
        guard let collection = collectionView else {
            return
        }
        setupUIRefreshControl(with: collection)
        showActivityIndicator()
        presenter?.getData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    override func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        (navigationController as? BaseNavigationController)?.navigationBar.isHidden = false
        (navigationController as? BaseNavigationController)?.hidesBarsOnSwipe = true
        title = R.string.localizable.cartoons_screen()
        (navigationController as? BaseNavigationController)?.setupCustomizedUI(image: R.image.navigation_label().unwrapped,
                                                                               subtitle: R.string.localizable.cartoons_screen_subtitle(),
                                                                               isUserInteractionEnabled: false)
    }
    
    override func setupUI() {
        super.setupUI()
        view.addSubview(activityIndicator)
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: configureLayout())
        collectionView?.delegate = self
        collectionView?.backgroundColor = R.color.main_orange()
        view.addSubview(UIView(frame: .zero))
        view.addSubview(collectionView ?? UICollectionView())
        collectionView?.backgroundView = backgroundView
        collectionView?.delaysContentTouches = false
        collectionView?.register(CartoonCollectionViewCell.self, forCellWithReuseIdentifier: "cellId")
    }
    
    override func showError(error: Error) {
        super.showError(error: error)
    }
}

// MARK: - Protocol realisation

extension CartoonsViewController: CartoonsViewProtocol {
    func showSuccess(success: String) {
        let alertVC = AlertService.alert(title: R.string.localizable.success(), body: success, alertType: .success) { _ in
            return
        }
        present(alertVC, animated: true)
    }
    
    func setDataSource(with array: [Cartoon]) {
        videos = array
        if activityIndicator.isAnimating {
            stopActivityIndicator()
        }
        guard let control = collectionView?.refreshControl else {
            return
        }
        if control.isRefreshing {
            collectionView?.refreshControl?.endRefreshing()
        }
        applySnapshot()
        collectionView?.refreshControl?.isEnabled = true
    }
}

// MARK: - CollectionViewDiffableDataSource

extension CartoonsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cartoon = dataSource.itemIdentifier(for: indexPath) else {
            return
        }
        generator.selectionChanged()
        hidesBottomBarWhenPushed = true
        transitionDelegate?.transit(cartoon: cartoon)
        hidesBottomBarWhenPushed = false
    }
}

extension CartoonsViewController {
    func makeDataSource() -> DataSource {
        let dataSource = DataSource(collectionView: collectionView ?? UICollectionView()) { collectionView, indexPath, cartoon -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId",
                                                          for: indexPath) as? CartoonCollectionViewCell
            cell?.video = cartoon
            if cartoon.state == .loaded {
                cell?.setToFavourites()
            }
            return cell
        }
        return dataSource
    }
    
    func configureLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { _, _ -> NSCollectionLayoutSection in
            return self.createMainSection()
        }
        return layout
    }
    
    func createMainSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 20.0, leading: 25.0, bottom: 20.0, trailing: 25.0)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalHeight(0.4))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 5
        return section
    }
    
    func setupUIRefreshControl(with collectionView: UICollectionView) {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        refreshControl.tintColor = .white
        collectionView.refreshControl = refreshControl
        collectionView.refreshControl?.isEnabled = false
    }
    
    @objc func handleRefresh() {
        presenter?.getData()
    }
    
    func applySnapshot(animatingDifferences: Bool = true) {
        snapshot = SnapShot()
        snapshot.appendSections([.main])
        snapshot.appendItems(videos, toSection: .main)
        dataSource.apply(snapshot)
    }
}
