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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "attendanceContainerSegue") {
            let attendanceHistoryVC = segue.destination as! AttendanceHistoryViewController
            attendanceHistoryVC.dateDictArray = datesArray
        }

    }

}
