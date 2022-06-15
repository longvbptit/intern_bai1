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

final class APIUtilities {
    static let domain = "https://gist.githubusercontent.com"
    static let responseDatakey = "data"
    static let responseItemskey = "items"
    static let responseCodekey = "code"
    static let responseMessageKey = "message"
    
    static func requestHomePatientFeed(completionHandler: ((PatientNewFeedModel?, APIError?) -> Void)?) {
        
        let tailStrURL = "/hdhuy179/f967ffb777610529b678f0d5c823352a/raw"
        jsonResponseObject(tailStrURL: tailStrURL, method: .get, headers: [:], comletionHandler: completionHandler)
    
    }
    
    static func requestNews(completionHandler: (([NewsModel]?, APIError?) -> Void)?) {
        
        let tailStrURL = "/hdhuy179/84d1dfe96f2c0ab1ddea701df352a7a6/raw"
        jsonResponseObjects(tailStrURL: tailStrURL, method: .get, headers: [:], comletionHandler: completionHandler)
    
    }
    
    static func requestPromotions(completionHandler: (([PromotionModel]?, APIError?) -> Void)?) {
        
        let tailStrURL = "/hdhuy179/ef03ed850ad56f0136fe3c5916b3280b/raw/Training_Intern_BasicApp_Promotion"
        jsonResponseObjects(tailStrURL: tailStrURL, method: .get, headers: [:], comletionHandler: completionHandler)
    
    }
    
    static func requestDoctors(completionHandler: (([DoctorModel]?, APIError?) -> Void)?) {

        let tailStrURL = "/hdhuy179/9ac0a89969b46fb67bc7d1a8b94d180e/raw"
        jsonResponseObjects(tailStrURL: tailStrURL, method: .get, headers: [:], comletionHandler: completionHandler)

    }
    
    //MARK: Base
    static private func jsonResponseObject<T: JsonInitObject>(tailStrURL: String, method: HTTPMethod, headers: HTTPHeaders, comletionHandler: ((T?, APIError?) -> Void)?) {
        
        jsonResponse(tailStrURL: tailStrURL, method: method, headers: headers) {
            response, serverCode, serverMessage in
            
            switch response.result {
            case .success(let value):
                guard serverCode == 200 else {
                    comletionHandler?(nil, .serverError(serverCode, serverMessage))
                    return
                }
                
                guard let responseDict = value as? [String: Any],
                      let dataDict = responseDict[responseDatakey] as? [String: Any] else {
                    comletionHandler?(nil, .resposeFormatError)
                    return
                }
                
                let obj = T(json: dataDict)
                
                comletionHandler?(obj, nil)
                
            case .failure(let error):
                comletionHandler?(nil, .unowned(error))
            }
        }
    }
    
    static private func jsonResponseObjects<T: JsonInitObject>(tailStrURL: String, method: HTTPMethod, headers: HTTPHeaders, comletionHandler: (([T]?, APIError?) -> Void)?) {
        
        jsonResponse(tailStrURL: tailStrURL, method: method, headers: headers) {
            response, serverCode, serverMessage in
            
            switch response.result {
            case .success(let value):
                guard serverCode == 200 else {
                    comletionHandler?(nil, .serverError(serverCode, serverMessage))
                    return
                }
                
                var objs : [T] = []
                guard let responseDict = value as? [String: Any],
                      let dataDicts = responseDict[responseDatakey] as? [String: Any] else {
                    comletionHandler?(nil, .resposeFormatError)
                    return
                }
                
                guard let datas = dataDicts[responseItemskey] as? [[String: Any]] else {
                    comletionHandler?(nil, .resposeFormatError)
                    return
                }
                
                for data in datas {
                    let item = T(json: data)
                    objs.append(item)
                }
                
                comletionHandler?(objs, nil)
                
            case .failure(let error):
                comletionHandler?(nil, .unowned(error))
            }
        }
    }
    
    static private func jsonResponse(tailStrURL: String,
                                     method: HTTPMethod,
                                     parameter: Parameters? = nil,
                                     encoding: ParameterEncoding = JSONEncoding.default,
                                     headers: HTTPHeaders = [:],
                                     completionHandler: ((AFDataResponse<Any>, Int?, String?) -> Void)?) {
        
        guard let url = URL(string: domain + tailStrURL) else { return }
        AF.request(url, method: method, parameters: parameter, encoding: encoding, headers: headers)
            .responseJSON { response in
                
                var serverCode : Int? = nil
                var serverMessage: String? = nil
                
                switch response.result {
                case .success(let value):
                    serverCode = (value as? [String: Any])?[responseCodekey] as? Int
                    serverMessage  = (value as? [String: Any])?[responseMessageKey] as? String
                case .failure(_):
                    break
                }
                
                completionHandler?(response, serverCode, serverMessage)
                
            }
    }
}

extension APIUtilities {
    enum APIError: Error {
        //        case loginFail
        //        case signUpFail
        case resposeFormatError
        case serverError(Int?, String?)
        case unowned(Error)
    }
}

