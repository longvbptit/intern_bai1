//
//  ListPromotionModel.swift
//  Bai_1_Intern
//
//  Created by Bảo Long on 13/06/2022.
//

import Foundation

class ListPromotionModel : NSObject, JsonInitObject{
    
    var listPromotions : [PromotionModel] = []
    
    convenience init(promotionsList: [PromotionModel]) {
        self.init()
        self.listPromotions = promotionsList
    }
    
    required convenience init(json: [String: Any]) {
        self.init()
        
        if let wrapValue = json["items"] as? [[String: Any]]{
            let jsonValue = wrapValue.map({ PromotionModel(json: $0)})
            self.listPromotions = jsonValue
        }
    }
}
