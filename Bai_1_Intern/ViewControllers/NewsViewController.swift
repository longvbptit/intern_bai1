//
//  NewsViewController.swift
//  Bai_1_Intern
//
//  Created by Bảo Long on 12/06/2022.
//

import UIKit

class NewsViewController: UIViewController {

//    @IBOutlet weak var imvNews: UIImageView!
//    @IBOutlet weak var lblNewsTitle: UILabel!
//    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var tbvNews: UITableView!
    
    @IBAction func btnBackTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    lazy var refreshControl: UIRefreshControl = {
            let rfc  = UIRefreshControl()
            return rfc
        }()
    
    var listNews: [NewsModel]?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configView()
        fetchNews()
    }
    
    func configView(){
        
        self.refreshControl.addTarget(self, action: #selector(fetchNews), for: .valueChanged)
        tbvNews.refreshControl = refreshControl
        
        tbvNews.registerCells(NewsTableViewCell.self, FirstNewsTableViewCell.self)
        tbvNews.delegate = self
        tbvNews.dataSource = self
        tbvNews.separatorColor = Constants.Color.gray
        tbvNews.tableFooterView = UIView()
    }
    
    func showLoaderView( toView: UIView? = nil) {
        self.view.endEditing(true)
        ProgressHUD.colorStatus = .black
        ProgressHUD.show(LCString.loading.localized, interaction: false)
    }
    
    func dismissLoaderView() {
        ProgressHUD.dismiss()
    }
    
    
    @objc func fetchNews() {
        self.showLoaderView()
        APIUtilities.requestNews { [weak self] listNews, error in
            guard let self = self else { return}
            self.dismissLoaderView()
            self.refreshControl.endRefreshing()
            self.listNews = listNews

            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return}
                self.tbvNews.reloadData()
            }
        }
    }
}

extension NewsViewController: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 296
        }
        else {
            return 102
        }
//        return UITableView.automaticDimension
    }
    
    internal func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        let vc = UIViewController.fromStoryboard(DetailsViewController.self)
        vc.urlString = listNews?[indexPath.row].link
        vc.titles = Details.news
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension NewsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return (listNews?.count  ?? 0)
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(FirstNewsTableViewCell.self, indexPath: indexPath)
            let news = listNews?[indexPath.row]
            cell.configViews(news: news)
            cell.selectionStyle = .none
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(NewsTableViewCell.self, indexPath: indexPath)
            let news = listNews?[indexPath.row]
            cell.configViews(news: news)
            cell.selectionStyle = .none
            return cell
        }    
    }
    
    

}
