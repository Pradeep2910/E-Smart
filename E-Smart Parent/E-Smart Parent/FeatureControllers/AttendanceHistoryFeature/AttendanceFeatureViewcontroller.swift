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
    
    @IBOutlet weak var totalAnswerLabel: UILabel!
    @IBOutlet weak var absentAnswerLabel: UILabel!
    @IBOutlet weak var halfDayAnswerLabel: UILabel!
    @IBOutlet weak var presentAnswerLabel: UILabel!
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
        
        for _statusDict in _statusDictArray {
        switch _statusDict["status"] as! Int {
        case 0:
            absentAnswerLabel.text = "- ".appending(String(_statusDict["count"] as! Int)).appending(" days")
        break
        case 1:
            presentAnswerLabel.text = "- ".appending(String(_statusDict["count"] as! Int)).appending(" days")
            break
            
        case 2:
            halfDayAnswerLabel.text = "- ".appending(String(_statusDict["count"] as! Int)).appending(" days")
            break
            
        default:
            break
        }
        }
    }
    
    func monthNotPresent() {
        presentAnswerLabel.text = "- 0 days"
        halfDayAnswerLabel.text = "- 0 days"
        absentAnswerLabel.text = "- 0 days"
    }
}
