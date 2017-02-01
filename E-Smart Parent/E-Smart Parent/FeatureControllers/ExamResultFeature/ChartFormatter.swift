//
//  ChartFormatter.swift
//  E-Smart Parent
//
//  Created by Pradeep A C on 28/01/17.
//  Copyright © 2017 Pradeep A C. All rights reserved.
//

import Foundation
import Foundation
import Charts

@objc(BarChartFormatter)
public class BarChartFormatter: NSObject, IAxisValueFormatter{
    
    var subjects: [String]!
    
    
    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        
        return subjects[Int(value)]
}
}
