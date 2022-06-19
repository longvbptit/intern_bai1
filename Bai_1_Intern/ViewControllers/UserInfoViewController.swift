//
//  UserInfoViewController.swift
//  Bai_1_Intern
//
//  Created by Bảo Long on 15/06/2022.
//

import UIKit

class UserInfoViewController: UIViewController {
    
    
    @IBOutlet weak var lblLastName: UILabel!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var viwLastNameSeparator: UIView!
    
    @IBOutlet weak var lblFirstName: UILabel!
    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var viwFirstNameSeparator: UIView!
    
    @IBOutlet weak var lblDateOfBirth: UILabel!
    @IBOutlet weak var txtDateOfBirth: UITextField!
    @IBOutlet weak var viwDateOfBirthSeparator: UIView!
    
    @IBOutlet weak var lblPhone: UILabel!
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var viwPhoneSeparator: UIView!
    
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var viwEmailSeparator: UIView!
    
    @IBOutlet weak var lblCity: UILabel!
    @IBOutlet weak var txtCity: UITextField!
    @IBOutlet weak var viwCitySeparator: UIView!
    
    @IBOutlet weak var lblDistrict: UILabel!
    @IBOutlet weak var txtDistrict: UITextField!
    @IBOutlet weak var viwDistrictSeparator: UIView!
    
    @IBOutlet weak var lblWard: UILabel!
    @IBOutlet weak var txtWard: UITextField!
    @IBOutlet weak var viwWardSeparator: UIView!
    
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var txtAddress: UITextField!
    @IBOutlet weak var viwAddressSeparator: UIView!
    
    @IBOutlet weak var lblBlood: UILabel!
    @IBOutlet weak var txtBlood: UITextField!
    @IBOutlet weak var viwBloodSeparator: UIView!
    
    @IBOutlet weak var smcGender: UISegmentedControl!
    @IBOutlet weak var imvMale: UIImageView!
    @IBOutlet weak var lblMale: UILabel!
    @IBOutlet weak var imvFemale: UIImageView!
    @IBOutlet weak var lblFemale: UILabel!
    
//    var valueSegmented: Int?
    var userModel: UserModel?
    var locationModel: LocationModel?
    var lblSetUp: [UILabel] = []
    var viwSetUp: [UIView] = []
    
    lazy var refreshControl: UIRefreshControl = {
        let rfc  = UIRefreshControl()
        return rfc
    }()
    
    @IBAction func btnBackTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnDoneTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addLabel()
        addView()
    
        self.refreshControl.addTarget(self, action: #selector(fetchPatienUserFeed), for: .valueChanged)
        self.refreshControl.addTarget(self, action: #selector(fetchPatientLocationFeed), for: .valueChanged)
        smcGender.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
        smcGender.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .touchUpInside)
        
        fetchPatienUserFeed()
        setUpViews()
    }
    
    func addLabel() {
        lblSetUp.removeAll()
        lblSetUp.append(lblLastName)
        lblLastName.tag = 1
        lblSetUp.append(lblFirstName)
        lblFirstName.tag = 2
        lblSetUp.append(lblDateOfBirth)
        lblDateOfBirth.tag = 3
        lblSetUp.append(lblPhone)
        lblPhone.tag = 4
        lblSetUp.append(lblEmail)
        lblEmail.tag = 5
        lblSetUp.append(lblAddress)
        lblAddress.tag = 6
    }
    
    func addView() {
        viwSetUp.removeAll()
        viwSetUp.append(viwLastNameSeparator)
        viwLastNameSeparator.tag = 1
        viwSetUp.append(viwFirstNameSeparator)
        viwFirstNameSeparator.tag = 2
        viwSetUp.append(viwDateOfBirthSeparator)
        viwDateOfBirthSeparator.tag = 3
        viwSetUp.append(viwPhoneSeparator)
        viwPhoneSeparator.tag = 4
        viwSetUp.append(viwEmailSeparator)
        viwEmailSeparator.tag = 5
        viwSetUp.append(viwAddressSeparator)
        viwAddressSeparator.tag = 6
    }
    
