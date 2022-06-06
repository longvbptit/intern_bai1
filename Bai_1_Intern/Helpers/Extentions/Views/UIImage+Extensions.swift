//
//  UIImage+Extensions.swift
//  Bai_1_Intern
//
//  Created by Bảo Long on 06/06/2022.
//

import Foundation
import UIKit

extension UIImage {
  class func imageWithColor(color: UIColor) -> UIImage {
    let rect: CGRect = CGRect(x: 0, y: 0, width: 1, height: 1)
    UIGraphicsBeginImageContextWithOptions(CGSize(width: 1, height: 1), false, 0)
    color.setFill()
    UIRectFill(rect)
    let image: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return image!
  }
}
