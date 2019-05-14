//
//  BuildingCell.swift
//  Forest
//
//  Created by wookeon on 07/05/2019.
//  Copyright © 2019 wookeon. All rights reserved.
//

import UIKit

class BuildingCell: UICollectionViewCell {

    @IBOutlet var BuildingImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        BuildingImg.layer.cornerRadius = 12
        BuildingImg.layer.masksToBounds = true
    }

}
