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
    
    private var collectionView: UICollectionView?
    private var dataSource: DataSource?
    weak var transitionDelegate: FavouritesTransitionDelegate?
    var presenter: FavouritesViewPresenterProtocol?
    var videos = [Cartoon]()
    var snapshot = SnapShot()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let collection = collectionView else {
            return
        }
        dataSource = makeDataSource()
        setupUIRefreshControl(with: collection)
        showActivityIndicator()
        presenter?.getData()
    }
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        navigationController?.hidesBarsOnSwipe = true
        title = R.string.localizable.favourites_screen()
        (navigationController as? BaseNavigationController)?.setupCustomizedUI(image: R.image.favourites().unwrapped,
                                                                               subtitle: R.string.localizable.favourites_screen_subtitle(),
                                                                               isUserInteractionEnabled: false)
    }
    
    override func setupUI() {
        super.setupUI()
        view.backgroundColor = R.color.main_orange()
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: configureLayout())
        collectionView?.delegate = self
        collectionView?.backgroundColor = R.color.main_orange()
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
    func showSuccess(success: String) {
        let alertVC = AlertService.alert(title: R.string.localizable.success(), body: success, alertType: .success) { _ in
            return
        }
        present(alertVC, animated: true)
    }
    
    func setData(data: [Cartoon]) {
        videos = data
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

extension FavouritesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cartoon = dataSource?.itemIdentifier(for: indexPath) else {
            return
        }
        guard let link = cartoon.localPath else {
            print("Invalid link")
            return
        }
        hidesBottomBarWhenPushed = true
        transitionDelegate?.transit(link: link)
        hidesBottomBarWhenPushed = false
    }
}

extension FavouritesViewController {
    func makeDataSource() -> DataSource {
        let dataSource = DataSource(collectionView: collectionView ?? UICollectionView()) { collectionView, indexPath, cartoon -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId",
                                                          for: indexPath) as? FavouritesCollectionViewCell
            cell?.video = cartoon
            return cell
        }
        return dataSource
    }
    
    func applySnapshot(animatingDifferences: Bool = true) {
        snapshot.deleteAllItems()
        snapshot.appendSections([.main])
        snapshot.appendItems(videos, toSection: .main)
        dataSource?.apply(snapshot)
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
        item.contentInsets = NSDirectionalEdgeInsets(top: 5.0, leading: 5.0, bottom: 5.0, trailing: 5.0)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalWidth(0.5))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    func setupUIRefreshControl(with collectionView: UICollectionView) {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        refreshControl.tintColor = .black
        collectionView.refreshControl = refreshControl
        collectionView.refreshControl?.isEnabled = false
    }
    
    @objc func handleRefresh() {
        presenter?.getData()
    }
}
