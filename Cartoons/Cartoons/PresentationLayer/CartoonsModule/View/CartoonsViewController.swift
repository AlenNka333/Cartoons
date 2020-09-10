//
//  CartoonsViewController.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 9/10/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import FirebaseAuth
import UIKit

class CartoonsViewController: UIViewController {
    var presenter: CartoonsViewPresenterProtocol!
    
    let tabBarCnt = UITabBarController()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tabBarCnt.tabBar.tintColor = UIColor.black
        createTabBarController()
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
            CustomAlertView.instance.showAlert(title: "Sign Out", message: "Success", alertType: .success)
        } catch let error as NSError {
          CustomAlertView.instance.showAlert(title: "Sign Out", message: error.localizedDescription, alertType: .error)
        }
        
    }
      func createTabBarController() {
        let firstVc = UIViewController()
        firstVc.title = "First"
        firstVc.view.backgroundColor = UIColor.red
        firstVc.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "HomeTab"), tag: 0)
        
        let secondVc = UIViewController()
        secondVc.title = "Second"
        secondVc.view.backgroundColor = UIColor.green
        secondVc.tabBarItem = UITabBarItem(title: "Location", image: UIImage(named: "Location"), tag: 1)

        let controllerArray = [firstVc, secondVc]
        tabBarCnt.viewControllers = controllerArray.map{ UINavigationController( rootViewController: $0)}
        
        self.view.addSubview(tabBarCnt.view)
    }
}

extension CartoonsViewController: CartoonsViewProtocol {
}
