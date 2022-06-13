//
//  FirstNewsTableViewCell.swift
//  Bai_1_Intern
//
//  Created by Bảo Long on 13/06/2022.
//

import UIKit

class FirstNewsTableViewCell: UITableViewCell {

    @IBOutlet weak var imvNews: UIImageView!
    @IBOutlet weak var lblNewsTitle: UILabel!
    @IBOutlet weak var lblNewsDate: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configViews(news: NewsModel?) {
        let imageURL = news?.picture
        let title = news?.title
        let date = news?.created_at
        
        configViews(imageURLStr: imageURL, title: title, date: date)
    }

    private func configViews(imageURLStr: String?, title: String?, date: String?) {
        Ultilities.loadImage(imvNews, strURL: imageURLStr ?? "", placeHolder: Constants.Icon.imagePlacehold)
        lblNewsTitle.text = title ?? " "
        lblNewsDate.text = date ?? " "
    }
}
