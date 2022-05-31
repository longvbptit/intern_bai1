//
//  OTPStackView.swift
//  Bai_1_Intern
//
//  Created by Bảo Long on 25/05/2022.
//

import UIKit

@IBDesignable class OTPStackView: UIStackView {

    var textFieldArray = [OTPTextField]()
    var otpValueDidChanged: ((String) -> ())? = nil
    var editingBorderColor: UIColor? = nil
    var nonEditingborderColor: UIColor? = nil
    
    @IBInspectable var numberOfOTPdigit: Int = 6{
        didSet {
            setTextFields()
        }
    }
    private func setTextFields() {
        textFieldArray.forEach {
            $0.removeFromSuperview()
        }
        textFieldArray = []
        
        for i in 0..<numberOfOTPdigit {
            let field = OTPTextField()
            textFieldArray.append(field)
            addArrangedSubview(field)
            field.delegate = self
            if i != 0 {
                field.previousTextField = textFieldArray[i-1]
                textFieldArray[i-1].nextTextFiled = textFieldArray[i]
            }
            
            field.deleteBackwardHandler = { [weak self] in
                guard let self = self else { return}

                self.textFieldEditChanged(field)
            }
        }

        configTextFieldView()
    }
    
    @objc func textFieldEditChanged(_ textField: UITextField) {
        otpValueDidChanged?(getOTPString())
    }
    func getOTPString() -> String {
        let otps = textFieldArray.compactMap({ $0.text}).joined()
        return otps
    }
    
    func configTextFieldView(backgroundColor: UIColor = .white,
                             textAlignment: NSTextAlignment = .center,
                             borderStyle: UITextField.BorderStyle = .roundedRect,
                             font: UIFont? = .systemFont(ofSize: 20),
                             keyboardType: UIKeyboardType = .numberPad,
                             editingBorderColor: UIColor? = nil,
                             nonEditingborderColor: UIColor? = nil,
                             borderWidth: CGFloat = 0,
                             cornerRadius: CGFloat = 0) {
        
        textFieldArray.forEach {
            $0.backgroundColor = backgroundColor
            $0.textAlignment = textAlignment
            $0.borderStyle = borderStyle
            $0.font = font
            $0.keyboardType = .numberPad
            $0.layer.masksToBounds = true
            $0.layer.borderWidth = borderWidth
            $0.layer.borderColor = UIColor.clear.cgColor
            $0.layer.cornerRadius = cornerRadius
            $0.layer.borderColor = nonEditingborderColor?.cgColor
        }
        self.nonEditingborderColor = nonEditingborderColor
        self.editingBorderColor = editingBorderColor
    }
    
    @discardableResult override func becomeFirstResponder() -> Bool {
        return textFieldArray.first?.becomeFirstResponder() ?? false
    }

}

extension OTPStackView: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {

        let shoudEdit = textFieldArray.first(where: { $0.text?.isEmpty == true}) ?? textField

        if shoudEdit == textField {
            textField.layer.borderColor = editingBorderColor?.cgColor
            return true
        } else {
            shoudEdit.becomeFirstResponder()
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderColor = nonEditingborderColor?.cgColor
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let field = textField as? OTPTextField else {
            return true
        }
        if string.isEmpty == false {
            field.text = string
            field.nextTextFiled?.becomeFirstResponder()
            textFieldEditChanged(field)
            
            return false
        }
        return true
    }
}

class OTPTextField: UITextField {
    weak var previousTextField: UITextField?
    weak var nextTextFiled: UITextField?
    
    var deleteBackwardHandler: (() -> Void)? = nil
    
    override func deleteBackward() {
        if text?.isEmpty == true {
            previousTextField?.text = ""
        }
        text = ""
        deleteBackwardHandler?()
        previousTextField?.becomeFirstResponder()
    }
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(UIResponderStandardEditActions.paste(_:)) {
            return false
        }
        return super.canPerformAction(action, withSender: sender)
    }
}

