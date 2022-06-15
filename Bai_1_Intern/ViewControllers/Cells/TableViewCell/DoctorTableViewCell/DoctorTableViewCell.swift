//
//  DoctorTableViewCell.swift
//  Bai_1_Intern
//
//  Created by Bảo Long on 15/06/2022.
//

import UIKit

class DoctorTableViewCell: UITableViewCell {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblMajor: UILabel!
    @IBOutlet weak var lblRate: UILabel!
    @IBOutlet weak var imvDoctor: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
