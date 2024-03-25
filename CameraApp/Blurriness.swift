//
//  Blurriness.swift
//  CameraApp
//
//  Created by India Poetzscher on 3/6/24.
//

import SwiftUI
import CoreImage
import UIKit
import Accelerate.vImage



func isImageBlurred(image: UIImage) -> Bool {
        guard let cgImage = image.cgImage else {
            return true // Assume it's blurred if we couldn't get CGImage
        }
        
        let ciImage = CIImage(cgImage: cgImage)
        let context = CIContext()
        
        // Apply blur filter
        guard let filter = CIFilter(name: "CIGaussianBlur") else {
            return true // Failed to create blur filter
        }
        filter.setValue(ciImage, forKey: kCIInputImageKey)
        filter.setValue(10.0, forKey: kCIInputRadiusKey) // Adjust the blur radius as needed
        
        guard let outputImage = filter.outputImage else {
            return true // Failed to get output image from blur filter
        }
        
        // Render the output image to calculate average brightness
        guard let renderedCGImage = context.createCGImage(outputImage, from: outputImage.extent) else {
            return true // Failed to render output image
        }
        
        let imageData = renderedCGImage.dataProvider?.data as Data?
        let pixelData = imageData?.withUnsafeBytes { Data(bytes: $0.baseAddress!, count: imageData?.count ?? 0) }
        
        // Calculate average brightness
        var brightnessSum: UInt64 = 0
        pixelData?.forEach { byte in
            brightnessSum += UInt64(byte)
        }
        
        let averageBrightness = Double(brightnessSum) / Double(pixelData?.count ?? 1)
        
        // Define a threshold for determining blurriness
        let blurThreshold: Double = 180.0
        
        return averageBrightness < blurThreshold
    }

