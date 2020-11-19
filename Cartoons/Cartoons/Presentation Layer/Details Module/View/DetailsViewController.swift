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
    weak var transitionDelegate: DetailsTransitionDelegate?
    var presenter: DetailsViewPresenterProtocol?
    
    private var cartoon: Cartoon?
    private var mainPoster = CartoonPosterView()
    private lazy var openPlayerButton: CustomButton = {
        let button = CustomButton()
        button.backgroundColor = R.color.sea_blue()
        button.setAttributedTitle(NSAttributedString(string: R.string.localizable.start_watching(),
                                                     attributes: [.foregroundColor: UIColor.white,
                                                                  .font: R.font.aliceRegular(size: 20).unwrapped]),
                                  for: .normal)
        return button
    }()
    private lazy var downloadButton: CustomButton = {
        let button = CustomButton()
        button.backgroundColor = R.color.sky_blue()
        button.setImage(R.image.download_button(), for: .normal)
        return button
    }()
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = .zero
        label.layer.shadowRadius = 3.0
        label.layer.shadowOpacity = 1.0
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowOffset = CGSize(width: 4, height: 4)
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
        navigationController?.hidesBarsOnSwipe = false
    }
    
    override func setupUI() {
        super.setupUI()
        view.backgroundColor = R.color.navigation_bar_color()
        view.isUserInteractionEnabled = true
        
        openPlayerButton.addTarget(self, action: #selector(openPlayer), for: .touchUpInside)
        downloadButton.addTarget(self, action: #selector(downloadCartoon), for: .touchUpInside)
        
        view.addSubview(mainPoster)
        mainPoster.snp.makeConstraints {
            $0.top.equalToSuperview().offset(88)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(UIScreen.main.bounds.height * 0.5)
        }
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(mainPoster.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        stackView.addArrangedSubview(openPlayerButton)
        stackView.addArrangedSubview(downloadButton)
        view.addSubview(stackView)
        downloadButton.snp.makeConstraints {
            $0.size.equalTo(50)
        }
        stackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().offset(-60)
        }
    }

    override func showError(error: Error) {
        super.showError(error: error)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.isHidden = false
    }
}

extension DetailsViewController {
    @objc func openPlayer() {
        guard let link = cartoon?.globalCartoonLink else {
            return
        }
        presenter?.transit(with: link)
    }
    
    @objc func downloadCartoon() {
        guard let file = cartoon else {
            return
        }
        cartoon?.loadingState == .downloaded
            ? (downloadButton.setImage(R.image.star_yellow(), for: .normal))
            : (downloadButton.setImage(R.image.star(), for: .normal))
        presenter?.downloadFile(file)
    }
}

extension DetailsViewController: DetailsViewProtocol {
    func transit(with link: URL) {
        transitionDelegate?.transit(with: link)
    }
    
    func setMessage(_ message: String) {
        let alertVC = AlertService.alert(title: R.string.localizable.choice_alert_title(), body: message, alertType: .success) { _ in
            return
        }
        present(alertVC, animated: true)
    }
    
    func setError(_ error: Error) {
        showError(error: error)
    }
    
    func setVideo(video: Cartoon) {
        self.cartoon = video
        guard let url = video.thumbnailImageURL else {
            return
        }
        mainPoster.setImage(with: url)
        UIScreen.main.bounds.height > 736 ?
            (titleLabel.attributedText = NSAttributedString(string: video.title ?? "",
                                                            attributes: [.foregroundColor: UIColor.white,
                                                                         .font: R.font.cinzelDecorativeBold(size: 45).unwrapped]))
            : (titleLabel.attributedText = NSAttributedString(string: video.title ?? "",
                                                              attributes: [.foregroundColor: UIColor.white,
                                                                           .font: R.font.cinzelDecorativeBold(size: 30).unwrapped]))
        if video.loadingState == .downloaded {
            downloadButton.setImage(R.image.star_yellow(), for: .normal)
        }
    }
}
