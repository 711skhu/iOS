//
//  AuthService.swift
//  Forest
//
//  Created by wookeon on 14/05/2019.
//  Copyright © 2019 wookeon. All rights reserved.
//

import Alamofire

struct AuthService: APIManager, Requestable {
    
    typealias NetworkData = ResponseObject
    static let shared = AuthService()
    let AuthURL = url("/auth")
    let headers: HTTPHeaders = [
        "Content-Type" : "application/json"
    ]
    
    // 로그인 api
    func signin(id: String, password: String, completion: @escaping (ResponseObject) -> Void) {
        
        let queryURL = AuthURL + "/signin"
        
        let body = [
            "id" : id,
            "password" : password
        ]
        
        postable(queryURL, body: body, header: headers) { res in
            switch res {
            case .success(let value):
                
                print("######### success #########")
                print(value)
                print("######### success #########")
                
                completion(value)
            case .error(let error):
                
                print("######### error #########")
                print(error)
                print("######### error #########")
            }
        }
    }
}