    func setUpViews(){
        
        txtLastName.delegate = self
        txtLastName.tag = 1
        
        txtFirstName.delegate = self
        txtFirstName.tag = 2
        
        txtDateOfBirth.delegate = self
        txtDateOfBirth.tag = 3
        
        txtPhone.delegate = self
        txtPhone.tag = 4
        
        txtEmail.delegate = self
        txtEmail.tag = 5
        
        txtCity.delegate = self
        txtDistrict.delegate = self
        txtWard.delegate = self
        
        txtAddress.delegate = self
        txtAddress.tag = 6
        
        txtBlood.delegate = self
    }
    
    @objc func fetchPatientLocationFeed() {
        
        APIUtilities.requestLocation(province_code: (userModel?.province_code)!, district_code: (userModel?.district_code)!, ward_code: (userModel?.ward_code)!) { [weak self] patientLocationFeed, error in
            guard let self = self else { return}
            self.refreshControl.endRefreshing()
            guard let patientLocationFeed = patientLocationFeed, error == nil else {
                return
            }
            self.locationModel = patientLocationFeed
            self.setUpViewAddress()
        }
        
    }
    
    func setUpViewAddress(){
        txtCity.text = locationModel?.province_name ?? ""
        txtWard.text = locationModel?.ward_name ?? ""
        txtDistrict.text = locationModel?.district_name ?? ""
    }
    
    @objc func fetchPatienUserFeed() {
        APIUtilities.requestUser { [weak self] patientUserFeed, error in
            guard let self = self else { return}
            self.refreshControl.endRefreshing()
            guard let patientUserFeed = patientUserFeed, error == nil else {
                return
            }
            self.userModel = patientUserFeed
            self.loadData()
        }
    }
    
    func loadData() {
        self.setUpViewsUser()
        self.fetchPatientLocationFeed()
    }
    
    func setUpViewsUser(){
        txtFirstName.text = userModel?.last_name ?? ""
        txtLastName.text = userModel?.name ?? ""
        txtDateOfBirth.text = userModel?.birth_date ?? ""
        txtPhone.text = userModel?.phone ?? ""
        txtEmail.text = userModel?.contact_email ?? ""
        txtAddress.text = userModel?.address ?? ""
        txtBlood.text = userModel?.blood_name ?? ""
        if userModel?.sex == 0 {
            self.smcGender.selectedSegmentIndex = 0
            self.lblMale.textColor = Constants.Color.greenBlue
            self.lblFemale.textColor = Constants.Color.gray3
            self.imvMale.image = Constants.Icon.maleSelectedIcon
            self.imvFemale.image = Constants.Icon.femaleIcon
        }
        else {
            self.smcGender.selectedSegmentIndex = 1
            self.lblMale.textColor = Constants.Color.gray3
            self.lblFemale.textColor = Constants.Color.greenBlue
            self.imvMale.image = Constants.Icon.maleIcon
            self.imvFemale.image = Constants.Icon.femaleSelectedIcon
        }
    }
    
    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0  {
            lblMale.textColor = Constants.Color.greenBlue
            lblFemale.textColor = Constants.Color.gray3
            imvMale.image = Constants.Icon.maleSelectedIcon
            imvFemale.image = Constants.Icon.femaleIcon
        }
        else {
            lblMale.textColor = Constants.Color.gray3
            lblFemale.textColor = Constants.Color.greenBlue
            imvMale.image = Constants.Icon.maleIcon
            imvFemale.image = Constants.Icon.femaleSelectedIcon
        }
    }
    
    
}

extension UserInfoViewController: UITextFieldDelegate,UIGestureRecognizerDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {

        print(lblSetUp[2].tag)
        for i in 0..<lblSetUp.count {
            if lblSetUp[i].tag == textField.tag {
                lblSetUp[i].textColor = Constants.Color.greenBlue
                viwSetUp[i].backgroundColor = Constants.Color.greenBlue
            }
        }
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {

        for i in 0..<lblSetUp.count {
            if lblSetUp[i].tag == textField.tag {
                lblSetUp[i].textColor = Constants.Color.gray3
                viwSetUp[i].backgroundColor = Constants.Color.userSeparator
            }
        }

    }
}
