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
    var presenter: DetailsViewPresenterProtocol?
    private lazy var openPlayerButton: CustomButton = {
        let button = CustomButton()
        button.backgroundColor = .white
        button.setAttributedTitle(NSAttributedString(string: "Start Watching",
                                                     attributes: [NSAttributedString.Key.foregroundColor: R.color.sky_blue(),
                                                                  NSAttributedString.Key.font: R.font.aliceRegular(size: 20).unwrapped]),
                                  for: .normal)
        return button
    }()
    private var mainPoster: CartoonPosterView?
    private lazy var addToFavouritesButton: CustomButton = {
        let button = CustomButton()
        button.backgroundColor = R.color.sky_blue()
        button.setImage(R.image.star(), for: .normal)
        return button
    }()
    private lazy var titleLabel: UILabel = {
        let label = BorderedLabel(withInsets: 5, 5, left: 10, 10)
        label.textAlignment = .center
        label.numberOfLines = .zero
        return label
    }()
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.alignment = .center
        stack.spacing = 10
        stack.distribution = .fill
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
    }
    
    override func showError(error: Error) {
        super.showError(error: error)
    }
}

extension DetailsViewController {
    @objc func openPlayer() {
        guard let link = video?.link else {
            print("Invalid link")
            return
        }
        presenter?.openPlayer(with: link)
    }
    
    @objc func addToFavourites() {
        addToFavouritesButton.setImage(R.image.star_yellow(), for: .normal)
    }
}

extension DetailsViewController: DetailsViewProtocol {
    func setVideo(video: Cartoon) {
        self.video = video
        let frame = CGRect(x: 0, y: 0, width: .zero, height: view.frame.height / 3)
        guard let url = video.thumbnail else {
            return
        }
        mainPoster = CartoonPosterView(frame: frame, link: url)
        guard let poster = mainPoster else {
            return
        }
        view.addSubview(poster)
        poster.snp.makeConstraints {
            $0.top.equalToSuperview().offset(88)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(view.frame.height * 0.5)
        }
        view.addSubview(titleLabel)
        titleLabel.attributedText = NSAttributedString(string: video.title,
                                                       attributes: [NSAttributedString.Key.foregroundColor: UIColor.white,
                                                                    NSAttributedString.Key.font: R.font.cinzelDecorativeBold(size: 50).unwrapped])
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(poster.snp_bottomMargin).offset(-40)
            $0.leading.trailing.equalToSuperview()
        }
        stackView.addArrangedSubview(openPlayerButton)
        stackView.addArrangedSubview(addToFavouritesButton)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp_bottomMargin).offset(30)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
        }
    }
}
