//
//  PatientNewFeedModel.swift
//  Bai_1_Intern
//
//  Created by Bảo Long on 02/06/2022.
//

import Foundation

class PatientNewFeedModel: NSObject, JsonInitObject {
    
    var doctorList     : [PatientDoctorListModel] = []
    var articleList     : [PatientArticleListModel] = []
    var promotionList     : [PatientPromotionListModel] = []
    
    convenience init(doctorList: [PatientDoctorListModel],
                     articleList: [PatientArticleListModel],
                     promotionList: [PatientPromotionListModel]) {
        
        self.init()
        self.doctorList = doctorList
        self.articleList = articleList
        self.promotionList = promotionList
    }
    
    
    required convenience init(json: [String: Any]) {
        self.init()
        
        for (key, value) in json {
            if key == "doctorList", let wrapValue = value as? [[String: Any]]{
                let jsonValue = wrapValue.map({ PatientDoctorListModel(json: $0)})
                self.doctorList = jsonValue
            }
            if key == "articleList", let wrapValue = value as? [[String: Any]]{
                let jsonValue = wrapValue.map({ PatientArticleListModel(json: $0)})
                self.articleList = jsonValue
            }
            if key == "promotionList", let wrapValue = value as? [[String: Any]]{
                let jsonValue = wrapValue.map({ PatientPromotionListModel(json: $0)})
                self.promotionList = jsonValue
            }
        }
    }
}
