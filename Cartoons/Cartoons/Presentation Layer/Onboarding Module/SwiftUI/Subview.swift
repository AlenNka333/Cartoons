//
//  Subview.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 11/13/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import SwiftUI

struct Subview: View {    
    var imageString: String
    
    init(imageString: String) {
        self.imageString = imageString
    }
    
    var body: some View {
        Image(imageString)
    }
}
