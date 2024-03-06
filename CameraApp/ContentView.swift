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
    
    @State var isShowing = false
    @State var image: UIImage?
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    
    var body: some View {
        NavigationView {
            VStack(spacing: 60) {
                Text("Select a photo from camera roll or take a photo to screen for melanoma")
                HStack {
                    Button {
                        isShowing = true
                        self.sourceType = .photoLibrary
                    } label: {
                        Text("upload a photo")
                            .fontWeight(.bold)
                    }
                    Spacer()
                    Button {
                        isShowing = true
                        self.sourceType = .camera
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
                    if isImageTooDark(image: image) {
                        Text("Image is too dark‼️")
                            .foregroundColor(.red)
                            .fontWeight(.bold)
                            .font(.title3)
                    } else {
                        Text("Image looks good✅")
                            .foregroundColor(.green)
                            .font(.title3)
                    }
                } else {
                    Text("")
                }
            }
            .padding()
            .navigationTitle("Melanoma Screener")
            .sheet(isPresented: $isShowing, content: {
                ImagePicker(image: $image, isShowing: $isShowing, sourceType: self.sourceType)
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
