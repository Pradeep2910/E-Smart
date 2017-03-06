//
//  ConversationList.swift
//  E-Smart Parent
//
//  Created by Pradeep A C on 18/01/17.
//  Copyright © 2017 Pradeep A C. All rights reserved.
//

import Foundation

class ConversationList {
    var schoolID: String!
    var messageID: String!
    var fromUserRole: String!
    var fromUserID: String!
    var fromUserName: String!
    var toUserRole: String!
    var toUserID: String!
    var toUserName: String!
    var messageContent: String!
    var messageDate: String!
    init?(jsonString:Dictionary<String, Any>) {
        
        
        
        if let schoolId = jsonString["school_id"] as? String {
            self.schoolID = schoolId
        }else{
            self.schoolID = ""
        }
        if let mId = jsonString["message_id"] as? String {
            self.messageID = mId
        }else{
            self.messageID = ""
        }
        if let fromUrole = jsonString["from_user_role"] as? String {
            self.fromUserRole = fromUrole
        }else{
            self.fromUserRole = ""
        }
        if let fromUID = jsonString["from_user_id"] as? String{
            self.fromUserID = fromUID
        }else{
            self.fromUserID = ""
        }
        if let fromUName = jsonString["from_user_name"] as? String{
            self.fromUserName = fromUName
        }else{
            self.fromUserName = ""
        }
        if let toURole = jsonString["to_user_role"] as? String {
            self.toUserRole = toURole
        }else{
            self.toUserRole = ""
        }
        if let toUName = jsonString["to_user_name"] as? String{
            self.toUserName = toUName
        }else{
            self.toUserName = ""
        }
        if let uID = jsonString["to_user_id"] as? String {
            self.toUserID = uID
        }else{
            self.toUserID = ""
        }
        if let mContent = jsonString["content"] as? String {
            self.messageContent = mContent
        }else{
            self.messageContent = ""
        }
        if let mDate = jsonString["md"] as? String {
            self.messageDate =  self.convertStringToDate(_dateString: mDate)
        }else{
            self.messageDate = ""
        }
    }
    
    init() {
        
    }
    
    func convertStringToDate(_dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd'T'HH:mm:ss"
        let date = dateFormatter.date(from: _dateString)
        dateFormatter.dateFormat = "dd MMM',' hh:mm a"
       let dateString = dateFormatter.string(from: date!)
        return dateString
    }


}
