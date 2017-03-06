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

enum CurrentSelectedModule{
    case Academic
    case Performance
}

class ExamResltBarGraphController: UIViewController {
    var examResults = [ExamResultDetails]()
    var subjectsArray = [String]()
    var marksArray = [Double]()
    
    @IBOutlet weak var classWiseBarChartView: BarChartView!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var outOfScoreLabel: UILabel!
    @IBOutlet weak var gradeLabel: UILabel!
    @IBOutlet weak var scoreDetailsTableview: UITableView!
    @IBOutlet weak var subjectWiseBarChartView: BarChartView!
    @IBOutlet weak var academicView: UIView!
    @IBOutlet weak var performanceView: UIView!
    @IBOutlet weak var academicBottomBarView: UIView!
    @IBOutlet weak var performanceBottomBarView: UIView!
    @IBOutlet var academicViewLeadingConstraint: NSLayoutConstraint!
    @IBOutlet var academicViewTrailingConstraint: NSLayoutConstraint!
    var performanceViewLeadingConstraint: NSLayoutConstraint!
    var performanceViewTrailingConstraint: NSLayoutConstraint!
    var currentModule : CurrentSelectedModule!
    
    var classWiseMarksArray = [Double]()
    
    var finalColors : NSMutableArray = []
    var classWiseFinalColors : NSMutableArray = []
    
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
    let classWiseGradeColors = [NSUIColor(cgColor: UIColor(hexString: "#6EF0B1").cgColor),
                       NSUIColor(cgColor: UIColor(hexString: "#A6E4FA").cgColor),
                       ]
    
    
    let classWiseGradeLabels = [Application.application.loginDetails.studentName, "Class Average"]
    
    
    override func viewDidLoad() {
        self.navigationItem.backBarButtonItem?.title = ""
        self.navigationItem.title = "Evaluation"

        subjectWiseBarChartView.noDataText = "No results Available."
        var total = 0.0
        for result in examResults {
            subjectsArray.append(result.subjectID)
            marksArray.append(result.score as Double)
            total = total + Double(result.score)
        }
        
        for index in 0..<marksArray.count*2 {
            if index % 2 == 0{
                classWiseMarksArray.append(marksArray[index/2])
            }
            else{
                classWiseMarksArray.append(40.0)
            }
        }
        scoreLabel.text = String(total)
        outOfScoreLabel.text = outOfScoreLabel.text?.appending(" ").appending(String(examResults.count * 100))
        gradeLabel.text = self.checkGrade(_total : total)
        setSubjectWiseChart(dataPoints: subjectsArray, values: marksArray )
        createClassWiseChart(dataPoints: subjectsArray, values: classWiseMarksArray)
        performanceViewLeadingConstraint = NSLayoutConstraint(item: performanceView, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1.0, constant: 0)
        performanceViewTrailingConstraint = NSLayoutConstraint(item: performanceView, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1.0, constant: 0)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.customizeTheTabsView()
        self.setDefaultTabSelection()
        self.addGestureForTogglingViews()
        
    }
    func checkGrade(_total : Double) -> String{
        switch _total {
        case _ where _total > 90.0:
            return "A1"
        case _ where _total > 80.0 && _total <= 90.0:
            return "A2"
        case _ where _total > 70.0 && _total <= 80.0:
            return "B1"
        case _ where _total > 60.0 && _total <= 70.0:
            return "B2"
        case _ where _total > 50.0 && _total <= 60.0:
            return "C1"
        case _ where _total > 40.0 && _total <= 50.0:
            return "C2"
        case _ where _total > 30.0 && _total <= 40.0:
            return "D"
        case _ where _total > 20.0 && _total <= 30.0:
            return "E1"
        case _ where _total >= 0.0 && _total <= 20.0:
            return "E2"
        default:
            return ""
        }
    }
    
    @IBAction func academicControlTapped(_ sender: Any) {
        currentModule = .Academic
        academicBottomBarView.isHidden = false
        performanceBottomBarView.isHidden = true
        self.showAcademicViewWithAnimation()
        
    }
    
