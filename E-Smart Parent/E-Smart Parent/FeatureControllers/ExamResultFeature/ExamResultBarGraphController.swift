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
        
        var dataEntries: [BarChartDataEntry] = []
        let formato:BarChartFormatter = BarChartFormatter()
        formato.subjects = subjectsArray
        let xaxis:XAxis = XAxis()
              for i in 0..<dataPoints.count {
            
            let dataEntry = BarChartDataEntry(x: Double(i), y: values[i], data: subjectsArray[i] as AnyObject?)
            dataEntries.append(dataEntry)
                 formato.stringForValue(Double(i), axis: xaxis)
        }

        xaxis.valueFormatter = formato
        barChartView.xAxis.valueFormatter = xaxis.valueFormatter

        let chartDataSet = BarChartDataSet(values: dataEntries, label: "Units Sold")
        let chartData = BarChartData(dataSets: [chartDataSet])
        barChartView.data = chartData
        
        barChartView.descriptionText = ""
        
       // chartDataSet.colors = [UIColor(red: 230/255, green: 126/255, blue: 34/255, alpha: 1)]
                chartDataSet.colors = ChartColorTemplates.joyful()
        barChartView.leftAxis.calculate(min: 0, max: 100)
        barChartView.xAxis.labelPosition = .bottom
        barChartView.xAxis.labelCount = subjectsArray.count
        barChartView.xAxis.drawLabelsEnabled = true
        barChartView.xAxis.drawLimitLinesBehindDataEnabled = true
       barChartView.xAxis.avoidFirstLastClippingEnabled = true
        barChartView.leftAxis.resetCustomAxisMax()
        
        barChartView.leftAxis.axisMinimum = 0.0
        barChartView.leftAxis.axisMaximum = 100.0
        barChartView.leftAxis.labelCount = 5
        
        barChartView.rightAxis.axisMinimum = 0.0
        barChartView.rightAxis.axisMaximum = 100.0
        barChartView.rightAxis.labelCount = 5
        barChartView.animate(xAxisDuration: 1.0, yAxisDuration: 1.0, easingOption: .linear)
    }
    
    func chartValueSelected(chartView: ChartViewBase, entry: ChartDataEntry, dataSetIndex: Int, highlight: Highlight) {
        
    }

}
