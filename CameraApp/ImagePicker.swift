//
//  ImagePicker.swift
//  CameraApp
//
//  Created by India Poetzscher on 5/27/23.
//

import SwiftUI
import UIKit

struct ImagePicker: UIViewControllerRepresentable {
    
    @Binding var image: UIImage?
    @Binding var isShowing: Bool
    var sourceType: UIImagePickerController.SourceType
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = self.sourceType
        imagePicker.delegate = context.coordinator
        return imagePicker
    }
    
    func updateUIViewController() {
        
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
        }
    
}

class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var parent: ImagePicker
        
        init(_ picker: ImagePicker) {
            self.parent = picker
        }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image1 = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                    DispatchQueue.main.async {
                        self.parent.image = image1
                    }
                }
        parent.isShowing = false
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        parent.isShowing = false
    }
    
}
