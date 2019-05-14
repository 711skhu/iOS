//
//  APIManager.swift
//  Forest
//
//  Created by wookeon on 09/04/2019.
//  Copyright © 2019 wookeon. All rights reserved.
//

protocol APIManager {}

extension APIManager {
    static func url(_ path: String) -> String {
        return "https://dev.mobile.shouwn.com" + path
    }
}
