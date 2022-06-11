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
        
        if let wrapValue = json["articleList"] as? [[String: Any]]{
            let jsonValue = wrapValue.map({ PatientArticleListModel(json: $0)})
            self.articleList = jsonValue
        }
        if let wrapValue = json["doctorList"] as? [[String: Any]]{
            let jsonValue = wrapValue.map({ PatientDoctorListModel(json: $0)})
            self.doctorList = jsonValue
        }
        if let wrapValue = json["promotionList"] as? [[String: Any]]{
            let jsonValue = wrapValue.map({ PatientPromotionListModel(json: $0)})
            self.promotionList = jsonValue
        }
    }
}
