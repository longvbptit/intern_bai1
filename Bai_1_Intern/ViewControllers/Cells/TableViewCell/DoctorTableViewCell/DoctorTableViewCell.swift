//
//  DoctorTableViewCell.swift
//  Bai_1_Intern
//
//  Created by Bảo Long on 15/06/2022.
//

import UIKit

class DoctorTableViewCell: UITableViewCell {

    @IBOutlet weak var lblDoctorName: UILabel!
    @IBOutlet weak var lblDoctorMajor: UILabel!
    @IBOutlet weak var lblDoctorRate: UILabel!
    @IBOutlet weak var imvDoctor: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configViews(doctorInfo: DoctorModel?) {
        let imageURL = doctorInfo?.avatar
        let fullname = doctorInfo?.full_name
        let major = doctorInfo?.majors_name
        let star = doctorInfo?.ratio_star
        let numberOfReviews = doctorInfo?.number_of_reviews
        let userTypeName = doctorInfo?.user_type_name
        
        configViews(imageURLStr: imageURL, fullname: fullname, major: major, star: star, numberOfReviews: numberOfReviews, userTypeName: userTypeName)
    }
    
    private func configViews(imageURLStr: String?, fullname: String?, major: String?, star: Double?, numberOfReviews: Int?, userTypeName: String?) {
        Ultilities.loadImage(imvDoctor, strURL: imageURLStr ?? "", placeHolder: Constants.Icon.doctorAvatarPlacehold)
        lblDoctorName.text = fullname ?? ""
        lblDoctorMajor.text = major ?? ""
        
        let font = UIFont(name: Constants.Font.regular, size: 11)
        let headColor = Constants.Color.gray1
        let tailColor = Constants.Color.gray3
        
        let attributedRateScore = NSMutableAttributedString()
            .attrStr(text: String(format: "%.1f", star ?? 0), font: font, textColor: headColor)
            .attrStr(text: " (\(numberOfReviews ?? 0) Đánh giá)", font: font, textColor: tailColor)
        lblDoctorRate.attributedText = attributedRateScore
    }
    
}
