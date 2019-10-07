//
//  BuildingVC.swift
//  Forest
//
//  Created by wookeon on 29/04/2019.
//  Copyright © 2019 wookeon. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class BuildingVC: UIViewController, NVActivityIndicatorViewable {

    @IBOutlet weak var classroomCollectionView: UICollectionView!
    var classroomList: [Classroom] = []
    var buildingName: String?
    var buildingNumber: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setNavigationBar()
        classroomCollectionView.dataSource = self
        classroomCollectionView.delegate = self
        
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getClassroomList()
    }
    
    func setNavigationBar() {
        setBackBtn(color: UIColor(red: 112/255, green: 112/255, blue: 112/255, alpha: 1.0))
        guard let buildingName = buildingName else { return }
        self.navigationItem.title = buildingName
    }
    
    func getClassroomList() {
        
        guard let buildingNumber = buildingNumber else { return }
        setActivityIndicator()
        
        RentalService.shared.getClassroomList(buildingNumber) {
            [weak self]
            (response, error) in
            
            guard let self = self else { return }
            guard let response = response else { return }
            
            print(response.data)
            
            switch response.code {
            case 200:
                self.classroomList = response.data
                self.classroomCollectionView.reloadData()
                
            default:
                self.simpleAlert(title: "조회 실패", message: response.message)
            }
            
            self.removeActivityIndicator()
        }
    }
    
    // Activity Indicator 를 띄운다.
    func setActivityIndicator() {
        self.view.endEditing(true)
        
        let size = CGSize(width: 30, height: 30)
        
        startAnimating(size, message: "서버에 요청 중...", type: .ballSpinFadeLoader, fadeInAnimation: nil)
    }
    
    // Activity Indicator 를 제거한다.
    func removeActivityIndicator() {
        self.stopAnimating(nil)
    }
}

extension BuildingVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return classroomList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = classroomCollectionView.dequeueReusableCell(withReuseIdentifier: "ClassroomCell", for: indexPath) as! ClassroomCell
        
        let classroom = classroomList[indexPath.row]
        
        cell.lectureCode.text = classroom.classroomName
        cell.capacity.text = "\(classroom.people)"
        
        if classroom.detailType == "PROJECTOR" {
            cell.projectorImg.alpha = 1
        }
        
        return cell
    }
}

extension BuildingVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let classroom = classroomList[indexPath.row]
        
        let dvc = storyboard?.instantiateViewController(withIdentifier: "DateVC") as! DateVC
        
        dvc.buildingName = buildingName
        dvc.lectureCode = classroom.classroomName
        
        navigationController?.pushViewController(dvc, animated: true)
    }
}

extension BuildingVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width: CGFloat = (view.frame.width - 30) / 2
        let height: CGFloat = (width)/1.0443038
        
        return CGSize(width: width, height: height)
    }
    
    // minimumLineSpacingForSectionAt 은 수직 방향에서의 Spacing 을 의미합니다.
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 15
    }
    
    // minimumInteritemSpacingForSectionAt 은 수평 방향에서의 Spacing 을 의미합니다.
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    // insetForSectionAt 섹션 내부 여백을 말합니다.
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 16, left: 15, bottom: 0, right: 15)
    }
}
