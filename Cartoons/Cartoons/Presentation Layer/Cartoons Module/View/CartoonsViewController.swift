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
    
    private let generator = UISelectionFeedbackGenerator()
    
    weak var transitionDelegate: CartoonsTransitionDelegate?
    var presenter: CartoonsViewPresenterProtocol?
    private var collectionView: UICollectionView?
    private var dataSource: DataSource?
    private var snapshot: SnapShot?
    private var cartoonsList = [Cartoon]() {
        didSet {
            cartoonsList.isEmpty ? (backgroundView.isHidden = false) : (backgroundView.isHidden = true)
        }
    }
    private lazy var backgroundView: UIView = {
        var view = UIView()
        let textLabel = UILabel()
        textLabel.attributedText = NSAttributedString(string: R.string.localizable.cartoons_collection_background(),
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeDataSource()
        applySnapshot(animatingDifferences: true)
        
        showActivityIndicator()
        presenter?.getDataList()
    }
    
     override func setupNavigationBar() {
        title = R.string.localizable.cartoons_screen()
        (navigationController as? BaseNavigationController)?.navigationBar.isHidden = false
        (navigationController as? BaseNavigationController)?.hidesBarsOnSwipe = true
        (navigationController as? BaseNavigationController)?.setupCustomizedUI(image: R.image.navigation_label().unwrapped,
                                                                               subtitle: R.string.localizable.cartoons_screen_subtitle(),
                                                                               isUserInteractionEnabled: false)
    }
    
    override func setupUI() {
        super.setupUI()
        view.addSubview(activityIndicator)
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: configureLayout())
        collectionView?.delegate = self
        collectionView?.showsVerticalScrollIndicator = false
        collectionView?.backgroundColor = R.color.main_orange()
        collectionView?.backgroundView = backgroundView
        collectionView?.delaysContentTouches = false
        
        view.addSubview(UIView(frame: .zero))
        view.addSubview(collectionView ?? UICollectionView())
        collectionView?.register(CartoonCollectionViewCell.self, forCellWithReuseIdentifier: "cellId")
        
        guard let collection = collectionView else {
            return
        }
        setupUIRefreshControl(collection)
    }
    
    override func showError(error: Error) {
        super.showError(error: error)
    }
}

// MARK: - Protocol realisation

extension CartoonsViewController: CartoonsViewProtocol {
    func transit(with cartoon: Cartoon) {
        hidesBottomBarWhenPushed = true
        transitionDelegate?.transit(with: cartoon)
        hidesBottomBarWhenPushed = false
    }
    
    func updateDataList(with array: [Cartoon]) {
        guard let control = collectionView?.refreshControl else {
            return
        }
        if activityIndicator.isAnimating {
            stopActivityIndicator()
        }
        if control.isRefreshing {
            collectionView?.refreshControl?.endRefreshing()
        }
        cartoonsList = array
        applySnapshot()
        collectionView?.refreshControl?.isEnabled = true
    }
}

// MARK: - CollectionViewDelegate

extension CartoonsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cartoon = dataSource?.itemIdentifier(for: indexPath) else {
            return
        }
        generator.selectionChanged()
        presenter?.transit(with: cartoon)
    }
}

// MARK: - CollectionViewDiffableDataSource

extension CartoonsViewController {
    func makeDataSource() {
         dataSource = DataSource(collectionView: collectionView ?? UICollectionView()) { collectionView, indexPath, cartoon -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId",
                                                          for: indexPath) as? CartoonCollectionViewCell
            cell?.video = cartoon
            if cartoon.loadingState == .downloaded {
                cell?.highlightIndicator()
            }
            return cell
         }
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
    
    func setupUIRefreshControl(_ collectionView: UICollectionView) {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        refreshControl.tintColor = .white
        collectionView.refreshControl = refreshControl
        collectionView.refreshControl?.isEnabled = false
    }
    
    @objc func handleRefresh() {
        presenter?.getDataList()
    }
    
    func applySnapshot(animatingDifferences: Bool = true) {
        snapshot = SnapShot()
        snapshot?.appendSections([.main])
        snapshot?.appendItems(cartoonsList, toSection: .main)
        dataSource?.apply(snapshot ?? SnapShot())
    }
}
