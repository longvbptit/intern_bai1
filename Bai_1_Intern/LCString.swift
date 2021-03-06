//
//  LCString.swift
//  Bai_1_Intern
//
//  Created by Bảo Long on 06/06/2022.
//

import Foundation

enum LCString: String {
    
    case introImage1
    case introImage2
    case introImage3
    
    case introTitle1
    case introTitle2
    case introTitle3
    
    case introDetail1
    case introDetail2
    case introDetail3
    
    case loading
    
    case titleNews
    case titlePromotion
    var localized: String {
        return self.rawValue.localized
    }
}
