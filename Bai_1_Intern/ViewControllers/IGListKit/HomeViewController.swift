//
//  HomeViewController.swift
//  Bai_1_Intern
//
//  Created by Bảo Long on 13/07/2022.
//

import UIKit
import IGListKit

class HomeViewController: UIViewController {

    
    lazy var adapter: ListAdapter = {
      return ListAdapter(
      updater: ListAdapterUpdater(),
      viewController: self,
      workingRangeSize: 0)
    }()
    
    //MARK: - IB Outlet
    @IBOutlet weak var lblFullName: UILabel!
    @IBOutlet weak var imvIsActive: UIImageView!
    @IBOutlet weak var lblIsActive: UILabel!
    @IBOutlet weak var tbvNewsFeed: UITableView!
    
    var newFeed: PatientNewFeedModel?
    
    lazy var refreshControl: UIRefreshControl = {
        let rfc = UIRefreshControl()
        
        return rfc
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @objc func fetchPatientNewFeed() {
        self.showLoaderView()
        APIUtilities.requestHomePatientFeed { [weak self] patientNewFeed, error in
            guard let self = self else { return}
            self.dismissLoaderView()
            self.refreshControl.endRefreshing()

            guard let patientNewFeed = patientNewFeed, error == nil else {
                return
            }

            self.newFeed = patientNewFeed

            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.tbvNewsFeed.reloadData()
            }
        }
    }
    
    func showLoaderView( toView: UIView? = nil) {
        self.view.endEditing(true)
        ProgressHUD.colorStatus = .black
        ProgressHUD.show(LCString.loading.localized, interaction: false)
    }
    
    func dismissLoaderView() {
        ProgressHUD.dismiss()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
