//
//  HomeworkDetails.swift
//  E-Smart Parent
//
//  Created by Pradeep A C on 15/01/17.
//  Copyright © 2017 Pradeep A C. All rights reserved.
//

import Foundation


class HomeworkDetails {
    var itemID: NSNumber!
    var itemType: String!
    var targetDate: Date!
    var subjectID: String!
    var itemDescription: String!
    var fromUserID: String!
    var attachmentName: String!
    init?(jsonString:Dictionary<String, Any>) {
        
        
        
        if let itemId = jsonString["item_id"] as? NSNumber {
            self.itemID = itemId
        }else{
            self.itemID = nil
        }
        if let itemtype = jsonString["item_type"] as? String {
            self.itemType = itemtype
        }else{
            self.itemType = ""
        }
        if let targetDateValue = jsonString["target_date"] as? String {
            self.targetDate = self.convertStringToDate(_dateString: targetDateValue)
        }else{
            self.targetDate = nil
        }
        if let suject = jsonString["subject_id"] as? String{
            self.subjectID = suject
        }else{
            self.subjectID = ""
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
        if let attachment = jsonString["attachment_name"] as? String {
            self.attachmentName = attachment
        }else{
            self.attachmentName = ""
        }
    }
    init() {
        
    }
    
    func convertStringToDate(_dateString: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: _dateString)
        return date!
    }
    
}