    @IBAction func performanceControlTapped(_ sender: Any) {
        
        currentModule = .Performance
        academicBottomBarView.isHidden = true
        performanceBottomBarView.isHidden = false
        self.showPerformanceViewWithAnimation()
    }
    func showAcademicViewWithAnimation(){
        academicViewLeadingConstraint.isActive = true
        academicViewTrailingConstraint.isActive = true
        performanceViewTrailingConstraint.isActive = false
        performanceViewTrailingConstraint.isActive = false
        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .transitionFlipFromLeft, animations: {
            self.academicView.layoutIfNeeded()
            self.performanceView.layoutIfNeeded()
            
        }, completion: nil)
    }

    func showPerformanceViewWithAnimation(){
        academicViewLeadingConstraint.isActive = false
        academicViewTrailingConstraint.isActive = false
        performanceViewTrailingConstraint.isActive = true
        performanceViewTrailingConstraint.isActive = true
        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .transitionFlipFromRight, animations: {
            self.academicView.layoutIfNeeded()
            self.performanceView.layoutIfNeeded()
            
        }, completion: nil)
    }
    
    func addGestureForTogglingViews() {
        let switchToPerformanceFromAcademicGesture = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeToPerformanceView))
        switchToPerformanceFromAcademicGesture.direction = .left
        academicView.addGestureRecognizer(switchToPerformanceFromAcademicGesture)
        
        let switchToAcademicFromPerformanceGesture = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeToAcademicView))
        switchToAcademicFromPerformanceGesture.direction = .right
        performanceView.addGestureRecognizer(switchToAcademicFromPerformanceGesture)
    }
    
    /// to swipe and go to sign up view
    func swipeToPerformanceView() {
        currentModule = .Performance
        academicBottomBarView.isHidden = true
        performanceBottomBarView.isHidden = false
        self.showPerformanceViewWithAnimation()

    }
    
    /// to swipe and go to login view
    func swipeToAcademicView() {
        currentModule = .Academic
        academicBottomBarView.isHidden = false
        performanceBottomBarView.isHidden = true
        self.showAcademicViewWithAnimation()
    }
    
    
    /// to customize the appearance of the Sign up
    /// and Login tabs
    func customizeTheTabsView() {
        let normalSegmentTitleColor: UIColor = UIColor(red: 85.0, green: 85.0, blue: 85.0, alpha: 0.4)
        let selectedSegmentTitleColor: UIColor = UIColor(red: 255.0, green: 255.0, blue: 255.0, alpha: 1.0)
        let normalSegmentTextAttributes =
            [NSForegroundColorAttributeName:normalSegmentTitleColor,
             NSFontAttributeName:UIFont(name: "Arial", size: 16.0)!,
             NSKernAttributeName:0.08] as [String : Any]
        let selectedSegmentTextAttributes =
            [NSForegroundColorAttributeName:selectedSegmentTitleColor,
             NSFontAttributeName:UIFont(name: "Arial", size: 16.0)!,
             NSKernAttributeName:0.08] as [String : Any]
       
    }
    
    /// to select the Login by default
    func setDefaultTabSelection() {
        if (currentModule != nil && currentModule == .Performance) {
            academicBottomBarView.isHidden = true
            performanceBottomBarView.isHidden = false
            academicViewLeadingConstraint.isActive = false
            academicViewTrailingConstraint.isActive = false
            performanceViewLeadingConstraint.isActive = true
            performanceViewTrailingConstraint.isActive = true
            self.performanceView.layoutIfNeeded()
            self.academicView.layoutIfNeeded()
        } else {
            currentModule = .Academic
            academicBottomBarView.isHidden = false
            performanceBottomBarView.isHidden = true
        }
    }

    
    
    func createClassWiseChart(dataPoints: [String], values: [Double]) {
        classWiseBarChartView.noDataText = "No results Available."
        
        classWiseBarChartView.drawBarShadowEnabled = false
        classWiseBarChartView.drawValueAboveBarEnabled = true
        classWiseBarChartView.pinchZoomEnabled = false
        classWiseBarChartView.drawGridBackgroundEnabled = false
        
        var dataEntries: [BarChartDataEntry] = []
        let formato:BarChartFormatter = BarChartFormatter()
        formato.subjects = subjectsArray
        let xaxis:XAxis = XAxis()
        for i in 0..<values.count {
            if i % 2 == 0 {
                classWiseFinalColors.add(classWiseGradeColors[0])
            }
            else{
                classWiseFinalColors.add(classWiseGradeColors[1])
            }
            
            let dataEntry = BarChartDataEntry(x: Double(i), y: values[i], data: nil as AnyObject?)
            dataEntries.append(dataEntry)
//            formato.stringForValue(Double(i), axis: xaxis)
        }
        
        xaxis.valueFormatter = formato
        classWiseBarChartView.xAxis.valueFormatter = xaxis.valueFormatter
        //
        //        let chartDataSet = BarChartDataSet(values: dataEntries, label: "Units Sold")
        //
        //        let chartData = BarChartData(dataSets: [chartDataSet])
        //        classWiseBarChartView.data = chartData
        
        classWiseBarChartView.descriptionText = ""
        classWiseBarChartView.leftAxis.calculate(min: 0, max: 100)
        classWiseBarChartView.xAxis.labelPosition = .bottom
        classWiseBarChartView.xAxis.labelCount = subjectsArray.count
        classWiseBarChartView.xAxis.drawLabelsEnabled = true
        classWiseBarChartView.xAxis.drawGridLinesEnabled = false
        classWiseBarChartView.xAxis.granularity = 1.0
        classWiseBarChartView.xAxis.centerAxisLabelsEnabled = true
        classWiseBarChartView.xAxis.setLabelCount(subjectsArray.count+1, force: true)
        
        classWiseBarChartView.xAxis.drawLimitLinesBehindDataEnabled = true
        classWiseBarChartView.xAxis.avoidFirstLastClippingEnabled = true
        classWiseBarChartView.leftAxis.resetCustomAxisMax()
        
        classWiseBarChartView.leftAxis.axisMinimum = 0.0
        classWiseBarChartView.leftAxis.axisMaximum = 100.0
        classWiseBarChartView.leftAxis.setLabelCount(5, force: false)
        classWiseBarChartView.leftAxis.spaceTop = 15.0
        
        classWiseBarChartView.rightAxis.axisMinimum = 0.0
        classWiseBarChartView.rightAxis.axisMaximum = 100.0
        classWiseBarChartView.rightAxis.setLabelCount(5, force: false)
        classWiseBarChartView.rightAxis.spaceTop = 15.0
        classWiseBarChartView.animate(xAxisDuration: 1.0, yAxisDuration: 1.0, easingOption: .linear)
        
        
        let l : Legend = classWiseBarChartView.legend
        var list : Array<LegendEntry> = []
        for i in 0..<classWiseGradeLabels.count {
            let le : LegendEntry = LegendEntry()
            le.label = classWiseGradeLabels[i]
            le.form = Legend.Form.square
            le.formColor = classWiseGradeColors[i]
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
        if classWiseBarChartView.data != nil && (classWiseBarChartView.data?.dataSetCount)! > 0 {
            set = classWiseBarChartView.data?.getDataSetByIndex(0) as! BarChartDataSet
            set.values = dataEntries
            set.colors = (classWiseFinalColors as? [NSUIColor])!
            classWiseBarChartView.data?.notifyDataChanged()
            classWiseBarChartView.notifyDataSetChanged()
        }
        else{
            set = BarChartDataSet(values: dataEntries, label: "Grades")
            set.colors = (classWiseFinalColors as? [NSUIColor])!
            let chartData = BarChartData(dataSets: [set])
            chartData.barWidth = 0.9
            classWiseBarChartView.data = chartData
        }
        
        
    }
    
    
    
    
    
    func setSubjectWiseChart(dataPoints: [String], values: [Double]) {
        subjectWiseBarChartView.noDataText = "No results Available."
        
        subjectWiseBarChartView.drawBarShadowEnabled = false
        subjectWiseBarChartView.drawValueAboveBarEnabled = true
        subjectWiseBarChartView.pinchZoomEnabled = false
        subjectWiseBarChartView.drawGridBackgroundEnabled = false
        
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
        subjectWiseBarChartView.xAxis.valueFormatter = xaxis.valueFormatter
//        
//        let chartDataSet = BarChartDataSet(values: dataEntries, label: "Units Sold")
//        
//        let chartData = BarChartData(dataSets: [chartDataSet])
//        subjectWiseBarChartView.data = chartData
        
        subjectWiseBarChartView.descriptionText = ""
        subjectWiseBarChartView.leftAxis.calculate(min: 0, max: 100)
        subjectWiseBarChartView.xAxis.labelPosition = .bottom
        subjectWiseBarChartView.xAxis.labelCount = subjectsArray.count
        subjectWiseBarChartView.xAxis.drawLabelsEnabled = true
        subjectWiseBarChartView.xAxis.drawGridLinesEnabled = false
        subjectWiseBarChartView.xAxis.granularity = 1.0
        subjectWiseBarChartView.xAxis.setLabelCount(7, force: false)
        
        subjectWiseBarChartView.xAxis.drawLimitLinesBehindDataEnabled = true
        subjectWiseBarChartView.xAxis.avoidFirstLastClippingEnabled = true
        subjectWiseBarChartView.leftAxis.resetCustomAxisMax()
        
        subjectWiseBarChartView.leftAxis.axisMinimum = 0.0
        subjectWiseBarChartView.leftAxis.axisMaximum = 100.0
        subjectWiseBarChartView.leftAxis.setLabelCount(5, force: false)
        subjectWiseBarChartView.leftAxis.spaceTop = 15.0
        
        subjectWiseBarChartView.rightAxis.axisMinimum = 0.0
        subjectWiseBarChartView.rightAxis.axisMaximum = 100.0
        subjectWiseBarChartView.rightAxis.setLabelCount(5, force: false)
        subjectWiseBarChartView.rightAxis.spaceTop = 15.0
        subjectWiseBarChartView.animate(xAxisDuration: 1.0, yAxisDuration: 1.0, easingOption: .linear)
       
      
        let l : Legend = subjectWiseBarChartView.legend
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
        if subjectWiseBarChartView.data != nil && (subjectWiseBarChartView.data?.dataSetCount)! > 0 {
            set = subjectWiseBarChartView.data?.getDataSetByIndex(0) as! BarChartDataSet
            set.values = dataEntries
            set.colors = (finalColors as? [NSUIColor])!
            subjectWiseBarChartView.data?.notifyDataChanged()
            subjectWiseBarChartView.notifyDataSetChanged()
        }
        else{
            set = BarChartDataSet(values: dataEntries, label: "Grades")
            set.colors = (finalColors as? [NSUIColor])!
            let chartData = BarChartData(dataSets: [set])
            chartData.barWidth = 0.9
            subjectWiseBarChartView.data = chartData
        }

        
            }
    
    func chartValueSelected(chartView: ChartViewBase, entry: ChartDataEntry, dataSetIndex: Int, highlight: Highlight) {
        
    }


}



extension ExamResltBarGraphController : UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return examResults.count + 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: "scoreCell") as! ExamScoreTableviewCell
        cell.configureCell()
        if indexPath.row == 0 {
            cell.backgroundColor = UIColor.lightGray
            cell.subjectLabel.text = "SUBJECT"
            cell.scoreLabel.text = "SCORE"
            cell.gradeLabel.text = "GRADE"
        }
        else{
            cell.subjectLabel.text = examResults[indexPath.row - 1].subjectID
            cell.scoreLabel.text = String(examResults[indexPath.row - 1].score as Double)
            cell.gradeLabel.text = self.checkGrade(_total: examResults[indexPath.row - 1].score as Double)
        }
        
        return cell
    }
}
