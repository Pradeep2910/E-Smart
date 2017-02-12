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
    
    
    @IBOutlet weak var first: UIView!
    @IBOutlet weak var second: UIView!
    @IBOutlet weak var third: UIView!
    @IBOutlet weak var fourth: UIView!

    
    
    
    @IBOutlet weak var totalAnswerLabel: UILabel!
    @IBOutlet weak var absentAnswerLabel: UILabel!
    @IBOutlet weak var halfDayAnswerLabel: UILabel!
    @IBOutlet weak var presentAnswerLabel: UILabel!
    
    
    override func viewDidLoad() {
        first.layer.borderColor = UIColor.black.cgColor
        first.layer.borderWidth = 0.4
        second.layer.borderColor = UIColor.black.cgColor
        second.layer.borderWidth = 0.4
        third.layer.borderColor = UIColor.black.cgColor
        third.layer.borderWidth = 0.4
        fourth.layer.borderColor = UIColor.black.cgColor
        fourth.layer.borderWidth = 0.4
        
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
        if let presentCount = presentAnswerLabel.text?.components(separatedBy: " ")[1],let absentCount = absentAnswerLabel.text?.components(separatedBy: " ")[1],
            let halfDayCount = halfDayAnswerLabel.text?.components(separatedBy: " ")[1]{
            totalAnswerLabel.text = "- ".appending(String(Int(presentCount)! + Int(absentCount)! + Int(halfDayCount)!)).appending(" days")
        }
        
    }
    
    func clearLabels(_statusDictArray :  [Dictionary<String, Any>]) {
        presentAnswerLabel.text = "- 0 days"
        halfDayAnswerLabel.text = "- 0 days"
        absentAnswerLabel.text = "- 0 days"
         totalAnswerLabel.text = "- 0 days"
    }
    
    func monthNotPresent() {
        presentAnswerLabel.text = "- 0 days"
        halfDayAnswerLabel.text = "- 0 days"
        absentAnswerLabel.text = "- 0 days"
         totalAnswerLabel.text = "- 0 days"
    }
}
