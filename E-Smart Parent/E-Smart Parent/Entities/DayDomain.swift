//
//  DayDomain.swift
//  E-Smart Parent
//
//  Created by Pradeep A C on 11/02/17.
//  Copyright © 2017 Pradeep A C. All rights reserved.
//

import Foundation

class DayDomain : NSObject{
    var dayTitle : String
    var periodsArray : [PeriodDomain]
    
    init(dayTitle : String, periodsArray : [PeriodDomain]) {
        self.dayTitle = dayTitle
        self.periodsArray = periodsArray
    }
    
    func getShortForm() -> String {
        switch dayTitle {
        case "Monday":
            return "Mon"
        case "Tuesday":
            return "Tue"
        case "Wednesday", "Wednessday":
            return "Wed"
        case "Thursday":
            return "Thu"
        case "Friday":
            return "Fri"
        default:
            return "Day"
        }
    }
    
}
