//
//  CustomTextField.swift
//  Bai_1_Intern
//
//  Created by Bảo Long on 19/05/2022.
//

import UIKit

class CustomTextField: UITextField {

    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
         if action == #selector(UIResponderStandardEditActions.paste(_:)) {
             return false
         }
         return super.canPerformAction(action, withSender: sender)
    }
		
}
