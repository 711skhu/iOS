//
//  AuthService.swift
//  Forest
//
//  Created by wookeon on 14/05/2019.
//  Copyright © 2019 wookeon. All rights reserved.
//

import Alamofire
import Foundation

struct AuthService: APIManager {
    
    static let shared = AuthService()
    
    func forestAuth(_ studentNumber: String, _ password: String, completion: @escaping (ResponseDefault?, Error?) -> Void) {
        
        let url = Self.setURL("/user/login")
        
        let header: HTTPHeaders = [
            "Content-Type" : "application/json"
        ]
        
        let body: Parameters = [
                "studentNumber": studentNumber,
                "password": password
        ]
        
        Alamofire.request(url, method: .post, parameters: body, encoding: JSONEncoding.default, headers: header)
            .responseJSON {
                response in
                switch response.result {
                case .success:
                    if let data = response.data {
                        do {
                            let decoder = JSONDecoder()
                            let result = try decoder.decode(ResponseDefault.self, from: data)
                            completion(result, nil)
                        } catch (let error) {
                            print("forestAuth(catch): \(error.localizedDescription)")
                            completion(nil, error)
                        }
                    }
                case .failure(let e):
                    print("forestAuth(failure): \(e.localizedDescription)")
                    completion(nil, e)
                }
        }
    }
}
