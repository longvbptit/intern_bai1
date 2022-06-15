//
//  PatientHomeTableViewCell.swift
//  Bai_1_Intern
//
//  Created by Bảo Long on 01/06/2022.
//

import UIKit

class PatientHomeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var cltvHome: UICollectionView!
    @IBOutlet weak var btnSeeAll: UIButton!
    var delegate: PatientHomeTableViewCellProtocol?
    
    var articleList     : [PatientArticleListModel]?
    var promotionList     : [PatientPromotionListModel]?
    var pushVCHandler: ((UIViewController) -> ())? = nil
    override func awakeFromNib() {
        super.awakeFromNib()
        
        lbTitle.text = " "
        cltvHome.registerCells(NewsCollectionViewCell.self)
        cltvHome.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        
        cltvHome.delegate = self
        cltvHome.dataSource = self
    }
    
    func configViews(articleList: [PatientArticleListModel]?, pushVCHandler: ((UIViewController) -> ())?) {
        self.pushVCHandler = pushVCHandler
        
        lbTitle.text = "Tin Tức"
        self.articleList = articleList
        self.promotionList = nil
        cltvHome.reloadData()
    }
    
    func configViews(promotionList: [PatientPromotionListModel]?, pushVCHandler: ((UIViewController) -> ())?) {
        self.pushVCHandler = pushVCHandler
        
        lbTitle.text = "Khuyến mại"
        self.articleList = nil
        self.promotionList = promotionList
        cltvHome.reloadData()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func btnSeeAllTapped(_ sender: Any) {
        if let articleList = articleList {
            delegate?.didTapSeeAll(choose: ChooseScreen.newsScreen)
        } else {
            delegate?.didTapSeeAll(choose: ChooseScreen.promotionScreen)
        }
    }
    
}

extension PatientHomeTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = 290
        return CGSize(width: width, height: Int(collectionView.bounds.height) - 28)
    }
}

extension PatientHomeTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let articleList = articleList {
            return articleList.count
        }
        
        return promotionList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(NewsCollectionViewCell.self, indexPath: indexPath)
        
        
        if let articleList = articleList {
            
            let news = articleList[indexPath.item]
            cell.configViews(news: news)
            
            return cell
        }
        
        let promotion = promotionList?[indexPath.item]
        cell.configViews(promotion: promotion)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let articleList = articleList {
            delegate?.moveDetailsScreen(choose: ChooseScreen.newsScreen, index: indexPath.row)
        } else {
            delegate?.moveDetailsScreen(choose: ChooseScreen.promotionScreen, index: indexPath.row)
        }
    }
}
