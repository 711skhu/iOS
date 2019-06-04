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
    
    @IBOutlet weak var logoImageView: UIImageView!
    // Constraint Outlet
    @IBOutlet weak var logoLeading: NSLayoutConstraint!
    @IBOutlet weak var logoTrailing: NSLayoutConstraint!
    @IBOutlet weak var logoVertical: NSLayoutConstraint!
    @IBOutlet weak var stackViewLeading: NSLayoutConstraint!
    @IBOutlet weak var stackViewTrailing: NSLayoutConstraint!
    @IBOutlet weak var stackViewCenterY: NSLayoutConstraint!
    @IBOutlet weak var labelLeading: NSLayoutConstraint!
    @IBOutlet weak var labelTrailing: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setConstraint()
        setViewRounded()
        setButtonRounded()
        setViewBorder()
        setButtonShadow()
        
        initGestureRecognizer()
        
        autoLogin()
    }
    
    func autoLogin() {
        
        guard UserDefaults.standard.string(forKey: "Id") != nil else { return }
        guard UserDefaults.standard.string(forKey: "Password") != nil else { return }
        guard UserDefaults.standard.string(forKey: "Token") != nil else { return }
        guard UserDefaults.standard.string(forKey: "StudentNumber") != nil else { return }
        guard UserDefaults.standard.string(forKey: "StudentNumberPassword") != nil else { return }
        
        login()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        registerForKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        unregisterForKeyboardNotifications()
    }
    
    // 작은 화면에 대한 대응
    func setConstraint() {
        if self.view.layer.frame.width < 375 {
            logoLeading.constant = 28
            logoTrailing.constant = 28
            stackViewLeading.constant = 28
            stackViewTrailing.constant = 28
            labelLeading.constant = 28
            labelTrailing.constant = 28
            logoVertical.constant = 24
        }
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
    
    func login() {
        guard let id = idTextField.text else { return }
        guard let pw = pwTextField.text else { return }
        
        // 통신을 시도합니다.
        AuthService.shared.appAuth(id, pw) {
            (data) in
            
            switch data {
                
            case .success(let token):
                UserDefaults.standard.set(token, forKey: "Token")
                UserDefaults.standard.set(id, forKey: "Id")
                UserDefaults.standard.set(pw, forKey: "Password")
                
                if UserDefaults.standard.string(forKey : "StudentNumber") != nil && UserDefaults.standard.string(forKey : "StudentNumberPassword") != nil {
                    let dvc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainNC") as! UINavigationController
                    
                    self.present(dvc, animated: true)
                } else {
                    let dvc = self.storyboard?.instantiateViewController(withIdentifier: "AuthVC") as! AuthVC
                    
                    self.present(dvc, animated: true)
                }
                
            case .requestErr(let message):
                self.simpleAlert(title: "로그인 실패", message: message as! String)
            case .pathErr:
                self.simpleAlert(title: "로그인 실패", message: "잘못된 접근입니다.")
            case .serverErr:
                self.simpleAlert(title: "로그인 실패", message: "점검 중 입니다.")
            case .networkFail:
                self.simpleAlert(title: "로그인 실패", message: "네트워크 상태를 확인해주세요.")
            }
        }
    }
    
    // Login Btn Action
    @IBAction func loginBtnAction(_ sender: Any) {
        login()
    }
}

extension LoginVC: UIGestureRecognizerDelegate {
    
    func initGestureRecognizer() {
        let textFieldTap = UITapGestureRecognizer(target: self, action: #selector(handleTapTextField(_:)))
        textFieldTap.delegate = self
        view.addGestureRecognizer(textFieldTap)
    }
    
    @objc func handleTapTextField(_ sender: UITapGestureRecognizer) {
        self.idTextField.resignFirstResponder()
        self.pwTextField.resignFirstResponder()
    }
    
    
    func gestureRecognizer(_ gestrueRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if (touch.view?.isDescendant(of: idTextField))! || (touch.view?.isDescendant(of: pwTextField))! {
            
            return false
        }
        return true
    }
    
    @objc func keyboardWillShow(_ notification: NSNotification) {
        
        guard let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else { return }
        guard let curve = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt else { return }
        
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
    
        let keyboardHeight: CGFloat
        
        if #available(iOS 11.0, *) {
            keyboardHeight = keyboardFrame.cgRectValue.height - self.view.safeAreaInsets.bottom
        } else {
            keyboardHeight = keyboardFrame.cgRectValue.height
        }
        
        UIView.animate(withDuration: duration, delay: 0.0, options: .init(rawValue: curve), animations: {
            
            self.logoImageView.alpha = 0
            self.stackViewCenterY.constant = -keyboardHeight/2
        })
        self.view.layoutIfNeeded()
    }
    
    @objc func keyboardWillHide(_ notification: NSNotification) {
        guard let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else {return}
        guard let curve = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt else {return}
        UIView.animate(withDuration: duration, delay: 0.0, options: .init(rawValue: curve), animations: {
            self.logoImageView.alpha = 1.0
            self.stackViewCenterY.constant = 0
        })
        
        self.view.layoutIfNeeded()
    }
    
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    func unregisterForKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}
