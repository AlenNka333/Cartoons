//
//  SwiftUIImagePicker.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 11/12/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import SwiftUI
import UIKit

struct SwiftUIImagePicker: UIViewControllerRepresentable {
    var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @Binding var image: Image
    @Binding var isPresented: Bool
    @Binding var imageData: Data?
    
    func makeCoordinator() -> ImagePickerCoordinator {
        return ImagePickerCoordinator(image: $image, isPresented: $isPresented, imageData: $imageData)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<SwiftUIImagePicker>) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = false
        imagePicker.sourceType = sourceType
        imagePicker.delegate = context.coordinator
        
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<SwiftUIImagePicker>) {
    }
}

class ImagePickerCoordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    @Binding var image: Image
    @Binding var isPresented: Bool
    @Binding var imageData: Data?
    
    init(image: Binding<Image>, isPresented: Binding<Bool>, imageData: Binding<Data?>) {
        self._image = image
        self._isPresented = isPresented
        self._imageData = imageData
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.image = Image(uiImage: image)
            guard let imageData = image.jpegData(compressionQuality: 0.5) else {
                return
            }
            self.imageData = imageData
        }
        self.isPresented = false
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.isPresented = false
    }
}
