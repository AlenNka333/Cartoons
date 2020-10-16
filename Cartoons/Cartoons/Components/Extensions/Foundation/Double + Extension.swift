//
//  Double + Extension.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 10/16/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import Foundation

extension Double {
  func asString() -> String {
    let formatter = DateComponentsFormatter()
    formatter.allowedUnits = self > 3600 ? [.hour, .minute, .second] : [.minute, .second]
    formatter.zeroFormattingBehavior = .pad
    guard let formattedString = formatter.string(from: self) else { return "" }
    return formattedString
  }
}
