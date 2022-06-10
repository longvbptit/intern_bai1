//
//  SuggestDoctorCollectionViewCell.swift
//  Bai_1_Intern
//
//  Created by Bảo Long on 03/06/2022.
//

import UIKit

class SuggestDoctorCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imvDoctor: UIImageView!
    @IBOutlet weak var lblDoctorName: UILabel!
    @IBOutlet weak var lblMajor: UILabel!
    @IBOutlet weak var lblRate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configViews(doctorInfo: PatientDoctorListModel?) {
        let imageURL = doctorInfo?.avatar
        let name = doctorInfo?.name
        let major = doctorInfo?.majors_name
        let star = doctorInfo?.ratio_star
        let numberOfReviews = doctorInfo?.number_of_reviews
        
        configViews(imageURLStr: imageURL, name: name, major: major, star: star, numberOfReviews: numberOfReviews)
    }
    
    private func configViews(imageURLStr: String?, name: String?, major: String?, star: Double?, numberOfReviews: Int?) {
        Ultilities.loadImage(imvDoctor, strURL: imageURLStr ?? "", placeHolder: Constants.Icon.doctorAvatarPlacehold)
        lblDoctorName.text = name ?? " "
        lblMajor.text = major ?? " "
        
        let font = UIFont(name: Constants.Font.regular, size: 11)
        let headColor = Constants.Color.gray1
        let tailColor = Constants.Color.gray3
        
        let attributedRateScore = NSMutableAttributedString()
            .attrStr(text: String(format: "%.1f", star ?? 0), font: font, textColor: headColor)
            .attrStr(text: " (\(numberOfReviews ?? 0))", font: font, textColor: tailColor)
        lblRate.attributedText = attributedRateScore
    }
    

}
