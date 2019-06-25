//
//  DateVC.swift
//  Forest
//
//  Created by wookeon on 24/06/2019.
//  Copyright © 2019 wookeon. All rights reserved.
//

import UIKit
import ScrollableDatepicker
import NVActivityIndicatorView

class DateVC: UIViewController, NVActivityIndicatorViewable {

    @IBOutlet weak var timetableView: UITableView!
    @IBOutlet weak var requestBtn: UIButton!
    @IBOutlet weak var rentalBtn: UIButton!
    
    @IBOutlet weak var datepicker: ScrollableDatepicker! {
        didSet {
           var dates = [Date]()
            for day in 0...14 {
                dates.append(Date(timeIntervalSinceNow: Double(day * 86400)))
            }
            
            
            datepicker.dates = dates
            datepicker.selectedDate = Date()
            datepicker.delegate = self
            
            var configuration = Configuration()
            
            configuration.weekendDayStyle.dateTextColor = UIColor(red: 242/255, green: 93/255, blue: 28/255, alpha: 1.0)
            configuration.weekendDayStyle.dateTextColor = UIColor(red: 242.0/255.0, green: 93.0/255.0, blue: 28.0/255.0, alpha: 1.0)
            configuration.weekendDayStyle.dateTextFont = UIFont.boldSystemFont(ofSize: 20)
            configuration.weekendDayStyle.weekDayTextColor = UIColor(red: 242.0/255.0, green: 93.0/255.0, blue: 28.0/255.0, alpha: 1.0)
            
            configuration.selectedDayStyle.backgroundColor = UIColor(white: 0.9, alpha: 1)
            configuration.daySizeCalculation = .numberOfVisibleItems(5)
            datepicker.configuration = configuration
        }
    }
    
    var buildingName: String?
    var lectureCode: String?
    var date: String?
    var rentalStateList: [RentalStateList] = []
    var timetableList: [Timetable] = []
    var timeArray: [Int] = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationBar()
        requestBtn.makeRounded(cornerRadius: 10)
        rentalBtn.makeRounded(cornerRadius: 10)
        
        setTimetable()
        timetableView.delegate = self
        timetableView.dataSource = self
        
        DispatchQueue.main.async {
            self.showSelectedDate()
            self.datepicker.scrollToSelectedDate(animated: false)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getRentalStateList()
    }
    
