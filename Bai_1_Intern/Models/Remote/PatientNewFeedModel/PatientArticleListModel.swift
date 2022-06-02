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
        
        for (key, value) in json {
            if key == "slug", let wrapValue = value as? String{
                let jsonValue = wrapValue
                self.slug = jsonValue
            }
            if key == "category_id", let wrapValue = value as? Int{
                let jsonValue = wrapValue
                self.category_id = jsonValue
            }
            if key == "created_at", let wrapValue = value as? String{
                let jsonValue = wrapValue
                self.created_at = jsonValue
            }
            if key == "title", let wrapValue = value as? String{
                let jsonValue = wrapValue
                self.title = jsonValue
            }
            if key == "link", let wrapValue = value as? String{
                let jsonValue = wrapValue
                self.link = jsonValue
            }
            if key == "id", let wrapValue = value as? Int{
                let jsonValue = wrapValue
                self.id = jsonValue
            }
            if key == "category_name", let wrapValue = value as? String{
                let jsonValue = wrapValue
                self.category_name = jsonValue
            }
            if key == "picture", let wrapValue = value as? String{
                let jsonValue = wrapValue
                self.picture = jsonValue
            }
            if key == "picture_caption", let wrapValue = value as? String{
                let jsonValue = wrapValue
                self.picture_caption = jsonValue
            }
        }
    }
}
