//
//  ResponseArray.swift
//  Forest
//
//  Created by wookeon on 09/04/2019.
//  Copyright © 2019 wookeon. All rights reserved.
//

struct ResponseArray<T: Codable>: Codable {
    
    let code: Int?
    let status: String?
    let message: String?
    let data: [T]?
}
