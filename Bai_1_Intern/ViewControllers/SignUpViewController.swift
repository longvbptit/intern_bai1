//
//  SignUpViewController.swift
//  Bai_1_Intern
//
//  Created by Bảo Long on 08/05/2022.
//

import UIKit

class SignUpViewController: UIViewController {
    
    //MARK: - IBOutlet
    @IBOutlet weak var phoneNum_view: UIView!
    @IBOutlet weak var btnContinue: UIButton!
    @IBOutlet weak var lblReigonNumber: UILabel!
    @IBOutlet weak var txtPhoneNumber: UITextField!
    @IBOutlet weak var hotLine_view: UIView!
    @IBOutlet weak var lblHotline: UILabel!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        self.setupHideKeyboardOnTap()
        setUpView()
    }
    
    //MARK: - set up view
    func setUpView(){
        
        btnContinue.isEnabled = false
        
        txtPhoneNumber.minimumFontSize = 17
        txtPhoneNumber.placeholder = "Nhập số điện thoại"
        
        let hotline = "Hotline "
        let phoneNumber = "1900 6036 893"
        let font = UIFont(name: Constants.Font.regular, size: 17)
        let phoneNumberfont = UIFont(name: Constants.Font.bold, size: 17)
        lblHotline.attributedText = NSMutableAttributedString().attrStr(text: hotline, font: font)
            .attrStr(text: phoneNumber, font: phoneNumberfont, textColor: Constants.Color.greenBlue)
        
        txtPhoneNumber.addTarget(self, action: #selector(SignUpViewController.textFieldEditingDidBegin(_:)), for: .editingDidBegin)
        txtPhoneNumber.addTarget(self, action: #selector(SignUpViewController.textFieldDidChange(_:)), for: .editingChanged)
        txtPhoneNumber.addTarget(self, action: #selector(SignUpViewController.textFieldEditingDidEnd(_:)), for: .editingDidEnd)
    
        btnContinue.layer.cornerRadius = 24
        hotLine_view.layer.cornerRadius = 24
        
        // shadow
        phoneNum_view.layer.cornerRadius = 28
        phoneNum_view.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
        phoneNum_view.layer.shadowOpacity = 1
        phoneNum_view.layer.shadowRadius = 20
        phoneNum_view.layer.shadowOffset = CGSize(width: 0, height: 4)
        phoneNum_view.layer.borderColor = Constants.Color.borderGray.cgColor
        phoneNum_view.layer.borderWidth = 1
    }
    
    //MARK: - Set event for text field phone number
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        guard let phoneNum = txtPhoneNumber.text else {
            txtPhoneNumber.insertText("")
            return
        }
        if(phoneNum.count > 8 && phoneNum.prefix(1) != "0"
            || phoneNum.prefix(1) == "0" && phoneNum.count > 9){
            btnContinue.isEnabled = true
            btnContinue.alpha = 1
        }
        else {
            btnContinue.isEnabled = false
            btnContinue.alpha = 0.3
        }
    }
    
    //MARK: - IBAction
    @IBAction func btnBackTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnContinueTapped(_ sender: Any) {
        
        var phoneNumber = (txtPhoneNumber.text ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
        if phoneNumber.first == "0", phoneNumber.count > 9 {
            phoneNumber.removeFirst()
        }
        
        let vc = UIViewController.fromStoryboard(OTPViewController.self)
        vc.phoneNumberWithoutPrefix = phoneNumber
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //change hightlight color
    @objc func textFieldEditingDidBegin(_ textField: UITextField) {
        phoneNum_view.layer.borderColor = Constants.Color.greenBlue.cgColor
    }
    @objc func textFieldEditingDidEnd(_ textField: UITextField){
        phoneNum_view.layer.borderColor = Constants.Color.borderGray.cgColor
    }
    
    //hide keyboard and end editing
    func setupHideKeyboardOnTap() {
        self.view.addGestureRecognizer(self.endEditingRecognizer())
        self.navigationController?.navigationBar.addGestureRecognizer(self.endEditingRecognizer())
    }
    private func endEditingRecognizer() -> UIGestureRecognizer {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(self.view.endEditing(_:)))
        tap.cancelsTouchesInView = false
        return tap
    }
}

