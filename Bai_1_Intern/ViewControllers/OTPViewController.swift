//
//  OTPViewController.swift
//  Bai_1_Intern
//
//  Created by Bảo Long on 19/05/2022.
//

import UIKit

class OTPViewController: UIViewController {
    
    var dateStart = Date()
    var timer : Timer? = nil
    var phoneNumberWithoutPrefix : String = ""
    
    //MARK: IBOutlet
    @IBOutlet weak var otpGuide_lb: UILabel!
    @IBOutlet weak var otp_stv: OTPStackView!
    @IBOutlet weak var otpError_lb: UILabel!
    @IBOutlet weak var resendOTP_btn: UIButton!
    @IBOutlet weak var continue_btn: UIButton!
    
    //MARK: IBAction
    @IBAction func back_btn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func resendOTPAct_btn(_ sender: Any) {
        restartCountDown()
    }
    
    @IBAction func btnContinueTapped(_ sender: Any) {
        if otp_stv.getOTPString() == "111111" {
            let vc = UIViewController.fromStoryboard(PatientHomeViewController.self)
            self.navigationController?.viewControllers = [vc]
        } else {
            updateErrorLabelUI(hidden: false)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        startCountDown()
        registerObserver()
        self.setupHideKeyboardOnTap()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeObserver()
    }
    
    private func updateResendOTPButtonUI(enable: Bool) {
        resendOTP_btn.isEnabled = enable
        resendOTP_btn.layer.borderColor = enable ? Constants.Color.greenBlue.cgColor : Constants.Color.gray4.cgColor
        resendOTP_btn.setTitleColor(enable ? Constants.Color.greenBlue : Constants.Color.gray4 , for: .normal)
    }
    
    private func updateContinueButtonUI(enable: Bool) {
        continue_btn.isEnabled = enable
        continue_btn.backgroundColor = enable ? Constants.Color.greenBlue : Constants.Color.greenBlue.withAlphaComponent(0.3)
    }
    
    private func updateErrorLabelUI(hidden: Bool) {
        otpError_lb.isHidden = hidden
    }
    
    //MARK: Setup view
    func setupView(){
        
        otpError_lb.isHidden = true
        self.updateResendOTPButtonUI(enable: false)
        
        let guide = "Vui lòng nhập mã gồm 6 chữ số đã được gửi đến bạn vào số điện thoại "
        let prefixPhoneNumber = "+84"
        let displayPhoneNumber = phoneNumberWithoutPrefix.split(by: 3, fromEnd: false).joined(separator: " ")
        let font = UIFont(name: Constants.Font.regular, size: 14)
        let phoneNumberfont = UIFont(name: Constants.Font.bold, size: 14)
        otpGuide_lb.attributedText = NSMutableAttributedString().attrStr(text: guide, font: font)
            .attrStr(text: prefixPhoneNumber + " " + displayPhoneNumber, font: phoneNumberfont)
        
        let otpFont = UIFont(name: Constants.Font.semiBold, size: 20)
        otp_stv.configTextFieldView(borderStyle: .none,
                                    font: otpFont,
                                    editingBorderColor: Constants.Color.greenBlue,
                                    nonEditingborderColor: .white,
                                    borderWidth: 1,
                                    cornerRadius: 8)
        
        otp_stv.otpValueDidChanged = {[weak self] in
            guard let self = self else { return}
            self.updateErrorLabelUI(hidden: true)
            self.updateContinueButtonUI(enable: $0.count == 6)
        }
        otp_stv.becomeFirstResponder()
        
        resendOTP_btn.layer.cornerRadius = 18
        resendOTP_btn.layer.borderWidth = 1
        
        continue_btn.layer.cornerRadius = 24
        updateContinueButtonUI(enable: false)
    }
    
    private func startCountDown(){
        let counter = Int(60 + dateStart.timeIntervalSinceNow)
        guard counter >= 0 else { return }
            
        var counterStr = counter < 10 ? "0\(counter)" : "\(counter)"
        counterStr += "s"
        resendOTP_btn.setTitle("Gửi lại mã sau" + " " + counterStr, for: .disabled)
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
    
    //MARK: Observer
    private func registerObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func removeObserver() {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue ?? .zero
        let duration = (notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double) ?? 0
        
        UIView.animate(withDuration: duration) {[weak self] in
            guard let self = self else { return}
            
            self.continue_btn.transform = CGAffineTransform(translationX: 0, y: -keyboardSize.height + self.safeAreaInsets.bottom)
        }
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        let duration = (notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double) ?? 0
        
        UIView.animate(withDuration: duration) {[weak self] in
            guard let self = self else { return}
            
            self.continue_btn.transform = .identity
        }
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
