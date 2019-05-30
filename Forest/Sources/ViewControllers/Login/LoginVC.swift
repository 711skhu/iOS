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
        setButtonShadow()
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
    
    func setButtonShadow() {
        loginButton.dropShadow(color: UIColor.black, offSet: CGSize(width: 0.0, height: 3.0), opacity: 0.16, radius: 6)
    }
    
    // UIButton 의 모서리를 둥글게 설정하는 함수
    func setButtonRounded() {
        loginButton.makeRounded(cornerRadius: nil)
    }
    
    // Login Btn Action
    @IBAction func loginBtnAction(_ sender: Any) {
        
        let startTime = CFAbsoluteTimeGetCurrent()
        /*
        // 옵셔널 바인딩
        guard let id = idTextField.text else { return }
        guard let pw = pwTextField.text else { return }
        */
        
//        AuthService.shared.login(username: "shon", password: "test123") {
//            (data) in
//
//            UserDefaults.standard.set(data.data?.token, forKey: "Token")
//        }
        
        // 통신을 시도합니다.
        ForestService.shared.loginForest(studentNumber: "201334019", password: "lejw2205", startTime: startTime) {
            (data) in
            
            switch (data.code) {
            case 201:
                
                // UserDefault 에 value, key 순으로 token 을 저장
//                UserDefaults.standard.set(data.data?.token, forKey: "Token")
                
                // Storyboard 가 다른 ViewController 로 화면 전환을 하는 코드입니다.
                // 이동할 뷰가 Navigation Controller 에 연결된 경우엔 그 앞의 NavigationController 를 목적지로 선택합니다.
//                let dvc = UIStoryboard(name: "Soptoon", bundle: nil).instantiateViewController(withIdentifier: "SoptoonNC") as! UINavigationController
                
//                self.present(dvc, animated: true, completion: nil)
                self.simpleAlert(title: "로그인 성공", message: self.gsno(data.message))
                
            case 400:
                self.simpleAlert(title: "로그인 실패", message: self.gsno(data.message))
                
            case 600:
                self.simpleAlert(title: "로그인 실패", message: self.gsno(data.message))
                
            default:
                break
            }
        }
    }
}
