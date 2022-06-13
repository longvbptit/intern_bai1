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
    var listNews: ListNewsModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configView()
        fetchNews()
    }
    
    func configView(){
        tbvNews.registerCells(NewsTableViewCell.self, FirstNewsTableViewCell.self)
        tbvNews.delegate = self
        tbvNews.dataSource = self
        tbvNews.separatorColor = Constants.Color.gray
    }
    
    @objc func fetchNews() {
//        self.showLoaderView()
        APIUtilities.requestNews { [weak self] listNews, error in
            guard let self = self else { return}
//            self.dismissLoaderView()
//            self.refreshControl.endRefreshing()
            self.listNews = listNews

            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return}
//                Ultilities.loadImage(self.imvNews, strURL: listNews?.newsList[0].picture ?? "", placeHolder: Constants.Icon.imagePlacehold)
//                self.lblNewsTitle.text = self.listNews?.newsList[0].title ?? " "
//                self.lblDate.text = self.listNews?.newsList[0].created_at ?? " "
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
        vc.urlString = listNews?.newsList[indexPath.row].link
        vc.titles = "news"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension NewsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
//        print(listNews?.newsList.count  ?? 1)
        return (listNews?.newsList.count  ?? 0)
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(FirstNewsTableViewCell.self, indexPath: indexPath)
            let news = listNews?.newsList[indexPath.row]
            cell.configViews(news: news)
            cell.selectionStyle = .none
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(NewsTableViewCell.self, indexPath: indexPath)
            let news = listNews?.newsList[indexPath.row]
            cell.configViews(news: news)
            cell.selectionStyle = .none
            return cell
        }    
    }
    
    

}
