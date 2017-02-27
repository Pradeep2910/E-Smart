//
//  ExamResultBarGraphController.swift
//  E-Smart Parent
//
//  Created by Pradeep A C on 22/01/17.
//  Copyright © 2017 Pradeep A C. All rights reserved.
//

import Foundation
import UIKit
import Charts

class ExamResltBarGraphController: UIViewController {
    var examResults = [ExamResultDetails]()
    var subjectsArray = [String]()
    var marksArray = [Double]()
    var finalColors : NSMutableArray = []
    let gradeColors = [NSUIColor(cgColor: UIColor(hexString: "#673AB7").cgColor),
                       NSUIColor(cgColor: UIColor(hexString: "#3F51B5").cgColor),
                       NSUIColor(cgColor: UIColor(hexString: "#2ecc71").cgColor),
                       NSUIColor(cgColor: UIColor(hexString: "#9E9E9E").cgColor),
                       NSUIColor(cgColor: UIColor(hexString: "#CDDC39").cgColor),
                       NSUIColor(cgColor: UIColor(hexString: "#FF9800").cgColor),
                       NSUIColor(cgColor: UIColor(hexString: "#FFC107").cgColor),
                       NSUIColor(cgColor: UIColor(hexString: "#FF5722").cgColor),
                       NSUIColor(cgColor: UIColor(hexString: "#795548").cgColor),
                       NSUIColor(cgColor: UIColor(hexString: "#795548").cgColor)]
    
    
    let gradeLabels = ["A1","A2","B1","B2","C1","C2","D","E1","E2"]
    @IBOutlet weak var barChartView: BarChartView!
    
    override func viewDidLoad() {
        barChartView.noDataText = "No results Available."
        
        for result in examResults {
            subjectsArray.append(result.subjectID)
            marksArray.append(result.score as Double)
        }
        setChart(dataPoints: subjectsArray, values: marksArray )

    }
    
    func setChart(dataPoints: [String], values: [Double]) {
        barChartView.noDataText = "No results Available."
        
        barChartView.drawBarShadowEnabled = false
        barChartView.drawValueAboveBarEnabled = true
        barChartView.pinchZoomEnabled = false
        barChartView.drawGridBackgroundEnabled = false
        
        var dataEntries: [BarChartDataEntry] = []
        let formato:BarChartFormatter = BarChartFormatter()
        formato.subjects = subjectsArray
        let xaxis:XAxis = XAxis()
        for i in 0..<dataPoints.count {
            let iVal = Int(values[i])
            let q = iVal/10
            finalColors.add(gradeColors[9-q])
            let dataEntry = BarChartDataEntry(x: Double(i), y: values[i], data: subjectsArray[i] as AnyObject?)
            dataEntries.append(dataEntry)
            formato.stringForValue(Double(i), axis: xaxis)
        }
        
        xaxis.valueFormatter = formato
        barChartView.xAxis.valueFormatter = xaxis.valueFormatter
//        
//        let chartDataSet = BarChartDataSet(values: dataEntries, label: "Units Sold")
//        
//        let chartData = BarChartData(dataSets: [chartDataSet])
//        barChartView.data = chartData
        
        barChartView.descriptionText = ""
        barChartView.leftAxis.calculate(min: 0, max: 100)
        barChartView.xAxis.labelPosition = .bottom
        barChartView.xAxis.labelCount = subjectsArray.count
        barChartView.xAxis.drawLabelsEnabled = true
        barChartView.xAxis.drawGridLinesEnabled = false
        barChartView.xAxis.granularity = 1.0
        barChartView.xAxis.setLabelCount(7, force: false)
        
        barChartView.xAxis.drawLimitLinesBehindDataEnabled = true
        barChartView.xAxis.avoidFirstLastClippingEnabled = true
        barChartView.leftAxis.resetCustomAxisMax()
        
        barChartView.leftAxis.axisMinimum = 0.0
        barChartView.leftAxis.axisMaximum = 100.0
        barChartView.leftAxis.setLabelCount(5, force: false)
        barChartView.leftAxis.spaceTop = 15.0
        
        barChartView.rightAxis.axisMinimum = 0.0
        barChartView.rightAxis.axisMaximum = 100.0
        barChartView.rightAxis.setLabelCount(5, force: false)
        barChartView.rightAxis.spaceTop = 15.0
        barChartView.animate(xAxisDuration: 1.0, yAxisDuration: 1.0, easingOption: .linear)
       
      
        let l : Legend = barChartView.legend
        var list : Array<LegendEntry> = []
        for i in 0..<9 {
            let le : LegendEntry = LegendEntry()
            le.label = gradeLabels[i]
            le.form = Legend.Form.square
            le.formColor = gradeColors[i]
            list.append(le)
        }
        l.setCustom(entries: list)
        l.verticalAlignment = Legend.VerticalAlignment.bottom
        l.horizontalAlignment = Legend.HorizontalAlignment.left
        l.orientation = Legend.Orientation.horizontal
        l.drawInside = false
        l.form = Legend.Form.square
        l.formSize = 9.0
        l.xEntrySpace = 4.0
        let set : BarChartDataSet
        if barChartView.data != nil && (barChartView.data?.dataSetCount)! > 0 {
            set = barChartView.data?.getDataSetByIndex(0) as! BarChartDataSet
            set.values = dataEntries
            set.colors = (finalColors as? [NSUIColor])!
            barChartView.data?.notifyDataChanged()
            barChartView.notifyDataSetChanged()
        }
        else{
            set = BarChartDataSet(values: dataEntries, label: "Grades")
            set.colors = (finalColors as? [NSUIColor])!
            let chartData = BarChartData(dataSets: [set])
            chartData.barWidth = 0.9
            barChartView.data = chartData
        }

        
            }
    
    func chartValueSelected(chartView: ChartViewBase, entry: ChartDataEntry, dataSetIndex: Int, highlight: Highlight) {
        
    }


}
