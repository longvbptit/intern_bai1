//
//  Constants.swift
//  Bai_1_Intern
//
//  Created by Bảo Long on 26/05/2022.
//

import Foundation
import UIKit

struct Constants {
    
    struct Color {
        static let greenBlue = UIColor(hexString: "#2C8667")
        static let overlayBackgroundColor = UIColor(hexString: "#18191F").withAlphaComponent(0.7)
        
        static let startGradientIntro = UIColor(hexString: "#A6F1F7")
        static let endGradientIntro = UIColor(hexString: "#F3F5FB")
        static let borderGray = UIColor(hexString: "#EEEFF4")
        static let gray = UIColor(hexString: "#EEEEEE")
        static let gray1 = UIColor(hexString: "#18191F")
        static let gray2 = UIColor(hexString: "#474A57")
        static let gray3 = UIColor(hexString: "#969BAB")
        static let gray4 = UIColor(hexString: "#D9DBE1")
//        static let gray5 = UIColor(hexString: "##EEEFF4")
        static let gray6 = UIColor(hexString: "#F4F5F7")
        static let borderBlue = UIColor(hexString: "#242A61")
        static let userSeparator = UIColor(hexString: "#E5E5E5")
        
    }
    
    struct Font {
        static let regular = "NunitoSans-Regular"
        static let light = "NunitoSans-Light"
        static let semiBold = "NunitoSans-SemiBold"
        static let bold = "NunitoSans-Bold"
    }
    
    struct Icon {
        static let imagePlacehold = UIImage.imageWithColor(color: .lightGray)
        static let doctorAvatarPlacehold = UIImage(named: "doctor-placeholder")
        
        static let maleIcon = UIImage(named: "icon-male")
        static let maleSelectedIcon = UIImage(named: "icon-maleSelected")
        static let femaleIcon = UIImage(named: "icon-female")
        static let femaleSelectedIcon = UIImage(named: "icon-femaleSelected")
    }
    
    struct HomeVC {
        static let tableNewsCellHeight: CGFloat = 320
        static let tableSuggestionCellHeight: CGFloat = 290
    }

}

protocol PatientHomeTableViewCellProtocol {
    func didTapSeeAll(choose: ChooseScreen)
    func moveDetailsScreen(choose: ChooseScreen, index: Int)
}

enum ChooseScreen{
    case newsScreen
    case promotionScreen
    case doctorScreen
}

enum Details {
    case news
    case promotion
}
