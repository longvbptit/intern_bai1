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
    var number_of_stars     : Int?
    
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
                     number_of_stars : Int?) {
        
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
        
        if let wrapValue = json["avatar"] as? String {
            self.avatar = wrapValue
        }
        if let wrapValue = json["contact_email"] as? String {
            self.contact_email = wrapValue
        }
        if let wrapValue = json["full_name"] as? String {
            self.full_name = wrapValue
        }
        if let wrapValue = json["id"] as? Int {
            self.id = wrapValue
        }
        if let wrapValue = json["last_name"] as? String {
            self.last_name = wrapValue
        }
        if let wrapValue = json["majors_name"] as? String {
            self.majors_name = wrapValue
        }
        if let wrapValue = json["name"] as? String {
            self.name = wrapValue
        }
        if let wrapValue = json["number_of_reviews"] as? Int {
            self.number_of_reviews = wrapValue
        }
        if let wrapValue = json["number_of_stars"] as? Int {
            self.number_of_stars = wrapValue
        }
        if let wrapValue = json["phone"] as? String {
            self.phone = wrapValue
        }
        if let wrapValue = json["ratio_star"] as? Double {
            self.ratio_star = wrapValue
        }
    }
}

extension PatientDoctorListModel {
    func getFullName() -> String {
        return full_name ?? (last_name ?? "") + " " + (name ?? "")
    }
}
