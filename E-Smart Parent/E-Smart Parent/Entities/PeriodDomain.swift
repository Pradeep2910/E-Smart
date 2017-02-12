//
//  PeriodDomain.swift
//  E-Smart Parent
//
//  Created by Pradeep A C on 11/02/17.
//  Copyright © 2017 Pradeep A C. All rights reserved.
//

import Foundation

class PeriodDomain: NSObject {
    var title : String
     var periodIndex : Int
     var startTime : String
     var endTime : String
    
    var subject : String?
    
    init(title : String, periodIndex : Int, startTime : String, endTime : String) {
        self.title = title
        self.periodIndex = periodIndex
        self.startTime = startTime
        self.endTime = endTime
    }
    
    func copy(with zone: NSZone? = nil) -> PeriodDomain
    {
        let copy = PeriodDomain(title: title, periodIndex: periodIndex, startTime: startTime, endTime: endTime)
        return copy
    }
}
