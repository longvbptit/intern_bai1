//
//  DoctorModel.swift
//  Bai_1_Intern
//
//  Created by Bảo Long on 10/06/2022.
//

import Foundation

class DoctorModel : NSObject, JsonInitObject {
    var id  : Int?
    var full_name   : String?
    var avatar  : String?
    var majors_name : String?
    var ratio_star  : Double?
    var number_of_reviews : Int?
    
    convenience init(id: Int?,
                     full_name: String?,
                     avatar: String?,
                     majors_name: String?,
                     ratio_star: Double?,
                     number_of_reviews: Int?) {
        self.init()
        self.id = id
        self.full_name = full_name
        self.avatar = avatar
        self.majors_name = majors_name
        self.ratio_star = ratio_star
        self.number_of_reviews = number_of_reviews
    }
    
    required convenience init(json: [String: Any]) {
        self.init()
        
        if let wrapValue = json["id"] as? Int {
            self.id = wrapValue
        }
        if let wrapValue = json["full_name"] as? String {
            self.full_name = wrapValue
        }
        if let wrapValue = json["avatar"] as? String {
            self.avatar = wrapValue
        }
        if let wrapValue = json["majors_name"] as? String {
            self.majors_name = wrapValue
        }
        if let wrapValue = json["ratio_star"] as? Double {
            self.ratio_star = wrapValue
        }
        if let wrapValue = json["number_of_reviews"] as? Int {
            self.number_of_reviews = wrapValue
        }
    }
    
    
}
//"id": 95,
//"full_name": "Nguyễn Duy Đoan",
//"name": "Duy Đoan",
//"last_name": "Nguyễn",
//"birth_date": "20/09/1987",
//"contact_email": "nduydoan@gmail.com",
//"phone": "0983817644",
//"avatar": "https://bvsoft.vn/uploads/user/95/IMG_0701_Resize.JPG",
//"blood_name": "O+",
//"sex_name": "Nam",
//"majors_name": "Đa khoa",
//"user_type_name": "Bác sĩ",
//"ratio_star": 5,
//"number_of_reviews": 3,
//"number_of_stars": 15,
//"working_hour": "00:00 - 23:59",
//"training_place": "Trường Đại học Y Dược TP HCM",
//"degree": "Thạc sĩ",
//"created_at": "20/08/2021"
