import SwiftUI
import CoreImage
import UIKit

func isImageTooDark(image: UIImage) -> Bool {
        guard let cgImage = image.cgImage else {
            return true // Assume it's too dark if we couldn't get CGImage
        }
        
        let width = cgImage.width
        let height = cgImage.height
        let bytesPerPixel = 4
        let bytesPerRow = width * bytesPerPixel
        
        guard let imageData = cgImage.dataProvider?.data,
              let data: UnsafePointer<UInt8> = CFDataGetBytePtr(imageData) else {
            return true // Assume it's too dark if we couldn't get image data
        }
        
        var totalBrightness: CGFloat = 0.0
        
        DispatchQueue.concurrentPerform(iterations: height) { y in
            let startIndex = y * bytesPerRow
            let endIndex = startIndex + width * bytesPerPixel
            
            for x in stride(from: startIndex, to: endIndex, by: bytesPerPixel) {
                let red = CGFloat(data[x])
                let green = CGFloat(data[x + 1])
                let blue = CGFloat(data[x + 2])
                
                // Calculate brightness using Rec. 709 luma formula
                totalBrightness += 0.2126 * red + 0.7152 * green + 0.0722 * blue
            }
        }
        
        let averageBrightness = totalBrightness / CGFloat(width * height)
        
        // You can adjust this threshold based on your definition of "too dark"
        let darknessThreshold: CGFloat = 50.0
        
        return averageBrightness < darknessThreshold
    }

