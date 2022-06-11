//
//  PatientArticleListModel.swift
//  Bai_1_Intern
//
//  Created by Bảo Long on 02/06/2022.
//

import Foundation

class PatientArticleListModel {
    
    var slug     : String?
    var category_id     : Int?
    var created_at     : String?
    var title     : String?
    var link     : String?
    var id     : Int?
    var category_name     : String?
    var picture     : String?
    var picture_caption     : String?
    
    convenience init(slug: String?,
                     category_id: Int?,
                     created_at: String?,
                     title: String?,
                     link: String?,
                     id: Int?,
                     category_name: String?,
                     picture: String?,
                     picture_caption: String?) {
        
        self.init()
        self.slug = slug
        self.category_id = category_id
        self.created_at = created_at
        self.title = title
        self.link = link
        self.id = id
        self.category_name = category_name
        self.picture = picture
        self.picture_caption = picture_caption
    }
    
    
    convenience init(json: [String: Any]) {
        self.init()
        
        if let wrapValue = json["category_id"] as? Int {
            self.category_id = wrapValue
        }
        if let wrapValue = json["category_name"] as? String {
            self.category_name = wrapValue
        }
        if let wrapValue = json["created_at"] as? String {
            self.created_at = wrapValue
        }
        if let wrapValue = json["id"] as? Int {
            self.id = wrapValue
        }
        if let wrapValue = json["link"] as? String {
            self.link = wrapValue
        }
        if let wrapValue = json["picture"] as? String {
            self.picture = wrapValue
        }
        if let wrapValue = json["picture_caption"] as? String {
            self.picture_caption = wrapValue
        }
        if let wrapValue = json["slug"] as? String {
            self.slug = wrapValue
        }
        if let wrapValue = json["title"] as? String {
            self.title = wrapValue
        }
    }
}
