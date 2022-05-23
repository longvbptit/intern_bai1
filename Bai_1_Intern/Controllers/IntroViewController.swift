//
//  ViewController.swift
//  Bai_1_Intern
//
//  Created by Bảo Long on 08/05/2022.
//

import UIKit


let intro_image: [String] = ["intro1", "intro2", "intro3"]
class IntroViewController: UIViewController {

    //MARK: IB Outlet
    @IBOutlet weak var intro_clv: UICollectionView!
    @IBOutlet weak var dots: UIPageControl!
    @IBOutlet weak var lg_btn: UIButton!
    @IBOutlet weak var createAcc_btn: UIButton!
    @IBOutlet weak var bgIntro: UIView!
//    @IBOutlet weak var myCollectionViewHeight: NSLayoutConstraint!
    
    var introDetails : [IntroModel]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        self.navigationController?.isNavigationBarHidden = true
        setupViews()
    }
    
    //MARK: Set up view
    func setupViews() {
        
        intro_clv.register(UINib(nibName: "IntroCLVCell", bundle: nil), forCellWithReuseIdentifier: "IntroCLVCell")
        dots.currentPage = Int(
                (intro_clv.contentOffset.x / intro_clv.frame.width)
                .rounded(.toNearestOrAwayFromZero)
            )

        //Disable clicking for dots
        dots.isUserInteractionEnabled = false
        dots.transform = CGAffineTransform(scaleX: 1, y: 1)

        createAcc_btn.clipsToBounds = true;
        createAcc_btn.layer.borderColor = #colorLiteral(red: 0.1411542892, green: 0.1647263467, blue: 0.3803414106, alpha: 1)
        createAcc_btn.layer.borderWidth = 1
        
        let intro1: String = "Bác sĩ sẵn lòng chăm sóc khi bạn cần"
        let introDetail1 :String = "Chọn chuyên khoa, bác sĩ phù hợp và được thăm khám trong không gian thoải mái tại nhà"
        let intro2: String = "Bác sĩ sẵn lòng chăm sóc khi bạn cần"
        let introDetail2 :String = "Chọn chuyên khoa, bác sĩ phù hợp và được thăm khám trong không gian thoải mái tại nhà"
        let intro3: String = "Bác sĩ sẵn lòng chăm sóc khi bạn cần"
        let introDetail3 :String = "Chọn chuyên khoa, bác sĩ phù hợp và được thăm khám trong không gian thoải mái tại nhà"
        introDetails = [IntroModel(image: UIImage(named: intro_image[0]), info1: intro1, info2: introDetail1), IntroModel(image: UIImage(named: intro_image[1]), info1: intro2, info2: introDetail2), IntroModel(image: UIImage(named: intro_image[2]), info1: intro3, info2: introDetail3)]
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //gradient
        let gradient = CAGradientLayer()
        let startColor = #colorLiteral(red: 0.6509803922, green: 0.9450980392, blue: 0.968627451, alpha: 1).cgColor
        let endColor = #colorLiteral(red: 0.952855885, green: 0.9608387351, blue: 0.9841964841, alpha: 1).cgColor
        gradient.frame = bgIntro.bounds
        gradient.colors = [startColor, endColor]
        gradient.locations = [NSNumber(floatLiteral: 0.0), NSNumber(floatLiteral: 1.0)]
        gradient.frame = bgIntro.bounds
        bgIntro.layer.insertSublayer(gradient, at: 0)
        lg_btn.layer.cornerRadius = lg_btn.frame.height / 2
        createAcc_btn.layer.cornerRadius = createAcc_btn.frame.height / 2
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        dots.currentPage = Int(
            (intro_clv.contentOffset.x / intro_clv.frame.width)
                .rounded(.toNearestOrAwayFromZero)
            )
    }
    
    //MARK: IBAction
    @IBAction func login_act(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SignUpViewController") as? SignUpViewController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func cre_act(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SignUpViewController") as? SignUpViewController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    

}

//MARK: UICollectionViewDelegate

extension IntroViewController {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dots.numberOfPages = intro_image.count
        return intro_image.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "IntroCLVCell", for: indexPath) as! IntroCLVCell
        cell.configViews(introDetails[indexPath.item])
        return cell
    }
    
}

extension IntroViewController:  UICollectionViewDataSource {
    
}

extension IntroViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height - 30)

    }
}
