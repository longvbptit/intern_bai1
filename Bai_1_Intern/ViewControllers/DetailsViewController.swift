//
//  NewsDetailsViewController.swift
//  Bai_1_Intern
//
//  Created by Bảo Long on 13/06/2022.
//

import UIKit
import WebKit
//import ToastViewSwift

class DetailsViewController: UIViewController {
    
    //MARK: - IB Outlet
    @IBOutlet weak var lblDetailsTitle: UILabel!
    @IBOutlet weak var aivLoadWebView: UIActivityIndicatorView!
    @IBOutlet weak var webNews: WKWebView!
    
    var titles : Details!
    var newsWebView: WKWebView!
    var urlString : String!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch self.titles {
        case .news:
            lblDetailsTitle.text = LCString.titleNews.localized
        case .promotion:
            lblDetailsTitle.text = LCString.titlePromotion.localized
        default : lblDetailsTitle.text = LCString.titleNews.localized
        }
        
        let url = URL(string: urlString)!
        self.webNews.load(URLRequest(url: url))
        self.webNews.layer.borderColor = Constants.Color.borderGray.cgColor
        self.webNews.layer.borderWidth = 1
        self.webNews.navigationDelegate = self
    }
 
    //MARK: - IB Action
    @IBAction func btnBacnTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnCopyURLTapped(_ sender: Any) {
        UIPasteboard.general.string = urlString
        print("Copy to clipboard")
        //        let notiCopyURL = Toast.text("Copy to clipboard")
        //                notiCopyURL.show()
    }
}

extension DetailsViewController: WKNavigationDelegate{
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        aivLoadWebView.startAnimating()
        aivLoadWebView.isHidden = false
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        aivLoadWebView.isHidden = true
        aivLoadWebView.stopAnimating()
    }
}
