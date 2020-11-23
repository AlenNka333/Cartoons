//
//  NavigationModifier.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 11/12/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import SwiftUI

struct NavigationBarModifier: ViewModifier {
    var backgroundColor: UIColor?
    
    init(backgroundColor: UIColor?) {
        self.backgroundColor = backgroundColor
    }
    
    func body(content: Content) -> some View {
        ZStack {
            content
            VStack {
                GeometryReader { geometry in
                    Color(self.backgroundColor ?? .clear)
                        .frame(height: geometry.safeAreaInsets.top)
                        .edgesIgnoringSafeArea(.top)
                        .shadow(color: .black, radius: 3, x: 3, y: 3)
                    Spacer()
                }
            }
        }
    }
}
