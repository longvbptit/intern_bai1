//
//  SignUpViewController.swift
//  Bai_1_Intern
//
//  Created by Bảo Long on 08/05/2022.
//

import UIKit

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var phoneNum_view: UIView!
    @IBOutlet weak var continue_btn: UIButton!
    @IBOutlet weak var reigonNum_lb: UILabel!
    @IBOutlet weak var phoneNumber_tf: CustomTextField!
    
    @IBOutlet weak var hotLine_view: UIView!
    @IBOutlet weak var hotLine_label: UILabel!
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func continueOTP_act(_ sender: Any) {
        
        var phoneNumber = (phoneNumber_tf.text ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
        if phoneNumber.first == "0", phoneNumber.count > 9 {
            phoneNumber.removeFirst()
        }
        
        let vc = UIViewController.fromStoryboard(OTPViewController.self)
        vc.phoneNumberWithoutPrefix = phoneNumber
        self.navigationController?.pushViewController(vc, animated: true)
    }
  
   
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light 
        self.navigationController?.isNavigationBarHidden = true
        self.setupHideKeyboardOnTap()
        setUpView()
    }
    
    //MARK: set up view
    func setUpView(){
           
        continue_btn.clipsToBounds = true
        
        continue_btn.isEnabled = false
        
        reigonNum_lb.adjustsFontSizeToFitWidth = true
        reigonNum_lb.minimumScaleFactor = 0.5
        
        phoneNumber_tf.adjustsFontSizeToFitWidth = true
        phoneNumber_tf.minimumFontSize = 17
        phoneNumber_tf.placeholder = "Nhập số điện thoại"
        
        // create attributed string
        let myAttribute = [ NSAttributedString.Key.font: UIFont(name: Constants.Font.regular, size: 17.0)! ]
        let hotline = NSMutableAttributedString(string: "Hotline 1900 636 893", attributes: myAttribute )
        hotline.addAttribute(NSAttributedString.Key.foregroundColor, value: Constants.Color.greenBlue.cgColor, range: NSRange(location: 8, length: 12))

        // set attributed text on a UILabel
        hotLine_label.attributedText = hotline
        
        phoneNumber_tf.addTarget(self, action: #selector(SignUpViewController.textFieldEditingDidBegin(_:)), for: .editingDidBegin)
        phoneNumber_tf.addTarget(self, action: #selector(SignUpViewController.textFieldDidChange(_:)), for: .editingChanged)
        phoneNumber_tf.addTarget(self, action: #selector(SignUpViewController.textFieldEditingDidEnd(_:)), for: .editingDidEnd)
        
        //shadow
//        phoneNum_view.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
//        phoneNum_view.layer.shadowOpacity = 1
//        phoneNum_view.layer.shadowRadius = 20
//        phoneNum_view.layer.shadowOffset = CGSize(width: 0, height: 4)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        
        continue_btn.layer.cornerRadius = 24
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
    
    //MARK: Set event for text field phone number
    @objc func textFieldDidChange(_ textField: UITextField) {
    
        let phoneNum = phoneNumber_tf.text!
        if(phoneNum.count >= 9 && phoneNum.prefix(1) != "0"
            || phoneNum.prefix(1) == "0" && phoneNum.count >= 10){
            continue_btn.isEnabled = true
            continue_btn.alpha = 1
        }
        else {
            continue_btn.isEnabled = false
            continue_btn.alpha = 0.3
        }
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

