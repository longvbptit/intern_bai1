//
//  SuggestDoctorTableViewCell.swift
//  Bai_1_Intern
//
//  Created by Bảo Long on 03/06/2022.
//

import UIKit

class SuggestDoctorTableViewCell: UITableViewCell {

    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var cltvSuggestion: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
