//
//  CollectionViewCell.swift
//  Bai_1_Intern
//
//  Created by Bảo Long on 08/05/2022.
//

import UIKit

class IntroCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var intro_img: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDetail: UILabel!
    
    func configViews(_ model: IntroModel) {
        intro_img.image = model.image
        lblTitle.text = model.title
        lblDetail.text = model.detail
    }
}
