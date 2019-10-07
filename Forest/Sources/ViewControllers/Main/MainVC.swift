//
//  MainVC.swift
//  Forest
//
//  Created by wookeon on 29/04/2019.
//  Copyright © 2019 wookeon. All rights reserved.
//

import UIKit

class MainVC: UIViewController {
    
    
    @IBOutlet weak var buildingCollectionView: UICollectionView!
    @IBOutlet weak var rentalListTableView: UITableView!
    @IBOutlet weak var studentName: UILabel!
    
    var buildingList: [Building] = []
    var rentalList: [RentalList] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBuildingData()
        
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
        
        rentalListTableView.rowHeight = UITableView.automaticDimension
        
        rentalListTableView.layer.cornerRadius = 10
        rentalListTableView.layer.masksToBounds = true
        rentalListTableView.delegate = self
        rentalListTableView.dataSource = self
        buildingCollectionView.dataSource = self
        buildingCollectionView.delegate = self
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //getStudentInfo()
        getMyRentalList()
    }
    
    func getMyRentalList() {
        RentalService.shared.getMyRentalList() {
            [weak self]
            (response, error) in
            
            guard let self = self else { return }
            guard let response = response else { return }
            
            print(response.data)
            
            switch response.code {
            case 200:
                self.rentalList = response.data
                self.rentalListTableView.reloadData()

            default:
                self.simpleAlert(title: "조회 실패", message: response.message)
            }
        }
    }
    /*
    func getStudentInfo() {        
        AuthService.shared.getStudentInfo() {
            [weak self]
            (data) in
            guard let `self` = self else { return }
            
            switch data {
                
            case .success(let result):
                let _result = result as! StudentInfo
                
                self.studentName.text = "\(_result.name) 님!"
                
            case .requestErr(let message):
                print(message)
            case .pathErr:
                print("pathErr")
            case .serverErr:
                print("serverErr")
            case .networkFail:
                self.simpleAlert(title: "연결 실패", message: "네트워크 상태를 확인해주세요.")
            }
        }
    }
     */
    
    @IBAction func unwindToMain(_ sender: UIStoryboardSegue) {
    
    }
}

extension MainVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return buildingList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = buildingCollectionView.dequeueReusableCell(withReuseIdentifier: "BuildingCell", for: indexPath) as! BuildingCell
        
        let building = buildingList[indexPath.row]
        
        cell.title.text = building._title
        cell.context.text = building._context
        
        return cell
    }
}

extension MainVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let building = buildingList[indexPath.row]
        
        let dvc = storyboard?.instantiateViewController(withIdentifier: "BuildingVC") as! BuildingVC
        
        dvc.buildingName = building._title
        dvc.buildingNumber = building._buildingNumber
        
        navigationController?.pushViewController(dvc, animated: true)
    }
}

extension MainVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width: CGFloat = (view.frame.width - 32)
        let height: CGFloat = (width)/2.8583333
        
        return CGSize(width: width, height: height)
    }
    
    // minimumLineSpacingForSectionAt 은 수직 방향에서의 Spacing 을 의미합니다.
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 16
    }
    
    // minimumInteritemSpacingForSectionAt 은 수평 방향에서의 Spacing 을 의미합니다.
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    // insetForSectionAt 섹션 내부 여백을 말합니다.
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}

extension MainVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 73
    }
}

extension MainVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return rentalList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = rentalListTableView.dequeueReusableCell(withIdentifier: "RentalListCell") as! RentalListCell
        
        let rental = rentalList[indexPath.row]
        
        cell.rentalState.text = rental.rentalState
        cell.lectureCode.text = rental.lectureCode
        cell.rentalDate.text = rental.rentalDate.rentalDate
        cell.rentalTime.text = "\(rental.rentalDate.startTime):00 ~ \(rental.rentalDate.endTime-1):59"
        
        if let cancle = rental.cancle {
            cell.cancleBtn.isHidden = cancle
        }
        
        return cell
    }
}

extension MainVC {
    func setBuildingData() {
        let building1 = Building(title: "승연관", context: "승연관의 강의실 코드는\n\"1\"(으)로 시작합니다", buildingNumber: 1)
        let building2 = Building(title: "일만관", context: "일만관의 강의실 코드는\n\"2\"(으)로 시작합니다", buildingNumber: 2)
        let building3 = Building(title: "월당관", context: "월당관의 강의실 코드는\n\"3\"(으)로 시작합니다", buildingNumber: 3)
        let building4 = Building(title: "이천환관(정보과학관)", context: "이천환관의 강의실 코드는\n\"6\"(으)로 시작합니다", buildingNumber: 6)
        let building5 = Building(title: "새천년관", context: "새천년관의 강의실 코드는\n\"7\"(으)로 시작합니다", buildingNumber: 7)
        let building6 = Building(title: "미가엘관", context: "미가엘관의 강의실 코드는\n\"M\"(으)로 시작합니다", buildingNumber: 11)
        let building7 = Building(title: "성미가엘성당", context: "성미가엘성당의 강의실 코드는\n\"9\"(으)로 시작합니다", buildingNumber: 9)
        
        buildingList = [building1, building2, building3, building4, building5, building6, building7]
    }
}
