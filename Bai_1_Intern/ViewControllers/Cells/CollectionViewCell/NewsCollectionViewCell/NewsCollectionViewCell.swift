//
//  NewsCollectionViewCell.swift
//  Bai_1_Intern
//
//  Created by Bảo Long on 02/06/2022.
//

import UIKit

class NewsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imvFeed: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSpecial: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 20
        self.layer.shadowOffset = CGSize(width: 0, height: 4)
    }
    func configViews(news: PatientArticleListModel?) {
        let imageURL = news?.picture
        let title = news?.title
        let special = news?.category_name
        let date = news?.created_at
        
        configViews(imageURLStr: imageURL, title: title, special: special, date: date)
    }
    
    func configViews(promotion: PatientPromotionListModel?) {
        let imageURL = promotion?.picture
        let title = promotion?.name
        let special = promotion?.category_name
        let date = promotion?.created_at
        
        configViews(imageURLStr: imageURL, title: title, special: special, date: date)
    }
    
    private func configViews(imageURLStr: String?, title: String?, special: String?, date: String?) {
        Ultilities.loadImage(imvFeed, strURL: imageURLStr ?? "", placeHolder: Constants.Icon.imagePlacehold)
        lblTitle.text = title ?? " "
        lblSpecial.text = special ?? " "
        lblDate.text = date ?? " "
    }
}
