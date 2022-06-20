//
//  PromotionsViewController.swift
//  Bai_1_Intern
//
//  Created by Bảo Long on 13/06/2022.
//

import UIKit

class PromotionsViewController: UIViewController {
    
    //MARK: IB Outlet
    @IBOutlet weak var tbvPromotions: UITableView!
    @IBOutlet weak var viwPromotionFilter: UIView!
    @IBOutlet weak var viwTitle: UIView!
    
    var refreshControl: UIRefreshControl = {
        let rfc = UIRefreshControl()
        
        return rfc
    }()
    var listPromotions: [PromotionModel]?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configView()
        fetchPromotion()
    }
    
    func configView(){
        
        self.refreshControl.addTarget(self, action: #selector(fetchPromotion), for: .valueChanged)
        tbvPromotions.refreshControl = refreshControl
        
        tbvPromotions.registerCells(PromotionsTableViewCell.self)
        tbvPromotions.delegate = self
        tbvPromotions.dataSource = self
        tbvPromotions.separatorColor = Constants.Color.gray
        tbvPromotions.tableFooterView = UIView()
        
        viwPromotionFilter.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
        viwPromotionFilter.layer.shadowOpacity = 1
        viwPromotionFilter.layer.shadowRadius = 20
        viwPromotionFilter.layer.shadowOffset = CGSize(width: 0, height: 4)

    }
    
    func showLoaderView( toView: UIView? = nil) {
        self.view.endEditing(true)
        ProgressHUD.colorStatus = .black
        ProgressHUD.show(LCString.loading.localized, interaction: false)
    }
    
    func dismissLoaderView() {
        ProgressHUD.dismiss()
    }
    
    //MARK: - IB Action
    @IBAction func btnBackTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func fetchPromotion() {
        self.showLoaderView()
        APIUtilities.requestPromotions { [weak self] listPromotions, error in
            guard let self = self else { return}
            self.dismissLoaderView()
            self.refreshControl.endRefreshing()
            self.listPromotions = listPromotions
            
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return}
                self.tbvPromotions.reloadData()
            }
        }
    }
}

extension PromotionsViewController: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 102
    }
    
    internal func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        let vc = UIViewController.fromStoryboard(DetailsViewController.self)
        vc.urlString = listPromotions?[indexPath.row].link
        vc.titles = Details.promotion
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension PromotionsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return (listPromotions?.count  ?? 0)
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(PromotionsTableViewCell.self, indexPath: indexPath)
        let promotion = listPromotions?[indexPath.row]
        cell.configViews(promotion: promotion)
        cell.selectionStyle = .none
        
        //hide separator at the last item
        if (indexPath.row == (self.listPromotions?.count ?? 0) - 1) {
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: UIScreen.main.bounds.width);
        }
        return cell
    }
}
