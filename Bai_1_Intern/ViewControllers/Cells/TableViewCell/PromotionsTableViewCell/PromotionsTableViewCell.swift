//
//  PromotionsTableViewCell.swift
//  Bai_1_Intern
//
//  Created by Bảo Long on 13/06/2022.
//

import UIKit

class PromotionsTableViewCell: UITableViewCell {

    @IBOutlet weak var imvPromotion: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configViews(promotion: PromotionModel?) {
        let imageURL = promotion?.picture
        let title = promotion?.name
        let date = promotion?.created_at
        
        configViews(imageURLStr: imageURL, title: title, date: date)
    }

    private func configViews(imageURLStr: String?, title: String?, date: String?) {
        Ultilities.loadImage(imvPromotion, strURL: imageURLStr ?? "", placeHolder: Constants.Icon.imagePlacehold)
        lblTitle.text = title ?? " "
        lblDate.text = date ?? " "
    }
}
