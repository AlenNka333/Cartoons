//
//  LoadingServiceProtocol.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 11/2/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import Foundation

protocol LoadingServiceProtocol: AnyObject {
    func downloadFile(from url: URL)
    func stopLoading()
    func continueLoading()
}
