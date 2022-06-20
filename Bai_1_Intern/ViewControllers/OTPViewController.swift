//
//  OTPViewController.swift
//  Bai_1_Intern
//
//  Created by Bảo Long on 19/05/2022.
//

import UIKit
import IQKeyboardManager

class OTPViewController: UIViewController {
    
    var dateStart = Date()
    var timer : Timer? = nil
    var phoneNumberWithoutPrefix : String = ""
    
    //MARK: - IBOutlet
    @IBOutlet weak var lblOtpGuid: UILabel!
    @IBOutlet weak var stvOtp: OTPStackView!
    @IBOutlet weak var lblOtpError: UILabel!
    @IBOutlet weak var btnResendOTP: UIButton!
    @IBOutlet weak var btnContinue: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        startCountDown()
        registerObserver()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeObserver()
    }
    
    private func updateResendOTPButtonUI(enable: Bool) {
        btnResendOTP.isEnabled = enable
        btnResendOTP.layer.borderColor = enable ? Constants.Color.greenBlue.cgColor : Constants.Color.gray4.cgColor
        btnResendOTP.setTitleColor(enable ? Constants.Color.greenBlue : Constants.Color.gray4 , for: .normal)
    }
    
    private func updateContinueButtonUI(enable: Bool) {
        btnContinue.isEnabled = enable
        btnContinue.backgroundColor = enable ? Constants.Color.greenBlue : Constants.Color.greenBlue.withAlphaComponent(0.3)
    }
    
    private func updateErrorLabelUI(hidden: Bool) {
        lblOtpError.isHidden = hidden
    }
    
    //MARK: - Setup view
    func setupView(){
        
        lblOtpError.isHidden = true
        self.updateResendOTPButtonUI(enable: false)
        IQKeyboardManager.shared().previousNextDisplayMode = .alwaysHide
        
        let guide = "Vui lòng nhập mã gồm 6 chữ số đã được gửi đến bạn vào số điện thoại "
        let prefixPhoneNumber = "+84"
        let displayPhoneNumber = phoneNumberWithoutPrefix.split(by: 3, fromEnd: false).joined(separator: " ")
        let font = UIFont(name: Constants.Font.regular, size: 14)
        let phoneNumberfont = UIFont(name: Constants.Font.bold, size: 14)
        lblOtpGuid.attributedText = NSMutableAttributedString().attrStr(text: guide, font: font)
            .attrStr(text: prefixPhoneNumber + " " + displayPhoneNumber, font: phoneNumberfont)
        
        let otpFont = UIFont(name: Constants.Font.semiBold, size: 20)
        stvOtp.configTextFieldView(borderStyle: .none,
                                   font: otpFont,
                                   editingBorderColor: Constants.Color.greenBlue,
                                   nonEditingborderColor: .white,
                                   borderWidth: 1,
                                   cornerRadius: 8)
        
        stvOtp.otpValueDidChanged = {[weak self] in
            guard let self = self else { return}
            self.updateErrorLabelUI(hidden: true)
            self.updateContinueButtonUI(enable: $0.count == 6)
        }
        stvOtp.becomeFirstResponder()
        
        btnResendOTP.layer.cornerRadius = 18
        btnResendOTP.layer.borderWidth = 1
        
        btnContinue.layer.cornerRadius = 24
        updateContinueButtonUI(enable: false)
    }
    
    private func startCountDown(){
        let counter = Int(60 + dateStart.timeIntervalSinceNow)
        guard counter >= 0 else { return }
        //        var counterStr = counter < 10 ? "0\(counter)" : "\(counter)"
        btnResendOTP.setTitle("Gửi lại mã sau \(counter)s", for: .disabled)
        if counter == 0 {
            self.updateResendOTPButtonUI(enable: true)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1)
        {[weak self] in
            guard let self = self else { return }
            self.startCountDown()
        }
    }
    
    private func restartCountDown() {
        dateStart = Date()
        updateResendOTPButtonUI(enable: false)
        startCountDown()
    }
    
    //MARK: - Observer
    private func registerObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func removeObserver() {
        NotificationCenter.default.removeObserver(self)
    }
    
    //MARK: - IBAction
    @IBAction func back_btn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnResendOTPTapped(_ sender: Any) {
        restartCountDown()
    }
    
    @IBAction func btnContinueTapped(_ sender: Any) {
        if stvOtp.getOTPString() == "111111" {
            let vc = UIViewController.fromStoryboard(PatientHomeViewController.self)
            self.navigationController?.viewControllers = [vc]
        } else {
            updateErrorLabelUI(hidden: false)
        }
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue ?? .zero
        let duration = (notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double) ?? 0
        
        UIView.animate(withDuration: duration) {[weak self] in
            guard let self = self else { return}
            
            self.btnContinue.transform = CGAffineTransform(translationX: 0, y: -keyboardSize.height + self.safeAreaInsets.bottom)
        }
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        let duration = (notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double) ?? 0
        
        UIView.animate(withDuration: duration) {[weak self] in
            guard let self = self else { return}
            
            self.btnContinue.transform = .identity
        }
    }
}
