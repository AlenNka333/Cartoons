//
//  SettingsTableViewCell.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 10/23/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import Foundation
import UIKit

class SettingsTableViewCell: UITableViewCell {
    static var reuseIdentifier: String {
          return String(describing: SettingsTableViewCell.self)
    }
    
    var button = CustomButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        contentView.frame = CGRect(x: 0, y: 0, width: .zero, height: frame.height)
        contentView.backgroundColor = R.color.picotee_blue()
        contentView.addSubview(button)
        button.isEnabled = true
        button.layer.cornerRadius = 10
        button.backgroundColor = R.color.table_cell()
        button.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.height.equalToSuperview().offset(-15)
            $0.width.equalToSuperview().offset(-30)
        }
    }
    
    func setButtonText(string: String) {
        button.setTitle(string, for: .normal)
    }
}
