//
//  ContentView.swift
//  CameraApp
//
//  Created by India Poetzscher on 5/27/23.
//

import SwiftUI
import Foundation
import UIKit


struct ContentView: View {
    
    let imageName = "image2"
    @State var isShowing = false
    @State var image: UIImage?
    @State var sourceType: UIImagePickerController.SourceType
    
    var body: some View {
        NavigationView {
            VStack(spacing: 60) {
                Text("Select a photo from camera roll or take a photo to screen for melanoma")
                HStack {
                    Button {
                        self.sourceType = .photoLibrary
                        isShowing = true
                        
                    } label: {
                        Text("upload a photo")
                            .fontWeight(.bold)
                    }
                    Spacer()
                    Button {
                        self.sourceType = .camera
                        isShowing = true
                        
                    } label: {
                        Text("take photo")
                            .fontWeight(.bold)
                    }
                }.padding(.horizontal, 40)
                Image(uiImage: image ?? UIImage(named: "Image")!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                Spacer()
                
                if let image = image {
                    if isImageTooDark(image: image) && isImageBlurred(image: image) {
                        Text("Image is too blurry and too dark")
                    } else if isImageBlurred(image: image) {
                        Text("Image is blurry but brightness looks good!")

                    } else if isImageTooDark(image: image) {
                        Text("Image is clear but too dark")
                    } else {
                        Text("Image looks good!")
                    }
                } else {
                    Text("")
                }
            }
            .padding()
            .navigationTitle("Melanoma Screener")
            .sheet(isPresented: $isShowing, content: {
                ImagePicker(image: $image, isShowing: $isShowing, sourceType: self.$sourceType)
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(sourceType: .camera)
    }
}


//                if let image = image {
//                    if isImageBlurred(image: image) {
//                        Text("Image is too blury‼️")
//                            .foregroundColor(.red)
//                            .fontWeight(.bold)
//                            .font(.title3)
//                    } else {
//                        Text("Image is good✅")
//                            .foregroundColor(.green)
//                            .font(.title3)
//                    }
//                } else {
//                    Text("")
//                }
