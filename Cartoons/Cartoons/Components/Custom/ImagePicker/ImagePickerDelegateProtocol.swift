//
//  ImagePickerDelegateProtocol.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 9/28/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import UIKit

protocol ImagePickerDelegateProtocol: AnyObject {
    func didSelect(image: UIImage?)
}
