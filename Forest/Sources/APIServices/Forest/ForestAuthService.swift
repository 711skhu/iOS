//
//  ForestService.swift
//  Forest
//
//  Created by wookeon on 27/08/2019.
//  Copyright © 2019 wookeon. All rights reserved.
//

import Alamofire

struct ForestAuthService: APIManager {
    
    static let shared = ForestAuthService()
    
    // 종합정보시스템 로그인 API
    func forestLoginAPI(_ studentNumber: String, _ password: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        
        let url = setURL("/user/login")
        
        let header: HTTPHeaders = [
            "Content-Type" : "application/json",
            "Authorization" : "Bearer \(UserDefaults.standard.string(forKey: "Token") ?? "")"
        ]
        
        let body: Parameters = [
            "studentNumber": studentNumber,
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
                                    let result = try decoder.decode(ResponseDefault.self, from: value)
                                    
                                    switch result.code {
                                    case 201: // 로그인 성공
                                        completion(.success(result.message!))
                                    case 400: // 아이디, 비밀번호 nil, 잘못된 토큰
                                        completion(.requestErr(result.message!))
                                    case 401: // 토큰 불량
                                        completion(.requestErr(result.message!))
                                    case 404: // 로그인 실패, 대여페이지 연결 실패
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
}
