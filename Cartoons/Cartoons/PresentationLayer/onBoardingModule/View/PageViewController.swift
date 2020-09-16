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

    var skipButton: UIButton = {
        let button = UIButton()
        let string = NSAttributedString(string: R.string.localizable.skip(),
                                        attributes: [NSAttributedString.Key.font:
                                            UIFont.systemFont(ofSize: 18),
                                                     .foregroundColor: UIColor.white])
        let attributedString = NSMutableAttributedString(attributedString: string)
        button.setAttributedTitle(attributedString, for: .normal)
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 2
        button.layer.borderColor = R.color.enabled_button()?.cgColor
        button.addTarget(self, action: #selector(skipButtonAction), for: .touchUpInside)
        return button
    }()
    
    var contentTextView: UITextView = {
        let text = UITextView()
        text.isUserInteractionEnabled = false
        text.text = "Test"
        return text
    }()

    var presenter: PageControllerPresenter!
    private var pages = [UIViewController]()  
    private lazy var pageControl: UIPageControl = {
        let pageC = UIPageControl()
        pageC.frame = CGRect()
        pageC.currentPageIndicatorTintColor = .white
        pageC.pageIndicatorTintColor = .darkGray
        pageC.currentPage = Constants.initialPage
        return pageC
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        self.delegate = self
        initViewControllers()
        setupUI()
    }
    
    func initViewControllers() {
        pages.append(StreamingFeatureViewController())
        pages.append(OfflineWatchingFeatureViewController())
        pages.append(ThirdFeatureViewController())
        setViewControllers([pages[Constants.initialPage]], direction: .forward, animated: true, completion: nil)
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
        
        view.addSubview(contentTextView)
        contentTextView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        view.addSubview(skipButton)
        skipButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(50)
            $0.trailing.equalToSuperview().offset(-10)
            $0.width.equalTo(100)
            $0.height.equalTo(30)
        }
    }
}

extension PageViewController {
    @objc func skipButtonAction() {
        presenter.saveUserCame()
        presenter.showAuthorizationScreen()
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
            if viewControllerIndex == 0 {
                return pages.last
            } else {
                return pages[viewControllerIndex - 1]
            }
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let viewControllerIndex = self.pages.firstIndex(of: viewController) {
            if viewControllerIndex < pages.count - 1 {
                return pages[viewControllerIndex + 1]
            } else {
                presenter.saveUserCame()
                presenter.showAuthorizationScreen()
            }
        }
        return nil
    }
}
