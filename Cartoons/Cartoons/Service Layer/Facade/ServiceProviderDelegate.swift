//
//  DataSourceDelegate.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 11/4/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import Foundation

protocol ServiceProviderDelegate: AnyObject {
    func updateProgress(_ progress: String)
    func updateDataSource(_ data: [Cartoon]?)
}
