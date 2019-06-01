//
//  RentalService.swift
//  Forest
//
//  Created by wookeon on 31/05/2019.
//  Copyright © 2019 wookeon. All rights reserved.
//

import Alamofire

struct RentalService {
    
    static let shared = RentalService()
    
    // Rental List API
    func getRentalList(completion: @escaping (NetworkResult<Any>) -> Void) {
        
        let header: HTTPHeaders = [
            "Authorization" : "Bearer \(UserDefaults.standard.string(forKey: "Token") ?? "")"
        ]
        
        Alamofire.request(APIConstants.RentalListURL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header)
            .responseData { response in
                
                switch response.result {
                    
                case .success:
                    if let value = response.result.value {
                        if let status = response.response?.statusCode {
                            
                            switch status {
                            case 200:
                                do {
                                    let decoder = JSONDecoder()
                                    let result = try decoder.decode(ResponseArray<RentalList>.self, from: value)
                                    
                                    switch result.code {
                                    case 201:
                                        completion(.success([result.data]))
                                    case 401:
                                        completion(.requestErr(result.message))
                                    case 403:
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
