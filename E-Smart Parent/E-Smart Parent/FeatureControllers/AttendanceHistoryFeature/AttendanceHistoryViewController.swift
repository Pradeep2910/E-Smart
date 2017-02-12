//
//  AttendanceHistoryViewController.swift
//  SchoolAppClone
//
//  Created by Pradeep A C on 18/10/16.
//  Copyright © 2016 Pradeep A C. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

protocol monthChangeDelegate {
    func monthChanged(_statusDictArray : [Dictionary<String, Any>])
    func monthNotPresent()
}

import JTAppleCalendar
class AttendanceHistoryViewController: UIViewController {
    @IBOutlet weak var calendarView: JTAppleCalendarView!
    let formatter = DateFormatter()
    var dateDictArray :NSArray = []
    let red = UIColor.red
    var monthText = ""
    let white = UIColor.white
    let black = UIColor.black
    let gray = UIColor.gray
    let shade = UIColor(hexString: "0x4E4E4E")
    var testCalendar = Calendar.autoupdatingCurrent
    var monthDelegate : monthChangeDelegate? = nil
    var requiredColor : UIColor = UIColor.white
    var statusDictArray : [Dictionary<String, Any>] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        formatter.dateFormat = "yyyy MM dd"
        formatter.locale = Locale.current
        formatter.timeZone = NSTimeZone.local
        testCalendar.timeZone = NSTimeZone.local
        // Setting up your dataSource and delegate is manditory
        // ___________________________________________________________________
        calendarView.delegate = self
        calendarView.dataSource = self
        
        // ___________________________________________________________________
        // Registering your cells is manditory
        // ___________________________________________________________________
        calendarView.registerCellViewXib(file: "CellView")
        
        // ___________________________________________________________________
        // Registering header cells is optional
        calendarView.registerHeaderView(xibFileNames: ["CalendarHeader"])
        // ___________________________________________________________________
        
        calendarView.cellInset = CGPoint(x: 0, y: 0)
        
        calendarView.visibleDates { (visibleDates: DateSegmentInfo) in
            self.setupViewsOfCalendar(from: visibleDates)
        }
    }
    
    
    
    // Function to handle the calendar selection
    func handleCellSelection(view: JTAppleDayCellView?, cellState: CellState) {
        guard let myCustomCell = view as? CellView  else {return }
        if cellState.isSelected {
            myCustomCell.selectedView.layer.cornerRadius =  15
            myCustomCell.selectedView.isHidden = false
        } else {
            myCustomCell.selectedView.isHidden = true
        }
    }
    
    
    func checkingForDate(_date: Date!) -> Bool{
        
        guard let dateDictionaryArray = self.dateDictArray[0] as? [[String:AnyObject]] else {
            return false
        }
        
        for dictionaryItem in dateDictionaryArray {
            for key in dictionaryItem.keys{
                if key == "date"  {
                    let localeStr = "us"
                    let formatter = DateFormatter()
                    formatter.locale = Locale(identifier: localeStr)
                    formatter.dateFormat = "yyyy-dd-MM"
                    let formattedDate = formatter.date(from: dictionaryItem["date"] as! String)
                    guard (formattedDate?.compare(_date)) == ComparisonResult.orderedSame else {
                        continue
                    }
                    return true
                }
            }
            
        }
        return false
        
    }
    
    
    func checkinfColor(_date: Date!) -> UIColor{
        guard let dateDictionaryArray = self.dateDictArray[0] as? [[String:AnyObject]] else {
            return UIColor.white
        }
        if self.checkingForDate(_date: _date) {
            for dictionaryItem in dateDictionaryArray {
                for key in dictionaryItem.keys{
                    if key == "status"  {
                        let localeStr = "us"
                        let formatter = DateFormatter()
                        formatter.locale = Locale(identifier: localeStr)
                        formatter.dateFormat = "yyyy-dd-MM"
                        let formattedDate = formatter.date(from: dictionaryItem["date"] as! String)
                        guard (formattedDate?.compare(_date)) == ComparisonResult.orderedSame else {
                            continue
                        }
                        switch dictionaryItem["status"] as! NSNumber {
                        case 0:
                            return UIColor.red
                        case 1:
                            return UIColor.green
                        case 2:
                            return UIColor(colorLiteralRed: 255.0, green: 255.0, blue: 0.0, alpha: 1.0)
                        default:
                            return UIColor.white
                        }
                    }
                }
                
            }
            
        }
        return UIColor.white
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    // Function to handle the text color of the calendar
    func handleCellTextColor(view: JTAppleDayCellView?, cellState: CellState) {
        
        guard let myCustomCell = view as? CellView  else {
            return
        }
        
        if cellState.isSelected {
            myCustomCell.dayLabel.textColor = white
        } else {
            if cellState.dateBelongsTo == .thisMonth {
                myCustomCell.dayLabel.textColor = black
            } else {
                myCustomCell.dayLabel.textColor = gray
            }
        }
    }
    
    
    func checkingForMonth(_date: Date!) -> Bool{
        
        guard let dateDictionaryArray = self.dateDictArray[1] as? [[String:AnyObject]] else {
            return false
        }
        for dictionaryItem in dateDictionaryArray {
            for key in dictionaryItem.keys{
                if key == "mth"  {
                    let localeStr = "us"
                    let formatter = DateFormatter()
                    formatter.locale = Locale.current
                    formatter.timeZone = NSTimeZone.local
                    formatter.dateFormat = "yyyy-MM"
                    let formattedDate = formatter.date(from: dictionaryItem["mth"] as! String)
                    let formattedMonthDateString = formatter.string(from: _date)
                      guard (formattedMonthDateString == dictionaryItem["mth"] as! String) else {
                        continue
                    }
                    statusDictArray.append(dictionaryItem)
                }
            }
            
        }
        if statusDictArray.count > 0 {
            return true
        }
        
        return false
        
    }
    
    
    
}

