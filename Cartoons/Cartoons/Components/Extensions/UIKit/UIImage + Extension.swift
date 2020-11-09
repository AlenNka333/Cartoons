//
//  UIImage + Extension.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 10/20/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import AVFoundation
import Foundation
import UIKit

extension UIImage {
    static func generateThumbnail(asset: AVURLAsset) -> UIImage? {
        do {
            let imageGenerator = AVAssetImageGenerator(asset: asset)
            imageGenerator.appliesPreferredTrackTransform = true
            let cgImage = try imageGenerator.copyCGImage(at: .zero, actualTime: nil)
            return UIImage(cgImage: cgImage)
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}
