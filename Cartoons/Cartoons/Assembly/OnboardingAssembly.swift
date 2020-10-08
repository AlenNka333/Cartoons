//
//  OnboardingAssembly.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 10/8/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import UIKit

class OnboardingAssembly: Assembly {
    enum Constants {
        static let initialPage: Int = 0
    }
    
    static func makeOnboardingCoordinator() -> OnboardingCoordinator {
        return OnboardingCoordinator()
    }
    
    static func makeOnboardingController() -> PageViewController {
        var pages = [UIViewController]()
        pages.append(StreamingFeatureViewController())
        pages.append(OfflineWatchingFeatureViewController())
        let view = PageViewController(pages: pages)
        return view
    }
}
