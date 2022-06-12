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
        tbvNewsFeed.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        tbvNewsFeed.delegate = self
        tbvNewsFeed.dataSource = self
    }
    
    func showLoaderView( toView: UIView? = nil) {
        self.view.endEditing(true)
        ProgressHUD.colorStatus = .black
        ProgressHUD.show(LCString.loading.localized, interaction: false)
    }
    
    func dismissLoaderView() {
        ProgressHUD.dismiss()
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
                guard let self = self else { return}

                self.tbvNewsFeed.reloadData()
            }
        }
    }
    
    @objc func seeAllDoctor(_ sender: Any?){
        let vc = UIViewController.fromStoryboard(DoctorViewController.self)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func seeAllNews(_ sender: Any?){
        let vc = UIViewController.fromStoryboard(NewsViewController.self)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func seeAllPromotion(_ sender: Any?){
        let vc = UIViewController.fromStoryboard(DoctorViewController.self)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension PatientHomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.item == 2 {
            return Constants.HomeVC.tableSuggestionCellHeight
        }
        return Constants.HomeVC.tableNewsCellHeight
    }
}

extension PatientHomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.item == 0 {
            let cell = tableView.dequeueReusableCell(PatientHomeTableViewCell.self, indexPath: indexPath)
            cell.selectionStyle = .none
            cell.configViews(articleList: newFeed?.articleList, pushVCHandler: { [weak self] vc in
                guard let self = self else { return }
                
                self.show(vc, sender: nil)
            })
            cell.btnSeeAll.addTarget(self, action: #selector(PatientHomeViewController.seeAllNews(_:)), for: .touchUpInside)
            return cell
        }
        
        if indexPath.item == 1 {
            let cell = tableView.dequeueReusableCell(PatientHomeTableViewCell.self, indexPath: indexPath)
            cell.selectionStyle = .none
            cell.configViews(promotionList: newFeed?.promotionList, pushVCHandler: { [weak self] vc in
                guard let self = self else { return }
                
                self.show(vc, sender: nil)
            })
            
            return cell
        }
        
        if indexPath.item == 2 {
            let cell = tableView.dequeueReusableCell(SuggestDoctorTableViewCell.self, indexPath: indexPath)
            cell.selectionStyle = .none
            cell.configViews(doctorList: newFeed?.doctorList, pushVCHandler: {
                
            })
            cell.btnShowListDoctor.addTarget(self, action: #selector(PatientHomeViewController.seeAllDoctor(_:)), for: .touchUpInside)
//            cell.showListDoctor = {
//                let vc = UIViewController.fromStoryboard(DoctorViewController.self)
//                self.navigationController?.pushViewController(vc, animated: true)
//            print("Hello")
//            }
            
            return cell
        }
        fatalError()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) -> Bool {
        return false
    }
}
