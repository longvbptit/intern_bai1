//
//  PatientPromotionListModel.swift
//  Bai_1_Intern
//
//  Created by Bảo Long on 02/06/2022.
//

import Foundation

class PatientPromotionListModel {
    
    var amount     : Int?
    var amount_text     : String?
    var category_id     : Int?
    var category_name     : String?
    var code     : String?
    var content     : String?
    var created_at     : String?
    var from_date     : String?
    var id     : Int?
    var is_bookmark     : Bool?
    var link     : String?
    var name     : String?
    var picture     : String?
    var slug     : String?
    var to_date     : String?
    var type     : Int?
    var kind     : Int?
    
    convenience init(amount: Int?,
                     amount_text: String?,
                     category_id: Int?,
                     category_name: String?,
                     code: String?,
                     content: String?,
                     created_at: String?,
                     from_date: String?,
                     id: Int?,
                     is_bookmark: Bool?,
                     link: String?,
                     name: String?,
                     picture: String?,
                     slug: String?,
                     to_date: String?,
                     type: Int?,
                     kind: Int?) {
        
        self.init()
        self.amount = amount
        self.amount_text = amount_text
        self.category_id = category_id
        self.category_name = category_name
        self.code = code
        self.content = content
        self.created_at = created_at
        self.from_date = from_date
        self.id = id
        self.is_bookmark = is_bookmark
        self.link = link
        self.name = name
        self.picture = picture
        self.slug = slug
        self.to_date = to_date
        self.type = type
        self.kind = kind
    }
    
    
    convenience init(json: [String: Any]) {
        self.init()
        
        for (key, value) in json {
            if key == "amount", let wrapValue = value as? Int{
                let jsonValue = wrapValue
                self.amount = jsonValue
            }
            if key == "amount_text", let wrapValue = value as? String{
                let jsonValue = wrapValue
                self.amount_text = jsonValue
            }
            if key == "category_id", let wrapValue = value as? Int{
                let jsonValue = wrapValue
                self.category_id = jsonValue
            }
            if key == "category_name", let wrapValue = value as? String{
                let jsonValue = wrapValue
                self.category_name = jsonValue
            }
            if key == "code", let wrapValue = value as? String{
                let jsonValue = wrapValue
                self.code = jsonValue
            }
            if key == "content", let wrapValue = value as? String{
                let jsonValue = wrapValue
                self.content = jsonValue
            }
            if key == "created_at", let wrapValue = value as? String{
                let jsonValue = wrapValue
                self.created_at = jsonValue
            }
            if key == "from_date", let wrapValue = value as? String{
                let jsonValue = wrapValue
                self.from_date = jsonValue
            }
            if key == "id", let wrapValue = value as? Int{
                let jsonValue = wrapValue
                self.id = jsonValue
            }
            if key == "is_bookmark", let wrapValue = value as? Bool{
                let jsonValue = wrapValue
                self.is_bookmark = jsonValue
            }
            if key == "link", let wrapValue = value as? String{
                let jsonValue = wrapValue
                self.link = jsonValue
            }
            if key == "name", let wrapValue = value as? String{
                let jsonValue = wrapValue
                self.name = jsonValue
            }
            if key == "picture", let wrapValue = value as? String{
                let jsonValue = wrapValue
                self.picture = jsonValue
            }
            if key == "slug", let wrapValue = value as? String{
                let jsonValue = wrapValue
                self.slug = jsonValue
            }
            if key == "to_date", let wrapValue = value as? String{
                let jsonValue = wrapValue
                self.to_date = jsonValue
            }
            if key == "type", let wrapValue = value as? Int{
                let jsonValue = wrapValue
                self.type = jsonValue
            }
            if key == "kind", let wrapValue = value as? Int{
                let jsonValue = wrapValue
                self.kind = jsonValue
            }
        }
    }
}
