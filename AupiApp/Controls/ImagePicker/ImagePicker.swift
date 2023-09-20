//
//  ImagePicker.swift
//  AupiApp
//
//  Created by Katherine Chambers on 2023/09/07.
//

import Foundation
import UIKit
import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
           let imagePicker = UIImagePickerController()
           imagePicker.sourceType = .photoLibrary
           imagePicker.delegate = context.coordinator
           return imagePicker
       }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context:   Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
         var parent: ImagePicker

         init(_ parent: ImagePicker) {
             self.parent = parent
         }

         func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
             if let image = info[.originalImage] as? UIImage {
                 parent.selectedImage = image
             }
             picker.dismiss(animated: true)
         }
     }
}
