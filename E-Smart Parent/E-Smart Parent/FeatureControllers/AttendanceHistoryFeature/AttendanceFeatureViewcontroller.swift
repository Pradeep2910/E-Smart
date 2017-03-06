//
//  AttendanceFeatureViewcontroller.swift
//  E-Smart Parent
//
//  Created by Pradeep A C on 26/01/17.
//  Copyright © 2017 Pradeep A C. All rights reserved.
//

import Foundation
import UIKit

class AttendanceFeatureViewcontroller: UIViewController {
    
    var datesArray :NSArray = []
     let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
    var tableItems : NSMutableArray = []
    let metaData = MetaDataManager()
    @IBOutlet weak var first: UIView!
    @IBOutlet weak var second: UIView!
    @IBOutlet weak var third: UIView!
    @IBOutlet weak var fourth: UIView!

    
     @IBOutlet weak var historyTableview: UITableView!
    
    var totalAnswerLabel = "- 0 Days"
   var absentAnswerLabel = "- 0 Days"
    var halfDayAnswerLabel = "- 0 Days"
   var presentAnswerLabel = "- 0 Days"
    var totalWorkingDays = "- 0 Days"
    
    override func viewDidLoad() {
        tableItems = metaData.getAttendanceHistoryItems() as! NSMutableArray
        self.navigationItem.backBarButtonItem?.title = ""
        self.navigationItem.title = "Attendance"

        historyTableview.layer.borderColor = UIColor.black.cgColor
        historyTableview.layer.borderWidth = 0.4

        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "attendanceContainerSegue") {
            let attendanceHistoryVC = segue.destination as! AttendanceHistoryViewController
            attendanceHistoryVC.dateDictArray = datesArray
            attendanceHistoryVC.monthDelegate = self
        }

    }

}

extension AttendanceFeatureViewcontroller: monthChangeDelegate{
    func monthChanged(_statusDictArray: [Dictionary<String, Any>]) {
        self.clearLabels(_statusDictArray: _statusDictArray)
        for _statusDict in _statusDictArray {
        switch _statusDict["status"] as! Int {
        case 0:
            absentAnswerLabel = "- ".appending(String(_statusDict["count"] as! Int)).appending(" days")
        break
        case 1:
            halfDayAnswerLabel = "- ".appending(String(_statusDict["count"] as! Int)).appending(" days")
            break
            
        case 2:
             presentAnswerLabel = "- ".appending(String(_statusDict["count"] as! Int)).appending(" days")
            break
            
        default:
            break
        }
        }
         let presentCount = presentAnswerLabel.components(separatedBy: " ")[1]
        let absentCount = absentAnswerLabel.components(separatedBy: " ")[1]
        let halfDayCount = halfDayAnswerLabel.components(separatedBy: " ")[1]
            totalAnswerLabel = "- ".appending(String(Float(presentCount)! + Float(absentCount)! + Float(halfDayCount)!/2)).appending(" days")
        if Float(totalAnswerLabel.components(separatedBy: " ")[1])! > 0.0 {
            totalWorkingDays = "20 Days"
        }
        historyTableview.reloadData()
    }
    
    func clearLabels(_statusDictArray :  [Dictionary<String, Any>]) {
        presentAnswerLabel = "- 0 days"
        halfDayAnswerLabel = "- 0 days"
        absentAnswerLabel = "- 0 days"
         totalAnswerLabel = "- 0 days"
        totalWorkingDays = "- 0 days"
        historyTableview.reloadData()
    }
    
    func monthNotPresent() {
        presentAnswerLabel = "- 0 days"
        halfDayAnswerLabel = "- 0 days"
        absentAnswerLabel = "- 0 days"
         totalAnswerLabel = "- 0 days"
        totalWorkingDays = "- 0 days"
        historyTableview.reloadData()
    }
}


extension AttendanceFeatureViewcontroller : UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "attendanceFeature") as! AttendanceFeatureTableviewCell
        let dict = tableItems[indexPath.row] as! NSDictionary
        let colorDict = dict["RGBValue"] as! NSDictionary
        cell.colorView.backgroundColor =  UIColor(red: CGFloat(colorDict["R"] as! Float/255), green:  CGFloat(colorDict["G"] as! Float/255), blue:  CGFloat(colorDict["B"]  as! Float/255), alpha: 1.0)
        cell.inputLabel.text = dict["labelName"] as? String
        switch indexPath.row {
        case 0:
            cell.outputLabel.text = totalWorkingDays
        case 1:
            cell.outputLabel.text = totalAnswerLabel
        case 2:
            cell.outputLabel.text = presentAnswerLabel
        case 3:
            cell.outputLabel.text = halfDayAnswerLabel
        case 4:
            cell.outputLabel.text = absentAnswerLabel
        default:
            cell.outputLabel.text = ""
        }
        return cell
    }
}
