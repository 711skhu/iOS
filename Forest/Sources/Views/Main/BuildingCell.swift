//
//  BuildingCell.swift
//  Forest
//
//  Created by wookeon on 23/06/2019.
//  Copyright © 2019 wookeon. All rights reserved.
//

import UIKit

class BuildingCell: UICollectionViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var context: UILabel!
    @IBOutlet weak var background: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        background.layer.cornerRadius = 10
        background.layer.masksToBounds = true
    }
}
