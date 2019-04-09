//
//  NetworkResult.swift
//  Forest
//
//  Created by wookeon on 09/04/2019.
//  Copyright © 2019 wookeon. All rights reserved.
//

enum NetworkResult<T> {
    case success(T)
    case error(Error)
}
