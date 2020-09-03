//
//  AuthorizationViewController.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 9/2/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import UIKit

class AuthorizationViewController: UIViewController {
    var authView: AuthorizationView! //! !!!!!!!!!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupView()
    }

    func setupView() {
        let mainView = AuthorizationView(frame: view.frame)
        authView = mainView
        view.addSubview(authView)
        authView.setAnchor(top: view.topAnchor, left: view.leftAnchor,
                           bottom: view.bottomAnchor, right: view.rightAnchor,
                           paddingTop: 0, paddingLeft: 0,
                           paddingBottom: 0, paddingRight: 0)
    }

    /*
     // MARK: - Navigation

     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destination.
         // Pass the selected object to the new view controller.
     }
     */
}
