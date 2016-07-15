//
//  Utils.swift
//  Na4Łapy
//
//  Created by mac on 09/07/2016.
//  Copyright © 2016 Koduj dla Polski. All rights reserved.
//

import Foundation
import UIKit

class Utils {

    static func resizeImage(image: UIImage, newSize: CGSize) -> (UIImage) {
        let newRect = CGRectIntegral(CGRectMake(0,0, newSize.width/2, newSize.height/2))
        let imageRef = image.CGImage
    
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0)
        let context = UIGraphicsGetCurrentContext()
    
        // Set the quality level to use when rescaling
        CGContextSetInterpolationQuality(context, CGInterpolationQuality.High)
        let flipVertical = CGAffineTransformMake(1, 0, 0, -1, 0, newSize.height/2)
    
        CGContextConcatCTM(context, flipVertical)
        // Draw into the context; this scales the image
        CGContextDrawImage(context, newRect, imageRef)
    
        let newImageRef = CGBitmapContextCreateImage(context)
        let newImage = UIImage(CGImage: newImageRef!)
    
        // Get the resized image from the context and a UIImage
        UIGraphicsEndImageContext()
    
        return newImage
        }
}
