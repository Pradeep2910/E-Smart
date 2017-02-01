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
import PDTSimpleCalendar

class AttendanceHistoryViewController: PDTSimpleCalendarViewController,PDTSimpleCalendarViewDelegate {
    //    var attendanceHistory : Dictionary = [String : AnyObject]
    var dateDictArray :NSArray = []
    
    var requiredColor : UIColor = UIColor.white
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.delegate = self
        self.weekdayHeaderEnabled = true;
        self.weekdayTextType = PDTSimpleCalendarViewWeekdayTextType(rawValue: 0)!
        let offsetFirstDateComponents : NSDateComponents = NSDateComponents()
        offsetFirstDateComponents.month = -3;
        let offsetLastDateComponents : NSDateComponents = NSDateComponents()
        offsetLastDateComponents.month = 3;
        let ahFirstDate : Date = self.calendar .date(byAdding: offsetFirstDateComponents as DateComponents, to: NSDate() as Date)!
        let ahLastDate : Date = self.calendar .date(byAdding: offsetLastDateComponents as DateComponents, to: NSDate() as Date)!
        self.firstDate = ahFirstDate
        self.lastDate = ahLastDate;
        if UIViewController.instancesRespond(to: #selector(getter: edgesForExtendedLayout)) {
            self.edgesForExtendedLayout = UIRectEdge.bottom
        }
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    
    func checkingForMonth(_date: Date!) -> Bool{
        
        guard let dateDictionaryArray = self.dateDictArray[1] as? [[String:AnyObject]] else {
            return false
        }
        
        for dictionaryItem in dateDictionaryArray {
            for key in dictionaryItem.keys{
                if key == "mth"  {
                    let localeStr = "us"
                    let formatter = DateFormatter()
                    formatter.locale = Locale(identifier: localeStr)
                    formatter.dateFormat = "MM-yyyy"
                    let formattedDate = formatter.date(from: dictionaryItem["date"] as! String)
                    let formattedMonthDateString = formatter.string(from: _date)
                    let formattedMonnthDate = formatter.date(from: formattedMonthDateString)
                    guard (formattedDate?.compare(formattedMonnthDate!)) == ComparisonResult.orderedSame else {
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
    func simpleCalendarViewController(_ controller: PDTSimpleCalendarViewController!, didSelect date: Date!)
    {
        print("Date Selected : %@",date);
        print("Date Selected with Locale %@", date.description(with: NSLocale.system));
        
    }
    
    func simpleCalendarViewController(_ controller: PDTSimpleCalendarViewController!, shouldUseCustomColorsFor date: Date!) -> Bool{
        
        if self.checkingForMonth(_date: date) {
            
        }
        
        return self.checkingForDate(_date: date)
        
        
        
        
    }
    
   func simpleCalendarViewController(controller: PDTSimpleCalendarViewController!, monthDidAppear date: NSDate!){
        
    }
    
    func simpleCalendarViewController(_ controller: PDTSimpleCalendarViewController!, circleColorFor date: Date!) -> UIColor!{
        return self.checkinfColor(_date: date)
        
    }
    func simpleCalendarViewController(_ controller: PDTSimpleCalendarViewController!, textColorFor date: Date!) -> UIColor!{
        return UIColor.black
    }
    

}
extension Date {
    func isGreaterThanDate(dateToCompare: Date) -> Bool {
        //Declare Variables
        var isGreater = false
        
        //Compare Values
        if self.compare(dateToCompare) == ComparisonResult.orderedDescending {
            isGreater = true
        }
        
        //Return Result
        return isGreater
    }
    
    func isLessThanDate(dateToCompare: Date) -> Bool {
        //Declare Variables
        var isLess = false
        
        //Compare Values
        if self.compare(dateToCompare) == ComparisonResult.orderedAscending {
            isLess = true
        }
        
        //Return Result
        return isLess
    }
    
    func equalToDate(dateToCompare: Date) -> Bool {
        //Declare Variables
        var isEqualTo = false
        
        //Compare Values
        if self.compare(dateToCompare) == ComparisonResult.orderedSame {
            isEqualTo = true
        }
        
        //Return Result
        return isEqualTo
    }
    
//    func addDays(daysToAdd: Int) -> Date {
//        let secondsInDays: TimeInterval = Double(daysToAdd) * 60 * 60 * 24
//        let dateWithDaysAdded: Date = self.dateByAddingTimeInterval(secondsInDays)
//        
//        //Return Result
//        return dateWithDaysAdded
//    }
//    
//    func addHours(hoursToAdd: Int) -> Date {
//        let secondsInHours: TimeInterval = Double(hoursToAdd) * 60 * 60
//        let dateWithHoursAdded: Date = self.dateByAddingTimeInterval(secondsInHours)
//        
//        //Return Result
//        return dateWithHoursAdded
//    }
}
