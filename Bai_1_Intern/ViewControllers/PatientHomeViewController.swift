//
//  PatientHomeViewController.swift
//  Bai_1_Intern
//
//  Created by Bảo Long on 31/05/2022.
//

import UIKit

class PatientHomeViewController: UIViewController {
    @IBOutlet weak var lblFullName: UILabel!
    @IBOutlet weak var imvIsActive: UIImageView!
    @IBOutlet weak var lblIsActive: UILabel!
    @IBOutlet weak var imvAvatar: UIImageView!
    @IBOutlet weak var tbvNewsFeed: UITableView!
    
    var newFeed: PatientNewFeedModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
        fetchPatientNewFeed()
        // Do any additional setup after loading the view.
    }
    
    lazy var refreshControl: UIRefreshControl = {
        let rfc = UIRefreshControl()
        
        return rfc
    }()
    
    
    func setUpView(){
        
        tbvNewsFeed.registerCells(PatientHomeTableViewCell.self, SuggestDoctorTableViewCell.self)
        
        tbvNewsFeed.delegate = self
        tbvNewsFeed.dataSource = self
    }
    
    @objc func fetchPatientNewFeed() {
//        self.showLoaderView()
        APIUtilities.requestHomePatientFeed { [weak self] patientNewFeed, error in
            guard let self = self else { return}
//            self.dismissLoaderView()
            self.refreshControl.endRefreshing()

            guard let patientNewFeed = patientNewFeed, error == nil else {
                return
            }

            self.newFeed = patientNewFeed

            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return}

                self.tbvNewsFeed.reloadData()
            }
        }
    }
    
}

extension PatientHomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.HomeVC.tableNewsCellHeight
    }
}

extension PatientHomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.item == 0 {
            let cell = tableView.dequeueReusableCell(PatientHomeTableViewCell.self, indexPath: indexPath)
            cell.configViews(articleList: newFeed?.articleList, pushVCHandler: { [weak self] vc in
                guard let self = self else { return }
                
                self.show(vc, sender: nil)
            })
            
            return cell
        }
        
        if indexPath.item == 1 {
            let cell = tableView.dequeueReusableCell(PatientHomeTableViewCell.self, indexPath: indexPath)
            cell.configViews(promotionList: newFeed?.promotionList, pushVCHandler: { [weak self] vc in
                guard let self = self else { return }
                
                self.show(vc, sender: nil)
            })
            
            return cell
        }
        fatalError()
    }
}
