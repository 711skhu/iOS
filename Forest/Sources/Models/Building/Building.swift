//
//  Building.swift
//  Forest
//
//  Created by wookeon on 30/04/2019.
//  Copyright © 2019 wookeon. All rights reserved.
//

import Foundation

struct Building {
    var _title: String
    var _context: String
    var _buildingNumber: Int
    
    init(title: String, context: String, buildingNumber: Int) {
        self._title = title
        self._context = context
        self._buildingNumber = buildingNumber
    }
}
