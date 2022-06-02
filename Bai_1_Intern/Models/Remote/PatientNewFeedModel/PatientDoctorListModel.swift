//
//  PatientDoctorListModel.swift
//  Bai_1_Intern
//
//  Created by Bảo Long on 02/06/2022.
//

import Foundation

class PatientDoctorListModel {
    
    var full_name     : String?
    var phone     : String?
    var avatar     : String?
    var id     : Int?
    var number_of_reviews     : Int?
    var name     : String?
    var ratio_star     : Double?
    var last_name     : String?
    var contact_email     : String?
    var majors_name     : String?
    var number_of_stars     : String?
    
    convenience init(full_name: String?,
                     phone: String?,
                     avatar: String,
                     id: Int?,
                     number_of_reviews: Int?,
                     name: String?,
                     ratio_star: Double?,
                     last_name: String?,
                     contact_email: String?,
                     majors_name: String?,
                     number_of_stars : String?) {
        
        self.init()
        self.full_name = full_name
        self.phone = phone
        self.avatar = avatar
        self.id = id
        self.number_of_reviews = number_of_reviews
        self.name = name
        self.ratio_star = ratio_star
        self.last_name = last_name
        self.contact_email = contact_email
        self.majors_name = majors_name
        self.number_of_stars = number_of_stars
    }
    
    
    convenience init(json: [String: Any]) {
        self.init()
        
        for (key, value) in json {
            if key == "full_name", let wrapValue = value as? String{
                let jsonValue = wrapValue
                self.full_name = jsonValue
            }
            if key == "phone", let wrapValue = value as? String{
                let jsonValue = wrapValue
                self.phone = jsonValue
            }
            if key == "avatar", let wrapValue = value as? String{
                let jsonValue = wrapValue
                self.avatar = jsonValue
            }
            if key == "id", let wrapValue = value as? Int{
                let jsonValue = wrapValue
                self.id = jsonValue
            }
            if key == "number_of_reviews", let wrapValue = value as? Int{
                let jsonValue = wrapValue
                self.number_of_reviews = jsonValue
            }
            if key == "name", let wrapValue = value as? String{
                let jsonValue = wrapValue
                self.name = jsonValue
            }
            if key == "ratio_star", let wrapValue = value as? Double{
                let jsonValue = wrapValue
                self.ratio_star = jsonValue
            }
            if key == "last_name", let wrapValue = value as? String{
                let jsonValue = wrapValue
                self.last_name = jsonValue
            }
            if key == "contact_email", let wrapValue = value as? String{
                let jsonValue = wrapValue
                self.contact_email = jsonValue
            }
            if key == "majors_name", let wrapValue = value as? String{
                let jsonValue = wrapValue
                self.majors_name = jsonValue
            }
            if key == "number_of_stars", let wrapValue = value as? String{
                let jsonValue = wrapValue
                self.number_of_stars = jsonValue
            }
        }
    }
}

extension PatientDoctorListModel {
    func getFullName() -> String {
        return full_name ?? (last_name ?? "") + " " + (name ?? "")
    }
}
