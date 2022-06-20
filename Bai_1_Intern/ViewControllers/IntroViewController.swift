//
//  ViewController.swift
//  Bai_1_Intern
//
//  Created by Bảo Long on 08/05/2022.
//

import UIKit

class IntroViewController: UIViewController {
    
    //MARK: - IB Outlet
    @IBOutlet weak var clvIntro: UICollectionView!
    @IBOutlet weak var dots: UIPageControl!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnCreateAccount: UIButton!
    @IBOutlet weak var bgIntro: UIView!
    
    var introDetails : [IntroModel]!
    let gradient = CAGradientLayer()
    let startColor = Constants.Color.startGradientIntro.cgColor
    let endColor = Constants.Color.endGradientIntro.cgColor
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    //MARK: - Set up view
    func setupViews() {
        
        clvIntro.registerCells(IntroCollectionViewCell.self)
        
        //Disable clicking for dots
        dots.isUserInteractionEnabled = false
        dots.transform = CGAffineTransform(scaleX: 1, y: 1)
        dots.numberOfPages = 3
        
        gradient.colors = [startColor, endColor]
        gradient.locations = [NSNumber(floatLiteral: 0.0), NSNumber(floatLiteral: 1.0)]
        bgIntro.layer.insertSublayer(gradient, at: 0)
        
        btnCreateAccount.layer.borderColor = Constants.Color.borderBlue.cgColor
        btnCreateAccount.layer.borderWidth = 1
        
        let introImage1 : String = LCString.introImage1.localized
        let introTitle1: String = LCString.introTitle1.localized
        let introDetail1 :String = LCString.introDetail1.localized
        
        let introImage2 : String = LCString.introImage2.localized
        let introTitle2: String = LCString.introTitle2.localized
        let introDetail2 :String = LCString.introDetail2.localized
        
        let introImage3 : String = LCString.introImage3.localized
        let introTitle3: String = LCString.introTitle3.localized
        let introDetail3 :String = LCString.introDetail3.localized
        introDetails = [IntroModel(image: UIImage(named: introImage1), title: introTitle1, detail: introDetail1), IntroModel(image: UIImage(named: introImage2), title: introTitle2, detail: introDetail2), IntroModel(image: UIImage(named: introImage3), title: introTitle3, detail: introDetail3)]
        
        btnLogin.layer.cornerRadius = 24
        btnCreateAccount.layer.cornerRadius = 24
        
    }
    
    override func viewDidLayoutSubviews() {
        //gradient
        gradient.frame = bgIntro.bounds
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        dots.currentPage = Int(
            (clvIntro.contentOffset.x / clvIntro.frame.width)
                .rounded(.toNearestOrAwayFromZero)
        )
    }
    
    //MARK: - IBAction
    @IBAction func btnLoginTapped(_ sender: Any) {
        let vc = UIViewController.fromStoryboard(SignUpViewController.self)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnCreateAccountTapped(_ sender: Any) {
        let vc = UIViewController.fromStoryboard(SignUpViewController.self)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - UICollectionViewDataSource
extension IntroViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(IntroCollectionViewCell.self, indexPath: indexPath)
        cell.configViews(introDetails[indexPath.item])
        return cell
    }
    
}

//MARK: - UICollectionViewDelegate
extension IntroViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height)
    }
}
