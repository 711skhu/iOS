//
//  Token.swift
//  Forest
//
//  Created by wookeon on 14/05/2019.
//  Copyright © 2019 wookeon. All rights reserved.
//

import ObjectMapper

struct Token: Mappable {
    
    var token: String?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        token <- map["token"]
    }
}

