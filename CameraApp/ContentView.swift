//
//  ContentView.swift
//  CameraApp
//
//  Created by India Poetzscher on 5/27/23.
//

import SwiftUI

struct ContentView: View {
    
    @State var isShowing = false
    @State var image: UIImage?
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    
    var body: some View {
        VStack {
            Image(uiImage: image ?? UIImage(named: "Image")!)
                .resizable()
                .aspectRatio(contentMode: .fit)
            HStack {
                Button {
                    isShowing = true
                    self.sourceType = .photoLibrary
                } label: {
                    Text("choose photo")
                }
                Spacer()
                Button {
                    isShowing = true
                    self.sourceType = .camera
                } label: {
                    Text("take photo")
                }
            }
            .padding(.horizontal, 40)
        }
        .sheet(isPresented: $isShowing, content: {
            ImagePicker(image: $image, isShowing: $isShowing, sourceType: self.sourceType)
        })
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
