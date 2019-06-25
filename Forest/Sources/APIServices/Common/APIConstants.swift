//
//  APIConstants.swift
//  Forest
//
//  Created by wookeon on 30/05/2019.
//  Copyright © 2019 wookeon. All rights reserved.
//

struct APIConstants {
    // App
    static let BaseURL = "https://dev.mobile.shouwn.com"
    static let AppURL = BaseURL + "/student"
    static let AuthURL = AppURL + "/auth"
    static let SignUpURL = AuthURL + "/signUp"
    static let AppLoginURL = AuthURL + "/login"
    static let RefreshURL = AuthURL + "/token"
    
    
    // Forest
    static let StudentInfoURL = BaseURL + "/students/own"
    static let ForestURL = BaseURL + "/user"
    static let ForestLoginURL = ForestURL + "/login"
    static let RentalListURL = ForestURL + "/rentalList"
    static let RequestRentalURL = BaseURL + "/requestRental"
}
