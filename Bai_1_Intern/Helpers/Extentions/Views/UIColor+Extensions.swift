//
//  ColorExtension.swift
//  EcaproMonitoring
//
//  Created by Quang Thai macbook on 11/29/19.
//  Copyright © 2019 HUNG ANH LE. All rights reserved.
//

import Foundation
import UIKit

//extension UIImage {
//
//  func transform(withNewColor color: UIColor) -> UIImage {
//      UIGraphicsBeginImageContextWithOptions(size, false, scale)
//
//      let context = UIGraphicsGetCurrentContext()!
//      context.translateBy(x: 0, y: size.height)
//      context.scaleBy(x: 1.0, y: -1.0)
//      context.setBlendMode(.normal)
//
//      let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
//      context.clip(to: rect, mask: cgImage!)
//
//      color.setFill()
//      context.fill(rect)
//
//      let newImage = UIGraphicsGetImageFromCurrentImageContext()!
//      UIGraphicsEndImageContext()
//      return newImage
//  }
//}

//MARK: ARGB
extension UIColor {
    convenience init(red: UInt8, green: UInt8, blue: UInt8, alpha: UInt8) {
        self.init(
            red: CGFloat(red)/255,
            green: CGFloat(green)/255,
            blue: CGFloat(blue)/255,
            alpha: CGFloat(alpha)/255)
    }
    
    func toARGB255() -> (alpha: UInt8, red: UInt8, green: UInt8, blue: UInt8)? {
        guard let components = self.cgColor.components, components.count >= 3 else {
            return nil
        }
        
        let alpha =     UInt8((self.cgColor.components?[3] ?? 0) * 255)
        
        let red =       UInt8((self.cgColor.components?[0] ?? 0) * 255)
        let green =     UInt8((self.cgColor.components?[1] ?? 0) * 255)
        let blue =      UInt8((self.cgColor.components?[2] ?? 0) * 255)
        
        return (alpha, red, green, blue)
    }
}


//MARK: HEX
extension UIColor {
    
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
    
    func toHex(withAlpha: Bool = true) -> String? {
        // Extract Components
        guard let components = self.cgColor.components, components.count >= 3 else {
            return nil
        }
        
        // Helpers
        let r = Float(components[0])
        let g = Float(components[1])
        let b = Float(components[2])
        var a = Float(1.0)
        
        if components.count >= 4 {
            a = Float(components[3])
        }
        
        let alpha = String(format: "%02lX", lroundf(a * 255))
        
        // Create Hex String
        let hex = String(format: "%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255))
        
        let result = withAlpha ? alpha + hex : hex
        
        return "\(result)"
    }
}
