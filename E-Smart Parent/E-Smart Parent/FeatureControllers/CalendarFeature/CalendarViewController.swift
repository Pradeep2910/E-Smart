//
//  CalendarViewController.swift
//  SchoolApp
//
//  Created by Pradeep A C on 21/10/16.
//  Copyright © 2016 Pradeep A C. All rights reserved.
//

import Foundation
import MBCalendarKit

class CalendarViewController: UIViewController,CKCalendarViewDataSource,CKCalendarViewDelegate {
    public func calendarView(_ calendarView: CKCalendarView!, eventsFor date: Date!) -> [Any]! {
         return self.data.object(forKey: date) as! [AnyObject]!
    }
    var eventsArray : Array<EventDetails> = [EventDetails]()
    var data : NSMutableDictionary = [:]


    override func viewDidLoad() {
        super.viewDidLoad()
        let calendar : CKCalendarView = CKCalendarView()
        calendar
        calendar.delegate = self
        calendar.dataSource = self
        self.view .addSubview(calendar)
        
        
        self.creteCalendarEvents()

    }
   //Creating Calendar Events From Response Array
    func creteCalendarEvents() {
        for dictionaryItem in eventsArray {
            let event : CKCalendarEvent = CKCalendarEvent(title: dictionaryItem.itemName, andDate: dictionaryItem.targetDate, andInfo: nil)
            if let val = data[dictionaryItem.targetDate] {
                let dateArray = val as! NSArray
                dateArray.adding(event)
                data[dictionaryItem.targetDate] = dateArray
            }
            else{
                data[dictionaryItem.targetDate] = [event]
            }
        }
    }
}
