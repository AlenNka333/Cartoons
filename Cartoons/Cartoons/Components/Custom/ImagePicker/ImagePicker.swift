//
//  ImagePicker.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 9/28/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import UIKit

class ImagePicker: NSObject {
    private let pickerController: UIImagePickerController
    private weak var presentationController: UIViewController?
    var closure: ((Result<UIImage?, Error>) -> Void)?
    
    init(presentationController: UIViewController) {
        self.pickerController = UIImagePickerController()
        super.init()
        self.presentationController = presentationController
        
        self.pickerController.delegate = self
        self.pickerController.allowsEditing = true
        self.pickerController.mediaTypes = ["public.image"]
    }
    
    func present(completion: ((Result<UIImage?, Error>) -> Void)? = nil) {
        closure = completion
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: R.string.localizable.take_a_photo(), style: .default) { [unowned self] _ in
            guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
                closure?(.failure(AccessErrors.noCameraPermission))
                return
            }
            self.pickerController.sourceType = .camera
            self.presentationController?.present(self.pickerController, animated: true)
        }
        alertController.addAction(cameraAction)
        let libraryAction = UIAlertAction(title: R.string.localizable.choose_from_library(), style: .default) { [unowned self] _ in
            guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else {
                closure?(.failure(AccessErrors.noLibraryPermission))
                return
            }
            self.pickerController.sourceType = .photoLibrary
            self.presentationController?.present(self.pickerController, animated: true)
        }
        alertController.addAction(libraryAction)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.presentationController?.present(alertController, animated: true)
    }
    
    private func pickerController(_ controller: UIImagePickerController, didSelect image: UIImage?) {
        controller.dismiss(animated: true, completion: nil)
        closure?(.success(image))
    }
}

extension ImagePicker: UIImagePickerControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.pickerController(picker, didSelect: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else {
            return  self.pickerController(picker, didSelect: nil)
        }
        self.pickerController(picker, didSelect: image)
    }
}

extension ImagePicker: UINavigationControllerDelegate {
}
