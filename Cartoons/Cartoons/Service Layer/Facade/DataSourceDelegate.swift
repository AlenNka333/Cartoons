//
//  DataSourceDelegate.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 11/4/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import Foundation

protocol DataSourceDelegate: AnyObject {
    func updateDataSource(_ data: [Cartoon]?)
}
