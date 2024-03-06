//
//  Brightness.swift
//  CameraApp
//
//  Created by India Poetzscher on 3/6/24.
//

import Foundation
import UIKit

func isImageTooDark(image: UIImage) -> Bool {
    
    guard let imageData = image.jpegData(compressionQuality: 1.0),
          let cgImage = UIImage(data: imageData)?.cgImage else {
        return true // Assume it's too dark if we couldn't process the image
    }
    
    let width = cgImage.width
    let height = cgImage.height
    let colorSpace = CGColorSpaceCreateDeviceRGB()
    let bytesPerPixel = 4
    let bytesPerRow = bytesPerPixel * width
    let bitsPerComponent = 8
    let bitmapInfo = CGImageAlphaInfo.premultipliedLast.rawValue | CGBitmapInfo.byteOrder32Big.rawValue
    
    guard let context = CGContext(data: nil, width: width, height: height, bitsPerComponent: bitsPerComponent, bytesPerRow: bytesPerRow, space: colorSpace, bitmapInfo: bitmapInfo) else {
        return true // Assume it's too dark if we couldn't create context
    }
    
    context.draw(cgImage, in: CGRect(x: 0, y: 0, width: width, height: height))
    
    guard let pixelBuffer = context.data else {
        return true // Assume it's too dark if we couldn't get pixel buffer
    }
    
    let bufferPointer = pixelBuffer.bindMemory(to: UInt32.self, capacity: width * height)
    var totalBrightness: CGFloat = 0.0
    
    for y in 0..<height {
        for x in 0..<width {
            let pixel = bufferPointer[y * width + x]
            let red = CGFloat((pixel >> 16) & 0xFF)
            let green = CGFloat((pixel >> 8) & 0xFF)
            let blue = CGFloat(pixel & 0xFF)
            
            // Calculate brightness using Rec. 709 luma formula
            totalBrightness += 0.2126 * red + 0.7152 * green + 0.0722 * blue
        }
    }
    
    let averageBrightness = totalBrightness / CGFloat(width * height)
    
    // You can adjust this threshold based on your definition of "too dark"
    let darknessThreshold: CGFloat = 50.0
    
    return averageBrightness < darknessThreshold
}
