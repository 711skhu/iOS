//
//  AuthService.swift
//  Forest
//
//  Created by wookeon on 14/05/2019.
//  Copyright © 2019 wookeon. All rights reserved.
//

import Alamofire

struct AppAuthService: APIManager {
    
    static let shared = AppAuthService()
    
    // 앱 로그인 API
    func appLoginAPI(_ username: String, _ password: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        
        let url = setURL("/student/auth/login")
        
        let header: HTTPHeaders = [
            "Content-Type": "application/json"
        ]
        
        let body: Parameters = [
            "username": username,
            "password": password
        ]
        
        Alamofire.request(url, method: .post, parameters: body, encoding: JSONEncoding.default, headers: header)
            .responseData { response in
                
                switch response.result {
                    
                case .success:
                    if let value = response.result.value {
                        if let status = response.response?.statusCode {
                            
                            switch status {
                            case 200: // 통신 성공
                                do {
                                    let decoder = JSONDecoder()
                                    let result = try decoder.decode(ResponseObject<Token>.self, from: value)
                                    
                                    switch result.code {
                                    case 201: // 로그인 성공
                                        completion(.success(result.data as Any))
                                    case 401: // 비밀번호가 틀립니다.
                                        completion(.requestErr(result.message!))
                                    case 404: // 유저 정보가 없습니다.
                                        completion(.requestErr(result.message!))
                                    default: // 예상치 못한 에러 발생
                                        completion(.unexpectedErr)
                                    }
                                } catch { // json decoder error
                                    completion(.encodingErr)
                                }
                            case 400: // 경로 에러
                                completion(.pathErr)
                            case 500: // 서버 에러
                                completion(.serverErr)
                                
                            default: // 예상치 못한 에러 발생
                                break
                            }
                        }
                    }
                    break
                    
                case .failure(let err): // 인터넷 연결이 없을 때
                    print(err.localizedDescription)
                    completion(.networkFail)
                    break
                }
        }
    }
    
    // 앱 회원가입 API
    func appSignUpAPI(_ name: String, _ username: String, _ password: String, _ email: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        
        let url = setURL("student/auth/signUp")
        
        let header: HTTPHeaders = [
            "Content-Type": "application/json"
        ]
        
        let body: Parameters = [
            "name": name,
            "username": username,
            "password": password,
            "email": email
        ]
        
        Alamofire.request(url, method: .post, parameters: body, encoding: JSONEncoding.default, headers: header)
            .responseData { response in
                
                switch response.result {
                    
                case .success:
                    if let value = response.result.value {
                        if let status = response.response?.statusCode {
                            
                            switch status {
                            case 200: // 통신 성공
                                do {
                                    let decoder = JSONDecoder()
                                    let result = try decoder.decode(ResponseObject<Token>.self, from: value)
                                    
                                    switch result.code {
                                    case 201: // 회원가입 성공
                                        completion(.success(result.data as Any))
                                    case 412: // 비밀번호 강도 부적합
                                        completion(.requestErr(result.message!))
                                    default: // 예상치 못한 에러 발생
                                        completion(.unexpectedErr)
                                    }
                                } catch { // json decoder error
                                    completion(.encodingErr)
                                }
                            case 400: // 경로 에러
                                completion(.pathErr)
                            case 500: // 서버 에러
                                completion(.serverErr)
                                
                            default: // 예상치 못한 에러 발생
                                break
                            }
                        }
                    }
                    break
                    
                case .failure(let err): // 인터넷 연결이 없을 때
                    print(err.localizedDescription)
                    completion(.networkFail)
                    break
                }
        }
    }
    
    // 토큰 재발급 API
    func getNewTokenAPI(completion: @escaping (NetworkResult<Any>) -> Void) {
        
        let url = setURL("student/auth/token")
        
        let header: HTTPHeaders = [
            "Content-Type": "application/json"
        ]
        
        let body: Parameters = [
            "refreshToken": "\(UserDefaults.standard.string(forKey: "RefreshToken") ?? "")"
        ]
        
        Alamofire.request(url, method: .post, parameters: body, encoding: JSONEncoding.default, headers: header)
            .responseData { response in
                
                switch response.result {
                    
                case .success:
                    if let value = response.result.value {
                        if let status = response.response?.statusCode {
                            
                            switch status {
                            case 200: // 통신 성공
                                do {
                                    let decoder = JSONDecoder()
                                    let result = try decoder.decode(ResponseObject<Token>.self, from: value)
                                    
                                    switch result.code {
                                    case 201: // 토큰 재발급 완료
                                        completion(.success(result.data as Any))
                                    case 400: // 토큰 부적합
                                        completion(.requestErr(result.message!))
                                    default: // 예상치 못한 에러 발생
                                        completion(.unexpectedErr)
                                    }
                                } catch { // json decoder error
                                    completion(.encodingErr)
                                }
                            case 400: // 경로 에러
                                completion(.pathErr)
                            case 500: // 서버 에러
                                completion(.serverErr)
                                
                            default: // 예상치 못한 에러 발생
                                break
                            }
                        }
                    }
                    break
                    
                case .failure(let err): // 인터넷 연결이 없을 때
                    print(err.localizedDescription)
                    completion(.networkFail)
                    break
                }
        }
    }
    
    // 개인정보 조회 API
    func getUserInfoAPI(completion: @escaping (NetworkResult<Any>) -> Void) {
        
        let header: HTTPHeaders = [
            "Content-Type" : "application/json",
            "Authorization" : "Bearer \(UserDefaults.standard.string(forKey: "Token") ?? "")"
        ]
        
        Alamofire.request(APIConstants.StudentInfoURL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header)
            .responseData { response in
                
                switch response.result {
                    
                case .success:
                    if let value = response.result.value {
                        if let status = response.response?.statusCode {
                            
                            
                            switch status {
                            case 200: // 통신 성공
                                do {
                                    let decoder = JSONDecoder()
                                    let result = try decoder.decode(ResponseObject<StudentInfo>.self, from: value)
                                    
                                    switch result.code {
                                    case 200: // 조회 성공
                                        completion(.success(result.data!))
                                    case 404: // 유저 정보가 없습니다.
                                        completion(.requestErr(result.message!))
                                    default: // 예상치 못한 에러 발생
                                        completion(.pathErr)
                                    }
                                } catch { // json decoder error
                                    completion(.pathErr)
                                }
                            case 400: // 경로 에러
                                completion(.pathErr)
                            case 500: // 서버 에러
                                completion(.serverErr)
                                
                            default: // 예상치 못한 에러 발생
                                break
                            }
                        }
                    }
                    break
                    
                case .failure(let err): // 인터넷 연결이 없을 때
                    print(err.localizedDescription)
                    completion(.networkFail)
                    break
                }
        }
    }
}
