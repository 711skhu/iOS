//
//  RentalRequestVC.swift
//  Forest
//
//  Created by wookeon on 25/06/2019.
//  Copyright © 2019 wookeon. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class RentalRequestVC: UIViewController, NVActivityIndicatorViewable {
    
    // 넘겨 받을 데이터
    var lectureCode: String?
    var buildingName: String?
    var date: String?
    var startTime: String?
    var endTime: String?
    
    // Oulet
    @IBOutlet weak var locationTitle: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var rentalDateTitle: UILabel!
    @IBOutlet weak var rentalDate: UILabel!
    @IBOutlet weak var reasonTitle: UILabel!
    @IBOutlet weak var reasonTextField: UITextField!
    @IBOutlet weak var peopleTextView: UITextView!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var requestBtn: UIButton!
    
    // Constraint
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    
    // 변수
    var picker: UIPickerView!
    var toolbar: UIToolbar!
    
    @objc func selectReason() {
        let row = picker.selectedRow(inComponent: 0)
        let reason = reasonList[row]
        reasonTextField.text = reason
        
        reasonTextField.endEditing(true)
    }
    
    let reasonList: [String] = [
        "학회/동아리 모임",
        "프로젝트/팀플 회의",
        "중간/기말 시험 장소",
        "중간/기말고사 스터디"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        peopleTextView.makeRounded(cornerRadius: 10)
        requestBtn.makeRounded(cornerRadius: 10)
        
        setText()
        setNavigationBar()
        setPicker()
        setToolbar()
        
        initGestureRecognizer()
    }
    
    func setPicker() {
        picker = UIPickerView()
        picker.delegate = self
        picker.dataSource = self
        reasonTextField.inputView = picker
    }
    
    func setToolbar() {
        toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 40))
        
        let done = UIBarButtonItem(title: "확인", style: .done, target: self, action: #selector(selectReason))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        
        toolbar.setItems([space, done], animated: true)
        
        reasonTextField.inputAccessoryView = toolbar
    }
    
    override func viewWillAppear(_ animated: Bool) {
        registerForKeyboardNotifications()
    }

    override func viewWillDisappear(_ animated: Bool) {
        unregisterForKeyboardNotifications()
    }
    
    // Activity Indicator 를 띄운다.
    func setActivityIndicator() {
        self.view.endEditing(true)
        
        let size = CGSize(width: 30, height: 30)
        
        startAnimating(size, message: "서버에 요청 중...", type: .ballSpinFadeLoader, fadeInAnimation: nil)
    }
    // Activity Indicator 를 제거한다.
    func removeActivityIndicator() {
        self.stopAnimating(nil)
    }
    
    func setText() {
        guard let buildingName = buildingName else { return }
        guard let lectureCode = lectureCode else { return }
        guard let startTime = startTime else { return }
        guard let endTime = endTime else { return }
        guard let date = date else { return }
        
        location.text = "\(buildingName) \(lectureCode)"
        rentalDate.text = "\(date) \(startTime):00 ~ \(endTime):59"
    }
    
    func setNavigationBar() {
        setBackBtn(color: UIColor(red: 112/255, green: 112/255, blue: 112/255, alpha: 1.0))
        guard let buildingName = buildingName else { return }
        guard let lectureCode = lectureCode else { return }
        
        self.navigationItem.title = "\(buildingName) \(lectureCode)"
    }
    
    func requestRental() {
        guard let startTime = startTime else { return }
        guard let endTime = endTime else { return }
        guard let reason = reasonTextField.text else { return }
        guard let peopleList = peopleTextView.text else { return }
        guard let phoneNumber = phoneTextField.text else { return }
        
        setActivityIndicator()

        RentalService.shared.requestRental(startTime: startTime, endTime: endTime, reason: reason, peopleList: peopleList, phoneNumber: phoneNumber) {
            [weak self]
            (data) in
            
            guard let `self` = self else { return }
            
            switch data {
                
            case .success(let message):
                let alert = UIAlertController(title: "대여 성공", message: message as? String, preferredStyle: .alert)
                
                let defaultAction = UIAlertAction(title: "확인", style: .default) {
                    (action) in
                    
                    self.performSegue(withIdentifier: "unwindAction", sender: self)
                }
                alert.addAction(defaultAction)
                
                self.present(alert, animated: false, completion: nil)
                
            case .requestErr(let message):
                self.simpleAlert(title: "대여 실패", message: message as! String)
            case .pathErr:
                print("pathErr")
            case .serverErr:
                print("serverErr")
            case .networkFail:
                self.simpleAlert(title: "연결 실패", message: "네트워크 상태를 확인해주세요.")
            }
            
            self.removeActivityIndicator()
        }
    }
    
    @IBAction func requestBtnAction(_ sender: Any) {
        let alert = UIAlertController(title: "대여 신청", message: "신청하시겠습니까?", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "확인", style: .default) {
            [weak self]
            (action) in
            
            guard let `self` = self else { return }
            
            self.requestRental()
        }
        
        let cancle = UIAlertAction(title: "취소", style: .destructive, handler: nil)
        
        alert.addAction(cancle)
        alert.addAction(okAction)
        
        self.present(alert, animated: false, completion: nil)
        
    }
}

extension RentalRequestVC: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return reasonList[row]
    }
}

extension RentalRequestVC: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return reasonList.count
    }
}

// GestureRecognizer Delegate
extension RentalRequestVC: UIGestureRecognizerDelegate {

    func initGestureRecognizer() {
        let textFieldTap = UITapGestureRecognizer(target: self, action: #selector(handleTapTextField(_:)))
        textFieldTap.delegate = self
        view.addGestureRecognizer(textFieldTap)
    }


    @objc func handleTapTextField(_ sender: UITapGestureRecognizer) {
        self.peopleTextView.resignFirstResponder()
        self.phoneTextField.resignFirstResponder()
    }


    func gestureRecognizer(_ gestrueRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if (touch.view?.isDescendant(of: peopleTextView))! || (touch.view?.isDescendant(of: phoneTextField))! {

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

            self.locationTitle.alpha = 0
            self.location.alpha = 0
            self.rentalDateTitle.alpha = 0
            self.rentalDate.alpha = 0
            self.topConstraint.constant = -keyboardHeight/2
        })
        self.view.layoutIfNeeded()
    }

    @objc func keyboardWillHide(_ notification: NSNotification) {
        guard let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else {return}
        guard let curve = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt else {return}
        UIView.animate(withDuration: duration, delay: 0.0, options: .init(rawValue: curve), animations: {

            self.locationTitle.alpha = 1
            self.location.alpha = 1
            self.rentalDateTitle.alpha = 1
            self.rentalDate.alpha = 1
            self.topConstraint.constant = 8
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
