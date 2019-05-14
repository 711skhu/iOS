//
//  Building.swift
//  Forest
//
//  Created by wookeon on 30/04/2019.
//  Copyright © 2019 wookeon. All rights reserved.
//

import Foundation
import UIKit

struct Building {
    var buildingImg: UIImage?
    var buildingName: String
    
    init(buildingName: String, imgName: String) {
        self.buildingImg = UIImage(named: imgName)
        self.buildingName = buildingName
    }
}
