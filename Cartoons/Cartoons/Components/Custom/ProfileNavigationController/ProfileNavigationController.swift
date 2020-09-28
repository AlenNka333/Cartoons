//
//  ProfileNavigationController.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 9/25/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import UIKit

class ProfileNavigationController: UINavigationController {
    public var closure: (() -> Void)?
    
    private let profileImageView = UIImageView(image: R.image.clapperboard())
    private lazy var appearance: UINavigationBarAppearance = {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = R.color.navigation_bar_color()
        appearance.largeTitleTextAttributes = [ NSAttributedString.Key.foregroundColor: UIColor.white,
                                                NSAttributedString.Key.font: R.font.aliceRegular(size: 20).unwrapped ]
        appearance.shadowColor = .black
        return appearance
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        navigationBar.prefersLargeTitles = true
        navigationBar.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        navigationBar.layer.shadowRadius = 4.0
        navigationBar.layer.shadowOpacity = 1.0
        navigationBar.layer.masksToBounds = false
        navigationBar.standardAppearance = appearance
        navigationBar.compactAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
    }
}
