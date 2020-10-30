//
//  DetailsViewController.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 10/12/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import Foundation
import UIKit

class DetailsViewController: BaseViewController {
    private var video: Cartoon?
    
    weak var transitionDelegate: DetailsTransitionDelegate?
    var presenter: DetailsViewPresenterProtocol?

    private lazy var openPlayerButton: CustomButton = {
        let button = CustomButton()
        button.backgroundColor = R.color.sea_blue()
        button.setAttributedTitle(NSAttributedString(string: R.string.localizable.start_watching(),
                                                     attributes: [.foregroundColor: UIColor.white,
                                                                  .font: R.font.aliceRegular(size: 20).unwrapped]),
                                  for: .normal)
        return button
    }()
    private var mainPoster = CartoonPosterView()
    private lazy var addToFavouritesButton: CustomButton = {
        let button = CustomButton()
        button.backgroundColor = R.color.sky_blue()
        button.setImage(R.image.star(), for: .normal)
        return button
    }()
    private lazy var titleLabel: UILabel = {
        let label = BorderedLabel(with: .init(top: 5, left: 10, bottom: 5, right: 10))
        label.textAlignment = .center
        label.numberOfLines = .zero
        label.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
        return label
    }()
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.alignment = .fill
        stack.spacing = 10
        return stack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setupUI() {
        super.setupUI()
        
        tabBarItem.isEnabled = false
        view.backgroundColor = R.color.navigation_bar_color()
        view.isUserInteractionEnabled = true
        
        openPlayerButton.addTarget(self, action: #selector(openPlayer), for: .touchUpInside)
        addToFavouritesButton.addTarget(self, action: #selector(addToFavourites), for: .touchUpInside)
        
        view.addSubview(mainPoster)
        mainPoster.snp.makeConstraints {
            $0.top.equalToSuperview().offset(88)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(UIScreen.main.bounds.height * 0.5)
        }
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(mainPoster.snp.bottom).offset(40)
            $0.leading.trailing.equalToSuperview()
        }
        
        view.addSubview(stackView)
        stackView.addArrangedSubview(openPlayerButton)
        addToFavouritesButton.snp.makeConstraints {
            $0.size.equalTo(50)
        }
        stackView.addArrangedSubview(addToFavouritesButton)
        stackView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(40)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().offset(-60)
        }
    }
    
    override func showError(error: Error) {
        super.showError(error: error)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}

extension DetailsViewController {
    @objc func openPlayer() {
        guard let link = video?.link else {
            print("Invalid link")
            return
        }
        transitionDelegate?.transit(with: link)
    }
    
    @objc func addToFavourites() {
        addToFavouritesButton.setImage(R.image.star_yellow(), for: .normal)
    }
}

extension DetailsViewController: DetailsViewProtocol {
    func setVideo(video: Cartoon) {
        self.video = video
        guard let url = video.thumbnail else {
            return
        }
        mainPoster.setImage(with: url)
        titleLabel.attributedText = NSAttributedString(string: video.title,
                                                       attributes: [.foregroundColor: UIColor.white,
                                                                    .font: R.font.cinzelDecorativeBold(size: 45).unwrapped])
    }
}
