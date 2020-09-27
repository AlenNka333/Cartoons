//
//  CustomLabel.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 9/17/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import Foundation
import UIKit

class CustomLabelView: UIView {
    @IBOutlet weak private var textLabel: UILabel!
    @IBOutlet weak var image: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        Bundle.main.loadNibNamed(Constants.labelClassName, owner: self, options: nil)
        addSubview(textLabel)
        addSubview(image)
        textLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        image.snp.makeConstraints {
            $0.top.equalTo(textLabel)
            $0.trailing.equalTo(textLabel).offset(15)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
