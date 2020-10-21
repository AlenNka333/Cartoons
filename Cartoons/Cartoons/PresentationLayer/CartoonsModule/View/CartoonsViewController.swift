//
//  CartoonsViewController.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 10/13/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//
//swiftlint:disable all
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
    var presenter: CartoonsViewPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLayout()
        applySnapshot(animatingDifferences: true)
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

extension CartoonsViewController: CartoonsViewProtocol {
    func showSuccess(success: String) {
        let alertVC = alertService.alert(title: R.string.localizable.success(), body: success, alertType: .success) { _ in
            return
        }
        present(alertVC, animated: true)
    }
    
    func setDataSource(with array: [Cartoon]) {
        videos = array
        stopActivityIndicator()
        applySnapshot()
    }
}

extension CartoonsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.openPlayer()
    }
}

extension CartoonsViewController {
    func applySnapshot(animatingDifferences: Bool = true) {
        var snapshot = SnapShot()
        snapshot.appendSections([.main])
        snapshot.appendItems(videos)
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }
    
    func makeDataSource() -> DataSource {
        let dataSource = DataSource(collectionView: collectionView ?? UICollectionView(),
                                    cellProvider: { (collectionView, indexPath, cartoon) -> UICollectionViewCell? in
                                        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as? CartoonCollectionViewCell
                                        cell?.layer.shadowColor = UIColor.black.cgColor
                                        cell?.layer.shadowOffset = CGSize(width: 3, height: 8)
                                        cell?.layer.shadowOpacity = 0.6
                                        cell?.layer.masksToBounds = false
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
        collectionView?.collectionViewLayout = UICollectionViewCompositionalLayout(sectionProvider: { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
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
}
