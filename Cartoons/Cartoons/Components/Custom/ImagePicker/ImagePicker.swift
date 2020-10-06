//
//  ImagePicker.swift
//  Cartoons
//
//  Created by Alena Nesterkina on 9/28/20.
//  Copyright © 2020 AlenaNesterkina. All rights reserved.
//

import PhotosUI
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
        let cameraAction = UIAlertAction(title: R.string.localizable.take_a_photo(), style: .default) { [weak self] _ in
            guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
                self?.closure?(.failure(AccessErrors.cameraNotAvailable))
                return
            }
            self?.checkCameraAccessPermission {
                guard let pickerController = self?.pickerController else {
                    return
                }
                if $0 {
                    self?.pickerController.sourceType = .camera
                    self?.presentationController?.present(pickerController, animated: true)
                } else {
                    self?.closure?(.failure(AccessErrors.noCameraPermission))
                }
            }
        }
        
        alertController.addAction(cameraAction)
        let libraryAction = UIAlertAction(title: R.string.localizable.choose_from_library(), style: .default) { [weak self] _ in
            guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else {
                self?.closure?(.failure(AccessErrors.libraryNotAvailable))
                return
            }
            self?.checkPhotoAccessPermission {
                guard let pickerController = self?.pickerController else {
                    return
                }
                if $0 {
                    self?.pickerController.sourceType = .photoLibrary
                    self?.presentationController?.present(pickerController, animated: true)
                } else {
                    self?.closure?(.failure(AccessErrors.noLibraryPermission))
                }
            }
        }
        alertController.addAction(libraryAction)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.presentationController?.present(alertController, animated: true)
    }
    
    func checkPhotoAccessPermission(completion: @escaping (Bool) -> Void) {
        let status = PHPhotoLibrary.authorizationStatus()
        switch status {
        case .authorized:
            completion(true)
        case .denied, .restricted:
            completion(false)
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization({
                if $0 == .authorized {
                    DispatchQueue.main.async {
                        completion(true)
                    }
                }
            })
        case .limited:
            break
        }
    }
    
    func checkCameraAccessPermission(completion: @escaping (Bool) -> Void) {
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        switch status {
        case .authorized:
            completion(true)
        case .denied, .restricted:
            completion(false)
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) {
                if $0 {
                    DispatchQueue.main.async {
                        completion(true)
                    }
                }
            }
        }
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
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        guard let image = info[.editedImage] as? UIImage else {
            return  self.pickerController(picker, didSelect: nil)
        }
        self.pickerController(picker, didSelect: image)
    }
}

extension ImagePicker: UINavigationControllerDelegate {
}
