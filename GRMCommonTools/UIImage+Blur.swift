//
//  UIImage+Blur.swift
//  Pods
//
//  Created by Frederick Lee on 23/06/2017.
//
//

import UIKit
import CoreImage

extension UIImageView {
    public func blur(radius r:UInt = 5) {
        var radius:UInt = r
        if r > 20 {
            radius = 20
        }
        let context = CIContext(options: nil)
        if let image = self.image,
           let currentFilter = CIFilter(name: "CIGaussianBlur"),
           let cropFilter = CIFilter(name: "CICrop") {
            let beginImage = CIImage(image: image)
            currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
            currentFilter.setValue(radius, forKey: kCIInputRadiusKey)

            cropFilter.setValue(currentFilter.outputImage, forKey: kCIInputImageKey)
            cropFilter.setValue(CIVector(cgRect: beginImage!.extent), forKey: "inputRectangle")

            if let output = cropFilter.outputImage, let cgimg = context.createCGImage(output, from: output.extent) {
                self.backgroundColor = .black
                self.image = UIImage(cgImage: cgimg)
            }
        }
    }
}
