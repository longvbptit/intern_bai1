//
//  UICollectionViewExtension.swift
//  Bai_1_Intern
//
//  Created by Bảo Long on 01/06/2022.
//

import Foundation
import UIKit

extension UICollectionView{
    
    func registerCells(_ cells: AnyClass..., fromNib: Bool = true) {
        for cell in cells {
            let identifier = String(describing: cell)
            if fromNib == true {
                self.register(UINib(nibName: identifier, bundle: nil), forCellWithReuseIdentifier: identifier)
                continue
            }
            self.register(cell, forCellWithReuseIdentifier: identifier)
        }
    }
}
