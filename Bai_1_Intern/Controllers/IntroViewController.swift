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
    
    @IBAction func login_act(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SignUpViewController") as? SignUpViewController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func cre_act(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SignUpViewController") as? SignUpViewController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true

        intro_clv.register(UINib(nibName: "IntroCLVCell", bundle: nil), forCellWithReuseIdentifier: "IntroCLVCell")
        dots.currentPage = Int(
                (intro_clv.contentOffset.x / intro_clv.frame.width)
                .rounded(.toNearestOrAwayFromZero)
            )
        
        //Disable clicking for dots
        dots.isUserInteractionEnabled = false
        
        lg_btn.layer.cornerRadius = 18
        
        createAcc_btn.layer.cornerRadius = 18
        createAcc_btn.clipsToBounds = true;
        createAcc_btn.layer.borderColor = #colorLiteral(red: 0.1411542892, green: 0.1647263467, blue: 0.3803414106, alpha: 1)
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
        cell.bgIntro_img.image = UIImage(named: "bg_intro")
        cell.inf1_lb.text = "Bác sĩ sẵn lòng chăm sóc khi bạn cần"
        cell.inf2_lb.text = "Chọn chuyên khoa, bác sĩ phù hợp và được thăm khám trong không gian thoải mái tại nhà"

        for index in 0...2{
            if(indexPath.row == index){
                cell.intro_img.image = UIImage(named: intro_image[index])
            }
        }
        return cell
    }
    
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
        return CGSize(width: UIScreen.main.bounds.width, height: collectionView.frame.size.height)

    }
}
