//
//  NetworkResult.swift
//  Forest
//
//  Created by wookeon on 09/04/2019.
//  Copyright © 2019 wookeon. All rights reserved.
//

enum NetworkResult<T> {
    case success(T)
    case requestErr(T)
    case pathErr
    case encodingErr
    case unexpectedErr
    case serverErr
    case networkFail
}
