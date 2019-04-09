//
//  LoginVC.swift
//  Forest
//
//  Created by wookeon on 19/03/2019.
//  Copyright © 2019 wookeon. All rights reserved.
//

import UIKit

    // LoginViewController
class LoginVC: UIViewController {

    // Interface Builder Outlet
    @IBOutlet weak var idView: UIView!
    @IBOutlet weak var pwView: UIView!
    
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var pwTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    
    // ViewDidLoad() -> View 가 Load 된 후에 호출
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setViewRounded()
        setButtonRounded()
        setViewBorder()
    }
    
    // UIView 의 테두리를 설정하는 함수
    func setViewBorder() {
        idView.setBorder(borderColor: UIColor(red: 205/255, green: 209/255, blue: 208/255, alpha: 1.0), borderWidth: 1.0)
        pwView.setBorder(borderColor: UIColor(red: 205/255, green: 209/255, blue: 208/255, alpha: 1.0), borderWidth: 1.0)
    }
    
    // UIView 의 모서리를 둥글게 설정하는 함수
    func setViewRounded() {
        idView.makeRounded(cornerRadius: nil)
        pwView.makeRounded(cornerRadius: nil)
    }
    
    // UIButton 의 모서리를 둥글게 설정하는 함수
    func setButtonRounded() {
        loginButton.makeRounded(cornerRadius: nil)
    }
    
    
    @IBAction func loginBtnAction(_ sender: Any) {
        
        self.simpleAlert(title: "로그인 실패", message: "아이디 또는 비밀번호가 틀립니다.")
    }
}
