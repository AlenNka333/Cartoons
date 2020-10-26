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
    
    private var collectionView: UICollectionView?
    private lazy var dataSource = makeDataSource()
    var videos = Cartoon.allVideos
    var snapshot = SnapShot()
    var presenter: CartoonsViewPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureLayout()
        applySnapshot(animatingDifferences: true)
        
        guard let collection = collectionView else {
            return
        }
        setupUIRefreshControl(with: collection)
        showActivityIndicator()
        presenter?.getData()
    }
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        (navigationController as? BaseNavigationController)?.hidesBarsOnSwipe = true
        title = R.string.localizable.cartoons_screen()
        (navigationController as? BaseNavigationController)?.setSubTitle(title: R.string.localizable.cartoons_screen_subtitle())
        (navigationController as? BaseNavigationController)?.setImage(image: R.image.navigation_label(), isEnabled: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func setupUI() {
        super.setupUI()
        view.addSubview(activityIndicator)
    }
    
    override func showError(error: Error) {
        super.showError(error: error)
    }
}

// MARK: - Protocol realisation

extension CartoonsViewController: CartoonsViewProtocol {
    func showSuccess(success: String) {
        let alertVC = alertService.alert(title: R.string.localizable.success(), body: success, alertType: .success) { _ in
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
        guard let video = dataSource.itemIdentifier(for: indexPath) else {
          return
        }
        guard let link = video.link else {
          print("Invalid link")
          return
        }
        presenter?.openPlayer(with: link)
    }
}

extension CartoonsViewController {
    func makeDataSource() -> DataSource {
        let dataSource = DataSource(collectionView: collectionView ?? UICollectionView(),
                                    cellProvider: { collectionView, indexPath, cartoon -> UICollectionViewCell? in
                                        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId",
                                                                                      for: indexPath) as? CartoonCollectionViewCell
                                        cell?.video = cartoon
                                        return cell
                                    })
        return dataSource
    }
    
    func configureLayout() {
        let layout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView?.delegate = self
        collectionView?.backgroundColor = R.color.main_orange()
        collectionView?.collectionViewLayout = UICollectionViewCompositionalLayout(sectionProvider: { _, _ -> NSCollectionLayoutSection? in
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(200))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 5.0, leading: 5.0, bottom: 5.0, trailing: 5.0)
            
            let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                                                            heightDimension: .fractionalHeight(0.7)),
                                                         subitem: item,
                                                         count: 3)
            group.interItemSpacing = .fixed(30)
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = 30
            section.contentInsets = NSDirectionalEdgeInsets(top: 30, leading: 20, bottom: 0, trailing: 20)
            return section
        })
        collectionView?.register(CartoonCollectionViewCell.self, forCellWithReuseIdentifier: "cellId")
        view.addSubview(UIView(frame: .zero))
        view.addSubview(collectionView ?? UICollectionView())
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
    
    func applySnapshot(animatingDifferences: Bool = true) {
        snapshot.deleteAllItems()
        snapshot.appendSections([.main])
        snapshot.appendItems(videos)
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }
}
