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
        self.navigationController?.popViewController(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        self.setupHideKeyboardOnTap()
        
        phoneNum_view.clipsToBounds = true
        phoneNum_view.layer.cornerRadius = 20
        phoneNum_view.layer.borderColor = #colorLiteral(red: 0.9332506061, green: 0.9373078942, blue: 0.9567487836, alpha: 1)
        phoneNum_view.layer.borderWidth = 1
        
//        // shadow
//        phoneNum_view.layer.masksToBounds = false
//        phoneNum_view.layer.shadowColor = UIColor.black.cgColor
//        phoneNum_view.layer.shadowOffset = .zero
//        phoneNum_view.layer.shadowRadius = 1
//        phoneNum_view.layer.opacity = 1
//        phoneNum_view.dropShadow(color: .darkGray, opacity: 1, offSet: .zero, radius: 1, scale: true)
        
        
        continue_btn.clipsToBounds = true
        continue_btn.layer.cornerRadius = 20
        continue_btn.isEnabled = false
        
        reigonNum_lb.adjustsFontSizeToFitWidth = true
        reigonNum_lb.minimumScaleFactor = 0.5
        
        phoneNumber_tf.adjustsFontSizeToFitWidth = true
        phoneNumber_tf.minimumFontSize = 10
        phoneNumber_tf.placeholder = "Nhập số điện thoại"
        phoneNumber_tf.textContentType = UITextContentType.telephoneNumber
        phoneNumber_tf.addTarget(self, action: #selector(SignUpViewController.textFieldDidChange(_:)), for: .editingChanged)
        phoneNumber_tf.addTarget(self, action: #selector(SignUpViewController.textFieldEditingDidEnd(_:)), for: .editingDidEnd)
        
    }
    @objc func textFieldDidChange(_ textField: UITextField) {
        phoneNum_view.layer.borderColor = #colorLiteral(red: 0.1723190546, green: 0.5255185366, blue: 0.4038655162, alpha: 1)
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
    
    @objc func textFieldEditingDidEnd(_ textField: UITextField){
        phoneNum_view.layer.borderColor = #colorLiteral(red: 0.9332506061, green: 0.9373078942, blue: 0.9567487836, alpha: 1)
    }
    
    //hide keyboard, change hightlight color and end editing
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
//
//extension UIView {
//
//  func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
//    layer.masksToBounds = false
//    layer.shadowColor = color.cgColor
//    layer.shadowOpacity = opacity
//    layer.shadowOffset = offSet
//    layer.shadowRadius = radius
//
//    layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
//    layer.shouldRasterize = true
//    layer.rasterizationScale = scale ? UIScreen.main.scale : 1
//  }
//}
