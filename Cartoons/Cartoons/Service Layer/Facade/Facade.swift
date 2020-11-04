//
//  DataFacadeProtocol.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 11/5/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import Foundation

protocol Facade: AnyObject {
    func getProgressData() -> [Cartoon]?
    func getServerData()
    func getLocalData()
}
