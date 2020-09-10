//
//  CartoonsViewPresenterProtocol.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 9/10/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import Foundation

protocol CartoonsViewPresenterProtocol: AnyObject {
   init(view: CartoonsViewProtocol, router: RouterProtocol)
}
