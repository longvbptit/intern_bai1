//
//  NewsModel.swift
//  Bai_1_Intern
//
//  Created by Bảo Long on 12/06/2022.
//

import Foundation

class NewsModel : NSObject, JsonInitObject{
    
    var id  : Int?
    var category_id  : Int?
    var title   : String?
    var slug    : String?
    var summary : String?
    var content : String?
    var picture : String?
    var picture_caption : String?
    var created_at  : String?
    var category_name   : String?
    var link    : String?
    
    convenience init(id  : Int?,
                    category_id  : Int?,
                    title   : String?,
                    slug    : String?,
                    summary : String?,
                    content : String?,
                    picture : String?,
                    picture_caption : String?,
                    created_at  : String?,
                    category_name   : String?,
                    link    : String?) {
        self.init()
        self.id = id
        self.category_id = category_id
        self.title = title
        self.slug = slug
        self.summary = summary
        self.content = content
        self.picture = picture
        self.picture_caption = picture_caption
        self.created_at = created_at
        self.category_name = category_name
        self.link = link
    }
    
    required convenience init(json: [String: Any]) {
        self.init()
        
        if let wrapValue = json["id"] as? Int {
            self.id = wrapValue
        }
        if let wrapValue = json["category_id"] as? Int {
            self.category_id = wrapValue
        }
        if let wrapValue = json["title"] as? String {
            self.title = wrapValue
        }
        if let wrapValue = json["slug"] as? String {
            self.slug = wrapValue
        }
        if let wrapValue = json["summary"] as? String {
            self.summary = wrapValue
        }
        if let wrapValue = json["content"] as? String {
            self.content = wrapValue
        }
        if let wrapValue = json["picture"] as? String {
            self.picture = wrapValue
        }
        if let wrapValue = json["picture_caption"] as? String {
            self.picture_caption = wrapValue
        }
        if let wrapValue = json["created_at"] as? String {
            self.created_at = wrapValue
        }
        if let wrapValue = json["category_name"] as? String {
            self.category_name = wrapValue
        }
        if let wrapValue = json["link"] as? String {
            self.link = wrapValue
        }
    }
}

