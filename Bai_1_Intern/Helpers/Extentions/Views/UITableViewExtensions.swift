//
//  UITableViewExtensions.swift
//  Bai_1_Intern
//
//  Created by Bảo Long on 06/06/2022.
//

import Foundation
import UIKit

extension UITableView {
    
    func registerCells(_ cells: AnyClass..., fromNib: Bool = true) {
        for cell in cells {
            let identifier = String(describing: cell)
            if fromNib == true {
                self.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
                continue
            }
            register(cell, forCellReuseIdentifier: identifier)
        }
    }
    
    func dequeueReusableCell <T: UITableViewCell> (_ cell: T.Type, indexPath: IndexPath) -> T {
        let identifier = String(describing: cell)
        let cell = self.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        return cell as! T
    }
}
