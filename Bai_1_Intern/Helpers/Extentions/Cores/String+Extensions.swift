//
//  String+Extensions.swift
//  Bai_1_Intern
//
//  Created by Bảo Long on 27/05/2022.
//

import Foundation
import UIKit

extension String {
    
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
    
    func convertToDictionary() throws -> [String: Any]? {
        if let data = self.data(using: .utf8) {
            let dict = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            return dict
        }
        return nil
    }
    
    func copyToClipboard() {
        let pasteboard = UIPasteboard.general
        pasteboard.string = self
    }
    
    func split(by length: Int, fromEnd: Bool) -> [String] {
        var startIndex = fromEnd ? self.endIndex : self.startIndex
        var results = [Substring]()
        
        if fromEnd == true {
            while startIndex > self.startIndex {
                let endIndex = self.index(startIndex, offsetBy: -length, limitedBy: self.startIndex) ?? self.startIndex
                results.append(self[endIndex..<startIndex])
                startIndex = endIndex
            }

            return results.map { String($0) }.reversed()
        }

        while startIndex < self.endIndex {
            let endIndex = self.index(startIndex, offsetBy: length, limitedBy: self.endIndex) ?? self.endIndex
            results.append(self[startIndex..<endIndex])
            startIndex = endIndex
        }

        return results.map { String($0) }
    }
}
