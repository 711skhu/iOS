//
//  BuildingCell.swift
//  Forest
//
//  Created by wookeon on 07/05/2019.
//  Copyright © 2019 wookeon. All rights reserved.
//

import UIKit

class BuildingCell: UICollectionViewCell {

    @IBOutlet var buildingImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        buildingImg.layer.cornerRadius = 12
        buildingImg.layer.masksToBounds = true
    }

}
