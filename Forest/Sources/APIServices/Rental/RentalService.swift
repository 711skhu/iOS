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
                                    case 200:
                                        completion(.success(result.data!))
                                    case 401:
                                        completion(.requestErr(result.message!))
                                    case 412:
                                        completion(.requestErr(result.message!))
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
    
    // Classroom List API
    func getClassroomList(buildingNumber: Int, completion: @escaping (NetworkResult<Any>) -> Void) {
        
        let URL = APIConstants.BaseURL + "/buildings/\(buildingNumber)/classrooms"
        
        let header: HTTPHeaders = [
            "Authorization" : "Bearer \(UserDefaults.standard.string(forKey: "Token") ?? "")"
        ]
        
        Alamofire.request(URL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header)
            .responseData { response in
                
                switch response.result {
                    
                case .success:
                    if let value = response.result.value {
                        if let status = response.response?.statusCode {
                            
                            switch status {
                            case 200:
                                do {
                                    let decoder = JSONDecoder()
                                    let result = try decoder.decode(ResponseArray<Classroom>.self, from: value)
                                    
                                    switch result.code {
                                    case 200:
                                        completion(.success(result.data!))
                                    case 401:
                                        completion(.requestErr(result.message!))
                                    case 412:
                                        completion(.requestErr(result.message!))
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
    
    // Rental State List API
    func getRentalStateList(lectureCode: String, date: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        
        let URL = APIConstants.BaseURL + "/classrooms/\(lectureCode)/\(date)/rentalList"
        
        let header: HTTPHeaders = [
            "Authorization" : "Bearer \(UserDefaults.standard.string(forKey: "Token") ?? "")"
        ]
        
        Alamofire.request(URL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header)
            .responseData { response in
                
                switch response.result {
                    
                case .success:
                    if let value = response.result.value {
                        if let status = response.response?.statusCode {
                            
                            switch status {
                            case 200:
                                do {
                                    let decoder = JSONDecoder()
                                    let result = try decoder.decode(ResponseArray<RentalStateList>.self, from: value)
                                    
                                    switch result.code {
                                    case 200:
                                        completion(.success(result.data!))
                                    case 401:
                                        completion(.requestErr(result.message!))
                                    case 412:
                                        completion(.requestErr(result.message!))
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
    
    // Rental State List API
    func requestRental(startTime: String, endTime: String, reason: String, peopleList: String, phoneNumber: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        
        let header: HTTPHeaders = [
            "Authorization" : "Bearer \(UserDefaults.standard.string(forKey: "Token") ?? "")"
        ]
        
        let body: Parameters = [
            "startTime": startTime,
            "endTime": endTime,
            "reason": reason,
            "peopleList": peopleList,
            "phoneNumber": phoneNumber
        ]
        
        Alamofire.request(APIConstants.RequestRentalURL, method: .post, parameters: body, encoding: JSONEncoding.default, headers: header)
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
                                    case 200:
                                        completion(.success(result.message!))
                                    case 401:
                                        completion(.requestErr(result.message!))
                                    case 412:
                                        completion(.requestErr(result.message!))
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
