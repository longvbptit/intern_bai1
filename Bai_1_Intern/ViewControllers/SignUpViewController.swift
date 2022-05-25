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
    
    @IBAction func contunueOPT_btn(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "OTPViewController") as? OTPViewController
        self.navigationController?.pushViewController(vc!, animated: true)
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
        phoneNum_view.clipsToBounds = true
        
        phoneNum_view.layer.borderColor = #colorLiteral(red: 0.9332506061, green: 0.9373078942, blue: 0.9567487836, alpha: 1)
        phoneNum_view.layer.borderWidth = 1
           
        continue_btn.clipsToBounds = true
        
        continue_btn.isEnabled = false
        
        reigonNum_lb.adjustsFontSizeToFitWidth = true
        reigonNum_lb.minimumScaleFactor = 0.5
        
        phoneNumber_tf.adjustsFontSizeToFitWidth = true
        phoneNumber_tf.minimumFontSize = 17
        phoneNumber_tf.placeholder = "Nhập số điện thoại"
        
        // create attributed string
        let myAttribute = [ NSAttributedString.Key.font: UIFont(name: "NunitoSans-Regular", size: 17.0)! ]
        let hotline = NSMutableAttributedString(string: "Hotline 1900 636 893", attributes: myAttribute )
        var myRange = NSRange(location: 8, length: 12) // range starting at
        hotline.addAttribute(NSAttributedString.Key.foregroundColor, value: #colorLiteral(red: 0.1723190546, green: 0.5255185366, blue: 0.4038655162, alpha: 1).cgColor, range: myRange)

        // set attributed text on a UILabel
        hotLine_label.attributedText = hotline
//        phoneNumber_tf.setEditActions(only: [.copy, .cut, .paste])
        phoneNumber_tf.addTarget(self, action: #selector(SignUpViewController.textFieldEditingDidBegin(_:)), for: .editingDidBegin)
        phoneNumber_tf.addTarget(self, action: #selector(SignUpViewController.textFieldDidChange(_:)), for: .editingChanged)
        phoneNumber_tf.addTarget(self, action: #selector(SignUpViewController.textFieldEditingDidEnd(_:)), for: .editingDidEnd)
        
        //shadow
        phoneNum_view.layer.shadowColor = UIColor.black.cgColor
        phoneNum_view.layer.shadowOpacity = 1
        phoneNum_view.layer.shadowRadius = 20
        phoneNum_view.layer.shadowOffset = CGSize(width: 0, height: 4)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        
        phoneNum_view.layer.cornerRadius = 28
        continue_btn.layer.cornerRadius = 24
        hotLine_view.layer.cornerRadius = 24
        
        // shadow
//        phoneNum_view.layer.masksToBounds = false
//        phoneNum_view.layer.shadowColor = UIColor.black.cgColor
//        phoneNum_view.layer.shadowOffset = .zero
//        phoneNum_view.layer.shadowRadius = 1
//        phoneNum_view.layer.opacity = 1
        
//        self.phoneNum_view.layoutIfNeeded()
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
        phoneNum_view.layer.borderColor = #colorLiteral(red: 0.1723190546, green: 0.5255185366, blue: 0.4038655162, alpha: 1)
    }
    @objc func textFieldEditingDidEnd(_ textField: UITextField){
        phoneNum_view.layer.borderColor = #colorLiteral(red: 0.9332506061, green: 0.9373078942, blue: 0.9567487836, alpha: 1)
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
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

