//
//  ViewController.swift
//  Bai_1_Intern
//
//  Created by Bảo Long on 08/05/2022.
//

import UIKit

let intro_image: [String] = ["intro1", "intro2", "intro3"]

class IntroViewController: UIViewController {

    @IBOutlet weak var intro_clv: UICollectionView!
    @IBOutlet weak var dots: UIPageControl!

    @IBOutlet weak var lg_btn: UIButton!
    @IBOutlet weak var createAcc_btn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        intro_clv.register(UINib(nibName: "IntroCLVCell", bundle: nil), forCellWithReuseIdentifier: "IntroCLVCell")
        dots.currentPage = Int(
                (intro_clv.contentOffset.x / intro_clv.frame.width)
                .rounded(.toNearestOrAwayFromZero)
            )
        //Disable clicking for dots
        dots.isUserInteractionEnabled = false
        
        lg_btn.layer.cornerRadius = lg_btn.frame.size.height
        
        createAcc_btn.layer.cornerRadius = createAcc_btn.frame.size.height 
        createAcc_btn.clipsToBounds = true;
        createAcc_btn.layer.borderColor = (UIColor.black).cgColor
        createAcc_btn.layer.borderWidth = 1
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        dots.currentPage = Int(
            (intro_clv.contentOffset.x / intro_clv.frame.width)
                .rounded(.toNearestOrAwayFromZero)
            )
    }


}

extension IntroViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        dots.numberOfPages = intro_image.count
        return intro_image.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "IntroCLVCell", for: indexPath) as! IntroCLVCell
        
        cell.backGround.image = UIImage(named: "bg_intro")
//        var index_path = 0
//        for intro in intro_image{
//            if(indexPath.row == index_path){
//                cell.intro_img.image = UIImage(named: intro)
//                index_path += 1
//            }
//        }
        for index in 0...2{
            if(indexPath.row == index){
                cell.intro_img.image = UIImage(named: intro_image[index])
                
            }
        }
        
        return cell
    }

//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
//
//    }
    
}

extension IntroViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
//        if UIDevice.current.userInterfaceIdiom == .pad{
//            return CGSize(width: screenWidth, height: screenHeight*0.46)
//        }
        return CGSize(width: screenWidth, height: screenHeight*0.46)

    }
}
