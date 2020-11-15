//
//  ImageLoader.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 11/12/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import Combine
import SwiftUI
import UIKit

class ImageLoader: ObservableObject {
    @Published var image = Image(uiImage: R.image.profile_icon().unwrapped)
    
    func load(_ path: URL) {
        let task = URLSession.shared.dataTask(with: path) { data, _, _ in
            guard let data = data else {
                return
            }
            DispatchQueue.main.async {
                self.image = Image(uiImage: UIImage(data: data) ?? R.image.profile_icon().unwrapped)
            }
        }
        task.resume()
    }
}
