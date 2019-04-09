//
//  SignUpVC.swift
//  Forest
//
//  Created by wookeon on 02/04/2019.
//  Copyright © 2019 wookeon. All rights reserved.
//

import UIKit

    // SignUpViewController
class SignUpVC: UIViewController {
    
    // Interface Builder Outlet
    @IBOutlet weak var idView: UIView!
    @IBOutlet weak var pwView: UIView!
    @IBOutlet weak var pwCheckView: UIView!
    @IBOutlet weak var emailView: UIView!
    
    @IBOutlet var pwTextField: UITextField!
    @IBOutlet var pwCheckTextField: UITextField!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    
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
        pwCheckView.setBorder(borderColor: UIColor(red: 205/255, green: 209/255, blue: 208/255, alpha: 1.0), borderWidth: 1.0)
        emailView.setBorder(borderColor: UIColor(red: 205/255, green: 209/255, blue: 208/255, alpha: 1.0), borderWidth: 1.0)
    }
    
    // UIView 의 모서리를 둥글게 설정하는 함수
    func setViewRounded() {
        idView.makeRounded(cornerRadius: nil)
        pwView.makeRounded(cornerRadius: nil)
        pwCheckView.makeRounded(cornerRadius: nil)
        emailView.makeRounded(cornerRadius: nil)
    }
    
    // UIButton 의 모서리를 둥글게 설정하는 함수
    func setButtonRounded() {
        signUpButton.makeRounded(cornerRadius: nil)
    }
    
    func setButtonShadow() {
        signUpButton.dropShadow(color: UIColor.black, offSet: CGSize(width: 0.0, height: 3.0), opacity: 0.16, radius: 6)
    }
    
    
    // ID Duplicated Btn Action
    @IBAction func idDuplicatedBtnAction(_ sender: Any) {
        
        self.simpleAlert(title: "중복된 아이디입니다.\n다시 입력해주세요.", message: "")
        
    }
    
    // Email Duplicated Btn Action
    @IBAction func emailDuplicatedBtnAction(_ sender: Any) {
        
        self.simpleAlert(title: "중복된 이메일입니다.\n다시 입력해주세요.", message: "")
    }
    
   // SignUp Btn Action
    @IBAction func signUpBtnAction(_ sender: Any) {
    
        if pwTextField.text != pwCheckTextField.text {
            simpleAlert(title: "비밀번호가 일치하지 않습니다.\n다시 입력해주세요.", message: "")
        }
    }
    
    // Navigation Bar, Left Btn Action
    @IBAction func backBtnAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
}


// SignUpVC+Extensions
extension SignUpVC {
    
    // Id Valid Check
    func isValidId(id: String) -> Bool {
        
        let idRegEx = "^[A-Z0-9a-z]{4,12}$"
        
        let idTest = NSPredicate(format:"SELF MATCHES %@", idRegEx)
        
        return idTest.evaluate(with: id)
    }
    
    // Password Valid Check
    func isValidPw(password: String) -> Bool {
        
        print("extension:\(password)")
        
        let pwRegEx = "^(?=.*[0-9])(?=.*[a-z]).{8,}$"
        
        let pwTest = NSPredicate(format: "SELF MATCHES %@", pwRegEx)
        
        return pwTest.evaluate(with: password)
    }
    
    // Email Valid Check
    func isValidEmailAddress(email: String) -> Bool {
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        
        return emailTest.evaluate(with: email)
    }
}
