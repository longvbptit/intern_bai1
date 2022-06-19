//
//  UserModel.swift
//  Bai_1_Intern
//
//  Created by Bảo Long on 16/06/2022.
//

import Foundation

class UserModel: NSObject, JsonInitObject {
    
    var id  : Int?
    var name    : String?
    var last_name   : String?
//    var username    : String?
    var contact_email   : String?
    var phone   : String?
    var address : String?
    var province_code   : String?
    var district_code   : String?
    var ward_code   : String?
    var birth_date  : String?
//    var avatar  : String?
//    var full_address    : String?
//    var full_name   : String?
    var blood_name  : String?
    var sex : Int?
    
    convenience init(id  : Int?,
                    name    : String?,
                    last_name   : String?,
                    contact_email   : String?,
                    phone   : String?,
                    address : String?,
                    province_code   : String?,
                    district_code   : String?,
                    ward_code   : String?,
                    birth_date  : String?,
                    blood_name  : String?,
                    sex : Int?) {
        self.init()
        self.id = id
        self.name = name
        self.last_name = last_name
        self.contact_email = contact_email
        self.phone = phone
        self.address = address
        self.province_code = province_code
        self.district_code = district_code
        self.ward_code = ward_code
        self.birth_date = birth_date
        self.blood_name = blood_name
        self.sex = sex
    }
    
    required convenience init(json: [String: Any]) {
        self.init()
        
        if let wrapValue = json["id"] as? Int {
            self.id = wrapValue
        }
        if let wrapValue = json["name"] as? String {
            self.name = wrapValue
        }
        if let wrapValue = json["last_name"] as? String {
            self.last_name = wrapValue
        }
        if let wrapValue = json["contact_email"] as? String {
            self.contact_email = wrapValue
        }
        if let wrapValue = json["phone"] as? String {
            self.phone = wrapValue
        }
        if let wrapValue = json["full_address"] as? String {
            self.address = wrapValue
        }
        if let wrapValue = json["province_code"] as? String {
            self.province_code = wrapValue
        }
        if let wrapValue = json["district_code"] as? String {
            self.district_code = wrapValue
        }
        if let wrapValue = json["ward_code"] as? String {
            self.ward_code = wrapValue
        }
        if let wrapValue = json["birth_date"] as? String {
            self.birth_date = wrapValue
        }
        if let wrapValue = json["blood_name"] as? String {
            self.blood_name = wrapValue
        }
        if let wrapValue = json["sex"] as? Int {
            self.sex = wrapValue
        }
    }
}