    fileprivate func showSelectedDate() {
        guard let selectedDate = datepicker.selectedDate else {
            return
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        date = formatter.string(from: selectedDate)
        rentalBtn.isEnabled = false
        rentalBtn.backgroundColor = UIColor(red: 224/255, green: 224/255, blue: 224/255, alpha: 1.0)
    }
    
    func setNavigationBar() {
        setBackBtn(color: UIColor(red: 112/255, green: 112/255, blue: 112/255, alpha: 1.0))
        guard let buildingName = buildingName else { return }
        guard let lectureCode = lectureCode else { return }
        
        self.navigationItem.title = "\(buildingName) \(lectureCode)"
    }
    
    func getCurrentDate() {
        datepicker.selectedDate = Date()
        datepicker.scrollToSelectedDate(animated: true)
        showSelectedDate()
    }
    
    func getRentalStateList() {
        
        guard let lectureCode = lectureCode else { return }
        guard let date = date else { return }
        
        setActivityIndicator()

        RentalService.shared.getRentalStateList(lectureCode: lectureCode, date: date) {
            [weak self]
            (data) in
            
            guard let `self` = self else { return }
            
            switch data {
                
            case .success(let result):
                let _result = result as! [RentalStateList]
                self.rentalStateList = _result
                
                print(self.rentalStateList)
                
                self.setTimetable()
                self.rentalBtn.isEnabled = true
                self.rentalBtn.backgroundColor = UIColor(red: 3/255, green: 93/255, blue: 36/255, alpha: 1.0)
                self.timetableView.reloadData()
                
            case .requestErr(let message):
                print(message)
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
    
    @IBAction func requestBtnAction(_ sender: UIButton) {
        getRentalStateList()
    }
    
    @IBAction func rentalBtnAction(_ sender: UIButton) {
        guard let buildingName = buildingName else { return }
        guard let lectureCode = lectureCode else { return }
        guard let date = date else { return }
        
        let dvc = self.storyboard?.instantiateViewController(withIdentifier: "RentalRequestVC") as! RentalRequestVC
        
        dvc.buildingName = buildingName
        dvc.lectureCode = lectureCode
        dvc.date = date
        
        var min = Int.max
        var max = 0
        
        for i in 0..<timeArray.count {
            if timeArray[i] > 0 && timeArray[i] < min {
                min = timeArray[i]
            }
        }
        
        for i in 0..<timeArray.count {
            if timeArray[i] > 0 && timeArray[i] > max {
                max = timeArray[i]
            }
        }
        
        if min < 10 {
            dvc.startTime = "0\(min)"
        } else {
            dvc.startTime = "\(min)"
        }
        
        if max < 10 {
            dvc.endTime = "0\(max)"
        } else {
            dvc.endTime = "\(max)"
        }
        
        self.navigationController?.pushViewController(dvc, animated: true)
    }
}

extension DateVC: ScrollableDatepickerDelegate {
    
    func datepicker(_ datepicker: ScrollableDatepicker, didSelectDate date: Date) {
        showSelectedDate()
    }
}

extension DateVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}

extension DateVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return timetableList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = timetableView.dequeueReusableCell(withIdentifier: "TimetableCell") as! TimetableCell
        
        let timetable = timetableList[indexPath.row]
        
        cell.time.text = timetable._time
        cell.contents.text = timetable._contents
        cell.check.isSelected = timetable._check
        cell.check.isEnabled = timetable._possible
        cell.check.addTarget(self, action: #selector(btnSelected), for: .touchUpInside)
        cell.check.tag = indexPath.row
        
        return cell
    }
    
    @objc func btnSelected(sender: UIButton) {
        sender.isSelected = !sender.isSelected
        sender.setImage(UIImage(named: "checkGray"), for: .normal)
        sender.setImage(UIImage(named: "checkGreen"), for: .selected)
        
        if sender.isSelected {
            timeArray[sender.tag] = sender.tag+9
        } else {
            timeArray[sender.tag] = 0
        }
    }
}

extension DateVC {
    func setTimetable() {
        let timetable0 = Timetable(time: "09:00", contents: "", check: false, possible: true)
        let timetable1 = Timetable(time: "10:00", contents: "", check: false, possible: true)
        let timetable2 = Timetable(time: "11:00", contents: "", check: false, possible: true)
        let timetable3 = Timetable(time: "12:00", contents: "", check: false, possible: true)
        let timetable4 = Timetable(time: "13:00", contents: "", check: false, possible: true)
        let timetable5 = Timetable(time: "14:00", contents: "", check: false, possible: true)
        let timetable6 = Timetable(time: "15:00", contents: "", check: false, possible: true)
        let timetable7 = Timetable(time: "16:00", contents: "", check: false, possible: true)
        let timetable8 = Timetable(time: "17:00", contents: "", check: false, possible: true)
        let timetable9 = Timetable(time: "18:00", contents: "", check: false, possible: true)
        let timetable10 = Timetable(time: "19:00", contents: "", check: false, possible: true)
        let timetable11 = Timetable(time: "20:00", contents: "", check: false, possible: true)
        let timetable12 = Timetable(time: "21:00", contents: "", check: false, possible: true)
        
        timetableList = [timetable0, timetable1, timetable2, timetable3, timetable4, timetable5, timetable6, timetable7, timetable8, timetable9, timetable10, timetable11, timetable12]
        
        for i in 0..<rentalStateList.count {
            let startTime = rentalStateList[i].rentalDate.startTime
            let endTime = rentalStateList[i].rentalDate.endTime
            let rentalState = rentalStateList[i].rentalState
            
            for i in startTime-9..<endTime-9 {
                timetableList[i]._contents = "상태 : \(rentalState)   신청불가"
                timetableList[i]._possible = false
            }
        }
    }
}
