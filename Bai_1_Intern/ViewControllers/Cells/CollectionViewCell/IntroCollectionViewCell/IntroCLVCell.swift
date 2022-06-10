//
//  CollectionViewCell.swift
//  Bai_1_Intern
//
//  Created by Bảo Long on 08/05/2022.
//

import UIKit

class IntroCLVCell: UICollectionViewCell {
    
    @IBOutlet weak var intro_img: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDetail: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        intro_img.isHighlighted = true
//        intro_img.highlightedImage = UIImage(named: "bg_intro")
        
        
        // Initialization code
    }

    func configViews(_ model: IntroModel) {
        intro_img.image = model.image
        lblTitle.text = model.title
        lblDetail.text = model.detail
    }
}
