//
//  NewsDetailsViewController.swift
//  Bai_1_Intern
//
//  Created by Bảo Long on 13/06/2022.
//

import UIKit
import WebKit
class DetailsViewController: UIViewController, WKNavigationDelegate {

    @IBOutlet weak var lblDetailsTitle: UILabel!
    @IBAction func btnBacnTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    var titles : String!
    @IBOutlet var viewNewsWebView: UIView!
    @IBOutlet weak var webNews: WKWebView!
    var newsWebView: WKWebView!
    var urlString : String!
    override func viewDidLoad() {
        super.viewDidLoad()
        if titles == "news" {
            lblDetailsTitle.text = LCString.titleNews.localized
        } else if titles == "promotion" {
            lblDetailsTitle.text = LCString.titlePromotion.localized
        }
        let url = URL(string: urlString)!
        webNews.load(URLRequest(url: url))
    }
}
