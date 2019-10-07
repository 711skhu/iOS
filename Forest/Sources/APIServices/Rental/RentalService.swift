//
//  RentalService.swift
//  Forest
//
//  Created by wookeon on 31/05/2019.
//  Copyright © 2019 wookeon. All rights reserved.
//
import Alamofire
import Foundation

struct RentalService: APIManager {
    
    static let shared = RentalService()
    
    func getMyRentalList(completion: @escaping (ResponseArray<RentalList>?, Error?) -> Void) {
        
        let url = Self.setURL("/user/rentalList")
            
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil)
            .responseJSON {
                response in
                
                switch response.result {
                case .success:
                    if let data = response.data {
                        do {
                            let decoder = JSONDecoder()
                            let result = try decoder.decode(ResponseArray<RentalList>.self, from: data)
                            completion(result, nil)
                        } catch (let error) {
                            print("getMyRentalList(catch): \(error.localizedDescription)")
                            completion(nil, error)
                        }
                    }
                case .failure(let e):
                    print("getMyRentalList(failure): \(e.localizedDescription)")
                    completion(nil, e)
                }
        }
    }
    
    func deleteMyRentalList(_ idx: Int, completion: @escaping (ResponseDefault?, Error?) -> Void) {
        
        let url = Self.setURL("/user/rental/\(idx)")
        
        Alamofire.request(url, method: .delete, parameters: nil, encoding: JSONEncoding.default, headers: nil)
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
                            print("deleteMyRentalList(catch): \(error.localizedDescription)")
                            completion(nil, error)
                        }
                    }
                case .failure(let e):
                    print("deleteMyRentalList(failure): \(e.localizedDescription)")
                    completion(nil, e)
                }
        }
    }
    
    func getClassroomList(_ buildingNumber: Int, completion: @escaping (ResponseArray<Classroom>?, Error?) -> Void) {
        
        let url = Self.setURL("/buildings/\(buildingNumber)/classrooms")
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil)
            .responseJSON {
                response in
                
                switch response.result {
                case .success:
                    if let data = response.data {
                        do {
                            let decoder = JSONDecoder()
                            let result = try decoder.decode(ResponseArray<Classroom>.self, from: data)
                            completion(result, nil)
                        } catch (let error) {
                            print("getClassroomList(catch): \(error.localizedDescription)")
                            completion(nil, error)
                        }
                    }
                case .failure(let e):
                    print("getClassroomList(failure): \(e.localizedDescription)")
                    completion(nil, e)
                }
        }
    }
    
    func getRentalStatus(_ lectureCode: String, _ date: String, completion: @escaping (ResponseArray<RentalStateList>?, Error?) -> Void) {
        
        let url = Self.setURL("/classrooms/\(lectureCode)/\(date)/rentalList")
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil)
            .responseJSON {
                response in
                
                switch response.result {
                case .success:
                    if let data = response.data {
                        do {
                            let decoder = JSONDecoder()
                            let result = try decoder.decode(ResponseArray<RentalStateList>.self, from: data)
                            completion(result, nil)
                        } catch (let error) {
                            print("getClassroomList(catch): \(error.localizedDescription)")
                            completion(nil, error)
                        }
                    }
                case .failure(let e):
                    print("getClassroomList(failure): \(e.localizedDescription)")
                    completion(nil, e)
                }
        }
    }
    
    func requestRental(_ startTime: String, _ endTime: String, _ reason: String, _ peopleList: String, _ phoneNumber: String, completion: @escaping (ResponseDefault?, Error?) -> Void) {
        
        let url = Self.setURL("/requestRental")
        
        let header: HTTPHeaders = [
            "Content-Type" : "application/json"
        ]
        
        let body: Parameters = [
            "startTime": startTime,
            "endTime": endTime,
            "reason": reason,
            "peopleList": peopleList,
            "phoneNumber": phoneNumber
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
                            print("getClassroomList(catch): \(error.localizedDescription)")
                            completion(nil, error)
                        }
                    }
                case .failure(let e):
                    print("getClassroomList(failure): \(e.localizedDescription)")
                    completion(nil, e)
                }
        }
    }
}
