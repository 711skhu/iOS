//
//  RentalList.swift
//  Forest
//
//  Created by wookeon on 31/05/2019.
//  Copyright © 2019 wookeon. All rights reserved.
//

struct RentalList: Codable {
    let idx: Int
    let rentalDate: RentalDate
    let rentalState: String
    let lectureCode: String
    let cancle: Bool?
}
