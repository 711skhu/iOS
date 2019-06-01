//
//  AuthService.swift
//  Forest
//
//  Created by wookeon on 14/05/2019.
//  Copyright © 2019 wookeon. All rights reserved.
//

import Alamofire

struct AuthService {
    
    static let shared = AuthService()
    
    // App Auth API
    func appAuth(_ username: String, _ password: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        
        let header: HTTPHeaders = [
            "Content-Type" : "application/json"
        ]
        
        let body: Parameters = [
            "username": username,
            "password": password
        ]
        
        Alamofire.request(APIConstants.AppAuthURL, method: .post, parameters: body, encoding: JSONEncoding.default, headers: header)
            .responseData { response in
                
                switch response.result {
                    
                case .success:
                    if let value = response.result.value {
                        if let status = response.response?.statusCode {
                            
                            switch status {
                            case 200:
                                do {
                                    let decoder = JSONDecoder()
                                    let result = try decoder.decode(ResponseObject<Token>.self, from: value)
                                    
                                    switch result.code {
                                    case 201:
                                        completion(.success(result.data?.token))
                                    case 403:
                                        completion(.requestErr(result.message))
                                    case 412:
                                        completion(.requestErr(result.message))
                                    default:
                                        completion(.pathErr)
                                    }
                                } catch {
                                    completion(.pathErr)
                                }
                            case 400:
                                completion(.pathErr)
                            case 500:
                                completion(.serverErr)
                                
                            default:
                                break
                            }
                        }
                    }
                    break
                    
                case .failure(let err):
                    print(err.localizedDescription)
                    completion(.networkFail)
                    break
                }
        }
    }
    
    // Forest Auth API
    func forestAuth(_ studentNumber: String, _ password: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        
        let header: HTTPHeaders = [
            "Content-Type" : "application/json",
            "Authorization" : "Bearer \(UserDefaults.standard.string(forKey: "Token") ?? "")"
        ]
        
        let body: Parameters = [
            "studentNumber": studentNumber,
            "password": password
        ]
        
        Alamofire.request(APIConstants.AppAuthURL, method: .post, parameters: body, encoding: JSONEncoding.default, headers: header)
            .responseData { response in
                
                switch response.result {
                    
                case .success:
                    if let value = response.result.value {
                        if let status = response.response?.statusCode {
                            
                            switch status {
                            case 200:
                                do {
                                    let decoder = JSONDecoder()
                                    let result = try decoder.decode(ResponseDefault.self, from: value)
                                    
                                    switch result.code {
                                    case 201:
                                        completion(.success(result.message))
                                    case 401:
                                        completion(.requestErr(result.message))
                                    case 403:
                                        completion(.requestErr(result.message))
                                    case 412:
                                        completion(.requestErr(result.message))
                                    default:
                                        completion(.pathErr)
                                    }
                                } catch {
                                    completion(.pathErr)
                                }
                            case 400:
                                completion(.pathErr)
                            case 500:
                                completion(.serverErr)
                                
                            default:
                                break
                            }
                        }
                    }
                    break
                    
                case .failure(let err):
                    print(err.localizedDescription)
                    completion(.networkFail)
                    break
                }
        }
    }
}
