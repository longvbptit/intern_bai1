//
//  UIViewController+Extensions.swift
//  Bai_1_Intern
//
//  Created by Bảo Long on 31/05/2022.
//

import Foundation
import UIKit

extension UIViewController {
    class func fromStoryboard <T: UIViewController> (_ vc: T.Type,
                              storyboardName: String = "Main",
                              bundle: Bundle? = nil) -> T {
        
        let storyBoard = UIStoryboard(name: storyboardName, bundle: bundle)
        let identifier = String(describing: vc)
        let vc = storyBoard.instantiateViewController(withIdentifier: identifier) as! T
        
        return vc
    }
    
    var safeAreaInsets: UIEdgeInsets {
        if #available(iOS 11.0, *) {
            let window = UIApplication.shared.keyWindow
            return window?.safeAreaInsets ?? .zero
        }
        
        if #available(iOS 13.0, *) {
            let window = UIApplication.shared.windows[0]
            return window.safeAreaInsets
        }
        
        return .zero
    }
    
}
