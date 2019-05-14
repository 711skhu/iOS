//
//  ResponseObject.swift
//  Forest
//
//  Created by wookeon on 09/04/2019.
//  Copyright © 2019 wookeon. All rights reserved.
//

import ObjectMapper

struct ResponseObject<T: Mappable>: Mappable {
    
    var code: Int?
    var status: String?
    var message: String?
    var data: T?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        code <- map["code"]
        status <- map["status"]
        message <- map["message"]
        data <- map["data"]
    }
}
