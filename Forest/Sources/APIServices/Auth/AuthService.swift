//
//  AuthService.swift
//  Forest
//
//  Created by wookeon on 14/05/2019.
//  Copyright © 2019 wookeon. All rights reserved.
//

import Alamofire

struct AuthService: APIManager, Requestable {
    
    typealias NetworkData = ResponseObject<Token>
    static let shared = AuthService()
    let AuthURL = url("/student")
    let headers: HTTPHeaders = [
        "Content-Type" : "application/json"
    ]
    
    // "Authorization" : "Bearer +Token"
    
    // 로그인 api
    func login(username: String, password: String, completion: @escaping (ResponseObject<Token>) -> Void) {
        
        let queryURL = AuthURL + "/login"
        
        let body = [
            "username" : username,
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
