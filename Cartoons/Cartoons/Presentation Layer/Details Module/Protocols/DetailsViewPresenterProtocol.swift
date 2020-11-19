//
//  DetailsViewPresenterProtocol.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 10/12/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import Foundation

protocol DetailsViewPresenterProtocol: AnyObject {
    func downloadFile(_ file: Cartoon)
    func transit(with link: URL)
}
