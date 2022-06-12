//
//  ListNewsModel.swift
//  Bai_1_Intern
//
//  Created by Bảo Long on 12/06/2022.
//

import Foundation

class ListNewsModel : NSObject, JsonInitObject {

    var newsList : [NewsModel] = []
    
    convenience init(newsList: [NewsModel]) {
        self.init()
        self.newsList = newsList
    }
    
    required convenience init(json: [String: Any]) {
        self.init()
        
        if let wrapValue = json["items"] as? [[String: Any]]{
            let jsonValue = wrapValue.map({ NewsModel(json: $0)})
            self.newsList = jsonValue
        }
    }
}
