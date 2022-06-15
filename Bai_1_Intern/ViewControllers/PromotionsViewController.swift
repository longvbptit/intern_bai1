//
//  PromotionsViewController.swift
//  Bai_1_Intern
//
//  Created by Bảo Long on 13/06/2022.
//

import UIKit

class PromotionsViewController: UIViewController {

    @IBOutlet weak var tbvPromotions: UITableView!
    @IBAction func btnBackTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    lazy var refreshControl: UIRefreshControl = {
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
    }
    
    func showLoaderView( toView: UIView? = nil) {
        self.view.endEditing(true)
        ProgressHUD.colorStatus = .black
        ProgressHUD.show(LCString.loading.localized, interaction: false)
    }
    
    func dismissLoaderView() {
        ProgressHUD.dismiss()
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
//        return UITableView.automaticDimension
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
        return cell
    }
}
