//
//  EventDetails.swift
//  E-Smart Parent
//
//  Created by Pradeep A C on 14/01/17.
//  Copyright © 2017 Pradeep A C. All rights reserved.
//

import Foundation
import SwiftyJSON

class EventDetails {
    var itemID: NSNumber!
    var startDate: Date!
    var targetDate: Date!
    var itemName: String!
    var itemDescription: String!
    var fromUserID: String!
    init?(jsonString:Dictionary<String, Any>) {
        
        
        
        if let itemId = jsonString["item_id"] as? NSNumber {
            self.itemID = itemId
        }else{
            self.itemID = nil
        }
        if let startDateValue = jsonString["start_date"] as? String {
            self.startDate = self.convertStringToDate(_dateString: startDateValue)
        }else{
            self.startDate = nil
        }
        if let targetDateValue = jsonString["target_date"] as? String {
            self.targetDate = self.convertStringToDate(_dateString: targetDateValue)
        }else{
            self.targetDate = nil
        }
        if let name = jsonString["item_name"] as? String{
            self.itemName = name
        }else{
            self.itemName = ""
        }
        if let description = jsonString["item_desc"] as? String {
            self.itemDescription = description
        }else{
            self.itemDescription = ""
        }
        if let fromId = jsonString["from_user_id"] as? String {
            self.fromUserID = fromId
        }else{
            self.fromUserID = ""
        }
    }
    init() {
        
    }
    
    func convertStringToDate(_dateString: String) -> Date {
        let fullNameArr = _dateString.components(separatedBy: "T")
        let dateString = fullNameArr[0]
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: dateString)
        return date!
    }
    
}

