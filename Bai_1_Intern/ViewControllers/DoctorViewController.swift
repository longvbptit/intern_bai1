//
//  DoctorViewController.swift
//  Bai_1_Intern
//
//  Created by Bảo Long on 10/06/2022.
//

import UIKit

class DoctorViewController: UIViewController {
    
    @IBAction func btnBackTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBOutlet weak var tbvDoctor: UITableView!
    
    lazy var refreshControl: UIRefreshControl = {
        let rfc = UIRefreshControl()
        
        return rfc
    }()
    
    var listDoctor     : [DoctorModel]?
    let cellSpacingHeight: CGFloat = 11
    
    var pushVCHandler: (() -> ())? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configView()
        fetchDoctor()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.tbvDoctor.contentInset = UIEdgeInsets(top: 12, left: 0, bottom: 0, right: 0)
    }
    
    func configView(){
        
        self.refreshControl.addTarget(self, action: #selector(fetchDoctor), for: .valueChanged)
        tbvDoctor.refreshControl = refreshControl
        
        tbvDoctor.registerCells(DoctorTableViewCell.self)
        tbvDoctor.delegate = self
        tbvDoctor.dataSource = self
    }
    
    
    func showLoaderView( toView: UIView? = nil) {
        self.view.endEditing(true)
        ProgressHUD.colorStatus = .black
        ProgressHUD.show(LCString.loading.localized, interaction: false)
    }
    
    func dismissLoaderView() {
        ProgressHUD.dismiss()
    }
    
    @objc func fetchDoctor() {
        self.showLoaderView()
        self.refreshControl.isHidden = true
        APIUtilities.requestDoctors{ [weak self] doctorList, error in
            guard let self = self else { return }
            self.dismissLoaderView()
            self.refreshControl.endRefreshing()
            
            guard let doctorList = doctorList, error == nil else {
                return
            }
            
            self.listDoctor = doctorList
            
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.tbvDoctor.reloadData()
            }
        }
    }
    
}

extension DoctorViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 128
    }
    
    // Set the spacing between sections
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cellSpacingHeight
    }
    
    // Make the background color show through
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
}

extension DoctorViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return self.listDoctor?.count ?? 0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(DoctorTableViewCell.self, indexPath: indexPath)
        let doctor = listDoctor?[indexPath.section]
        cell.configViews(doctorInfo: doctor)
        cell.selectionStyle = .none
        return cell
    }
}
