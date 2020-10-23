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
        contentView.backgroundColor = R.color.main_blue()
        contentView.addSubview(button)
        button.isEnabled = true
        button.backgroundColor = R.color.table_cell()
        button.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.height.equalToSuperview().offset(-5)
            $0.width.equalToSuperview().offset(-50)
        }
    }
    
    func setButtonText(string: String) {
        button.setTitle(string, for: .normal)
    }
}
