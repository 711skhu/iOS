//
//  ClassroomCell.swift
//  Forest
//
//  Created by wookeon on 24/06/2019.
//  Copyright © 2019 wookeon. All rights reserved.
//

import UIKit

class ClassroomCell: UICollectionViewCell {
    
    @IBOutlet weak var classroomImg: UIImageView!
    @IBOutlet weak var lectureCode: UILabel!
    @IBOutlet weak var capacity: UILabel!
    @IBOutlet weak var projectorImg: UIImageView!
    @IBOutlet weak var background: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        projectorImg.alpha = 0
        background.layer.cornerRadius = 12
        background.layer.masksToBounds = true
        background.setBorder(borderColor: UIColor(red: 205/255, green: 209/255, blue: 208/255, alpha: 1.0), borderWidth: 1.0)
    }
}
