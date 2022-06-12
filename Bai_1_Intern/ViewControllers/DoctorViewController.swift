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
    @IBOutlet weak var clvDoctor: UICollectionView!
    
    
    var listDoctor     : ListDoctorModel?
    
    var pushVCHandler: (() -> ())? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configView()
        fetchDoctor()
    }
    
    func configView(){
        clvDoctor.registerCells(DoctorCollectionViewCell.self)
        clvDoctor.contentInset = UIEdgeInsets(top: 12, left: 16, bottom: 0, right: 16)
        clvDoctor.delegate = self
        clvDoctor.dataSource = self
    }
    
    @objc func fetchDoctor() {
//        self.showLoaderView()
        APIUtilities.requestDoctors{ [weak self] doctorList, error in
            guard let self = self else { return }
//            self.dismissLoaderView()
//            self.refreshControl.endRefreshing()

            guard let doctorList = doctorList, error == nil else {
                return
            }

            self.listDoctor = doctorList

            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.clvDoctor.reloadData()
            }
        }
    }

}

extension DoctorViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 32, height: 150)

        }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
}

extension DoctorViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listDoctor?.doctorList.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(DoctorCollectionViewCell.self, indexPath: indexPath)
        let doctor = listDoctor?.doctorList[indexPath.item]
        cell.configViews(doctorInfo: doctor)
        return cell
    }
}
