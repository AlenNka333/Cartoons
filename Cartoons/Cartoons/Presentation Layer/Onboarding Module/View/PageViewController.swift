//
//  PageViewController.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 9/14/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController {
    enum Constants {
        static let initialPage: Int = 0
    }
    
    weak var transitionDelegate: OnboardingTransitionDelegate?
    var presenter: PageControllerPresenter?
    private var pages = [UIViewController]()
    private lazy var pageControl: UIPageControl = {
        let pageC = UIPageControl()
        pageC.frame = CGRect()
        pageC.currentPageIndicatorTintColor = .white
        pageC.pageIndicatorTintColor = .darkGray
        pageC.currentPage = Constants.initialPage
        return pageC
    }()
    
    init(pages: [UIViewController]) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        self.pages = pages
        self.setViewControllers([pages[Constants.initialPage]], direction: .forward, animated: true, completion: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        self.delegate = self
        setupUI()
    }
    
    func setupUI() {
        view.addSubview(pageControl)
        pageControl.numberOfPages = pages.count
        pageControl.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-30)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(150)
            $0.height.equalTo(50)
        }
    }
}

extension PageViewController: PageViewControllerProtocol {
}

extension PageViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController,
                            didFinishAnimating finished: Bool,
                            previousViewControllers: [UIViewController],
                            transitionCompleted completed: Bool) {
        if let viewControllers = pageViewController.viewControllers {
            if let viewControllerIndex = pages.firstIndex(of: viewControllers[0]) {
                pageControl.currentPage = viewControllerIndex
            }
        }
    }
}

extension PageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let viewControllerIndex = self.pages.firstIndex(of: viewController) {
            if viewControllerIndex > 0 {
                return pages[viewControllerIndex - 1]
            }
           return nil
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let viewControllerIndex = self.pages.firstIndex(of: viewController) {
            if viewControllerIndex < pages.count - 1 {
                return pages[viewControllerIndex + 1]
            }
           transitionDelegate?.transit()
        }
        return nil
    }
}
