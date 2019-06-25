//
//  RentalStateList.swift
//  Forest
//
//  Created by wookeon on 25/06/2019.
//  Copyright © 2019 wookeon. All rights reserved.
//

import Foundation

struct RentalStateList: Codable {
    let idx: Int
    let rentalState: String
    let rentalDate: RentalDate
}
