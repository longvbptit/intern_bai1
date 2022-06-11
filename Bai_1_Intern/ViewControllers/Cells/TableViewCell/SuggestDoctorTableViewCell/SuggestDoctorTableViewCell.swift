//
//  SuggestDoctorTableViewCell.swift
//  Bai_1_Intern
//
//  Created by Bảo Long on 03/06/2022.
//

import UIKit

class SuggestDoctorTableViewCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var clvSuggestion: UICollectionView!
    @IBOutlet weak var btnShowListDoctor: UIButton!
    var showListDoctor: (() -> Void)? = nil
    @IBAction func btnShowListDoctorTapped(_ sender: UIButton) {
//        let patientHomeViewController = UIViewController.fromStoryboard(PatientHomeViewController.self)
//        let doctorViewController = UIViewController.fromStoryboard(DoctorViewController.self)
//        patientHomeViewController.navigationController?.pushViewController(doctorViewController, animated: true)
        showListDoctor?()
    }
    var doctorList     : [PatientDoctorListModel]?
    var pushVCHandler: (() -> ())? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        lblTitle.text = " "
        clvSuggestion.registerCells(SuggestDoctorCollectionViewCell.self)
        clvSuggestion.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        clvSuggestion.delegate = self
        clvSuggestion.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configViews(doctorList: [PatientDoctorListModel]?, pushVCHandler: (() -> ())?) {
        self.pushVCHandler = pushVCHandler
        
        lblTitle.text = "Giới thiệu bác sĩ"
        self.doctorList = doctorList
        clvSuggestion.reloadData()
    }
    
}

extension SuggestDoctorTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = 137
        return CGSize(width: width, height: Int(collectionView.bounds.height))
    }
}

extension SuggestDoctorTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return doctorList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(SuggestDoctorCollectionViewCell.self, indexPath: indexPath)
        
        let doctorInfo = doctorList?[indexPath.item]
        cell.configViews(doctorInfo: doctorInfo)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
