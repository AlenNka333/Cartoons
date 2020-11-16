//
//  Setting.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 10/23/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import Foundation

class Setting: Hashable {
    private var id = UUID()
    var title: String
    
    init(title: String) {
        self.title = title
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Setting, rhs: Setting) -> Bool {
        lhs.id == rhs.id
    }
}
