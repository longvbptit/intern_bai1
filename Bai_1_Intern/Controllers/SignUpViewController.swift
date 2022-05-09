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
    @IBOutlet weak var phoneNumber_tf: UITextField!
    
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        phoneNum_view.clipsToBounds = true
        phoneNum_view.layer.cornerRadius = phoneNum_view.frame.size.height
        phoneNum_view.layer.borderColor = (UIColor.gray).cgColor
        phoneNum_view.layer.borderWidth = 0.1
        
        // shadow
        phoneNum_view.layer.shadowColor = UIColor.lightGray.cgColor
        phoneNum_view.layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
        
        continue_btn.clipsToBounds = true
        continue_btn.layer.cornerRadius = phoneNum_view.frame.size.height
        continue_btn.titleLabel?.adjustsFontSizeToFitWidth = true
        continue_btn.titleLabel?.minimumScaleFactor = 0.5
        continue_btn.isEnabled = false
        
        //Auto Resize font
        reigonNum_lb.adjustsFontSizeToFitWidth = true
        reigonNum_lb.minimumScaleFactor = 0.5
        
        phoneNumber_tf.adjustsFontSizeToFitWidth = true
        phoneNumber_tf.minimumFontSize = 10
        phoneNumber_tf.placeholder = "Nhập số điện thoại"
        phoneNumber_tf.textContentType = UITextContentType.telephoneNumber
        
//        phoneNumber_tf.clear = true
        phoneNumber_tf.font = UIFont.init(name: "Nunito Sans", size: 50)
        phoneNumber_tf.keyboardType = UIKeyboardType.numberPad
    
        phoneNumber_tf.addTarget(self, action: #selector(SignUpViewController.textFieldDidChange(_:)), for: .editingChanged)
//        
    
        // Do any additional setup after loading the view.
    }
    @objc func textFieldDidChange(_ textField: UITextField) {
        phoneNum_view.layer.borderColor = (UIColor.green).cgColor
//        CGColor.init(red: 44, green: 134, blue: 103,alpha: 100)
        phoneNum_view.layer.borderWidth = 1
        let phoneNum = phoneNumber_tf.text!
        if(phoneNum.count >= 9 && phoneNum.prefix(1) != "0"
            || phoneNum.prefix(1) == "0" && phoneNum.count >= 10){
            continue_btn.isEnabled = true
            continue_btn.alpha = 1
        }
        else {
            continue_btn.isEnabled = false
            continue_btn.alpha = 0.5
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
