//
//  CollectionViewCell.swift
//  Bai_1_Intern
//
//  Created by Bảo Long on 08/05/2022.
//

import UIKit

class IntroCLVCell: UICollectionViewCell {
    

    @IBOutlet weak var bgIntro_img: UIImageView!
    @IBOutlet weak var intro_img: UIImageView!
    @IBOutlet weak var inf1_lb: UILabel!
    @IBOutlet weak var inf2_lb: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        intro_img.isHighlighted = true
//        intro_img.highlightedImage = UIImage(named: "bg_intro")
        
        
        // Initialization code
    }

}
