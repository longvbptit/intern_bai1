//
//  ListDoctorModel.swift
//  Bai_1_Intern
//
//  Created by Bảo Long on 10/06/2022.
//

import Foundation

class ListDoctorModel:  NSObject, JsonInitObject {
    var doctorList     : [DoctorModel] = []
    
    convenience init(doctorList: [DoctorModel]) {
        self.init()
        self.doctorList = doctorList
    }
    
    required convenience init(json: [String: Any]) {
        self.init()
        
        if let wrapValue = json["items"] as? [[String: Any]]{
            let jsonValue = wrapValue.map({ DoctorModel(json: $0)})
            self.doctorList = jsonValue
        }
    }
}
