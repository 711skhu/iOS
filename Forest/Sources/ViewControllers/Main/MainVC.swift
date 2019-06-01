//
//  MainVC.swift
//  Forest
//
//  Created by wookeon on 29/04/2019.
//  Copyright © 2019 wookeon. All rights reserved.
//

import UIKit

class MainVC: UIViewController {
    
    @IBOutlet var buildingCollectionView: UICollectionView!
    
    var buildingList: [Building] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setBuildingData()
        
        buildingCollectionView.dataSource = self
        buildingCollectionView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        RentalService.shared.getRentalList {
            (data) in
            
            print(data)
        }
    }
    
}

extension MainVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return buildingList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = buildingCollectionView.dequeueReusableCell(withReuseIdentifier: "BuildingCell", for: indexPath) as! BuildingCell
        
        let building = buildingList[indexPath.row]
        
        cell.buildingImg.image = building.buildingImg
        
        return cell
    }
}

extension MainVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let dvc = storyboard?.instantiateViewController(withIdentifier: "BuildingVC") as! BuildingVC
        
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
        
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
}

extension MainVC {
    func setBuildingData() {
        let building1 = Building(buildingName: "승연관", imgName: "building1")
        let building2 = Building(buildingName: "일만관", imgName: "building1")
        let building3 = Building(buildingName: "월당관", imgName: "building1")
        let building4 = Building(buildingName: "이천환관", imgName: "building1")
        let building5 = Building(buildingName: "새천년관", imgName: "building1")
        let building6 = Building(buildingName: "미가엘관", imgName: "building1")
        let building7 = Building(buildingName: "성미가엘성당", imgName: "building1")
        
        buildingList = [building1, building2, building3, building4, building5, building6, building7]
    }
}
