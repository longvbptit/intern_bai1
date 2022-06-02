//
//  APIUtilities.swift
//  Bai_1_Intern
//
//  Created by Bảo Long on 02/06/2022.
//

import Foundation
import Alamofire

protocol JsonInitObject: NSObject {
    init(json: [String: Any])
}
