//
//  VerificationCodeViewController.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 9/3/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import UIKit

class VerificationCodeViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let mainView = VerificationView(frame: view.frame)
        view.addSubview(mainView)
    }

}
