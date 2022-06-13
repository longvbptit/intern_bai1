//
//  PromotionModel.swift
//  Bai_1_Intern
//
//  Created by Bảo Long on 13/06/2022.
//

import Foundation

class PromotionModel : NSObject, JsonInitObject{

    var id  : Int?
    var code    : String?
    var name    : String?
    var picture : String?
    var from_date   : String?
    var to_date : String?
    var amount  : Int?
    var created_at  : String?
    var link    : String?
    
    convenience init(id  : Int?,
                    code    : String?,
                    name    : String?,
                    picture : String?,
                    from_date   : String?,
                    to_date : String?,
                    amount  : Int?,
                    created_at  : String?,
                    link    : String?) {
        self.init()
        self.id = id
        self.code = code
        self.name = name
        self.picture = picture
        self.from_date = from_date
        self.to_date = to_date
        self.amount = amount
        self.created_at = created_at
        self.link = link
    }
    
    required convenience init(json: [String: Any]) {
        self.init()
        
        if let wrapValue = json["id"] as? Int {
            self.id = wrapValue
        }
        if let wrapValue = json["code"] as? String {
            self.code = wrapValue
        }
        if let wrapValue = json["name"] as? String {
            self.name = wrapValue
        }
        if let wrapValue = json["picture"] as? String {
            self.picture = wrapValue
        }
        if let wrapValue = json["from_date"] as? String {
            self.from_date = wrapValue
        }
        if let wrapValue = json["to_date"] as? String {
            self.to_date = wrapValue
        }
        if let wrapValue = json["amount"] as? Int {
            self.amount = wrapValue
        }
        if let wrapValue = json["created_at"] as? String {
            self.created_at = wrapValue
        }
        if let wrapValue = json["link"] as? String {
            self.link = wrapValue
        }
    }
}