// MARK : JTAppleCalendarDelegate
extension AttendanceHistoryViewController: JTAppleCalendarViewDelegate, JTAppleCalendarViewDataSource {
    /// Asks the data source to return the start and end boundary dates
    /// as well as the calendar to use. You should properly configure
    /// your calendar at this point.
    /// - Parameters:
    ///     - calendar: The JTAppleCalendar view requesting this information.
    /// - returns:
    ///     - ConfigurationParameters instance:
    public func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        let startDate = formatter.date(from: "2016 02 01")!
        let endDate = formatter.date(from: "2018 12 01")!
        let parameters = ConfigurationParameters(startDate: startDate, endDate: endDate, numberOfRows: 5, calendar: testCalendar, generateInDates: .off, generateOutDates: .off, firstDayOfWeek: .sunday, hasStrictBoundaries: true)
        return parameters
    }
    
    func calendar(_ calendar: JTAppleCalendarView, willDisplayCell cell: JTAppleDayCellView, date: Date, cellState: CellState) {
        let myCustomCell = cell as! CellView
        myCustomCell.dayLabel.text = cellState.text
        
        myCustomCell.backgroundColor = self.checkinfColor(_date: date)
        if self.checkingForMonth(_date: date) {
            monthDelegate?.monthChanged(_statusDictArray: statusDictArray)
            statusDictArray.removeAll()
        }
        //        handleCellSelection(view: cell, cellState: cellState)
        handleCellTextColor(view: cell, cellState: cellState)
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleDayCellView?, cellState: CellState) {
        //        handleCellSelection(view: cell, cellState: cellState)
        handleCellTextColor(view: cell, cellState: cellState)
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleDayCellView?, cellState: CellState) {
        //        handleCellSelection(view: cell, cellState: cellState)
        handleCellTextColor(view: cell, cellState: cellState)
    }
    
    
    func calendar(_ calendar: JTAppleCalendarView, sectionHeaderIdentifierFor range: (start: Date, end: Date), belongingTo month: Int) -> String {
        
        return "CalendarHeader"
    }
    
    func calendar(_ calendar: JTAppleCalendarView, sectionHeaderSizeFor range: (start: Date, end: Date), belongingTo month: Int) -> CGSize {
        return CGSize(width: self.view.bounds.width, height: 60)
    }
    
    func calendar(_ calendar: JTAppleCalendarView, willDisplaySectionHeader header: JTAppleHeaderView, range: (start: Date, end: Date), identifier: String) {
        switch identifier {
        case "CalendarHeader":
            let headerCell = header as? CalendarHeader
            headerCell?.monthLabel.text = monthText
            headerCell?.backButton.addTarget(self, action: #selector(previousButtonTapped(_:)), for: .touchUpInside)
            headerCell?.nextButton.addTarget(self, action: #selector(nextButtonTapped(_:)), for: .touchUpInside)
            break
        default:
            break
        }
    }
    
    
    func calendar(_ calendar: JTAppleCalendarView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
        self.setupViewsOfCalendar(from: visibleDates)
    }
    
    func scrollDidEndDecelerating(for calendar: JTAppleCalendarView) {
        self.setupViewsOfCalendar(from: calendarView.visibleDates())
    }
    
    func nextButtonTapped(_ sender: UIButton) {
        monthDelegate?.monthNotPresent()
         statusDictArray.removeAll()
        self.calendarView.scrollToSegment(.next) {
            self.calendarView.visibleDates({ (visibleDates: DateSegmentInfo) in
                self.setupViewsOfCalendar(from: visibleDates)
            })
        }
    }
    
    func previousButtonTapped(_ sender: UIButton) {
        monthDelegate?.monthNotPresent()
         statusDictArray.removeAll()
        self.calendarView.scrollToSegment(.previous) {
            self.calendarView.visibleDates({ (visibleDates: DateSegmentInfo) in
                self.setupViewsOfCalendar(from: visibleDates)
            })
        }
    }
    func setupViewsOfCalendar(from visibleDates: DateSegmentInfo) {
        guard let startDate = visibleDates.monthDates.first else {
            return
        }
        formatter
        
        let month = testCalendar.dateComponents([.month], from: startDate).month!
        let monthName = DateFormatter().monthSymbols[(month-1) % 12]
        // 0 indexed array
        let year = testCalendar.component(.year, from: startDate)
        self.monthText = monthName + " " + String(year)
        calendarView.reloadData()
    }
    
}


