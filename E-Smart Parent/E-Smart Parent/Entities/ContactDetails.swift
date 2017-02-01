//
//  ContactDetails.swift
//  E-Smart Parent
//
//  Created by Pradeep A C on 21/01/17.
//  Copyright © 2017 Pradeep A C. All rights reserved.
//

import Foundation

class ContactDetails{
    var userID: String!
    var userName: String!
    var userRole: String!
    var contact: String!
    
    init?(jsonString:Dictionary<String, Any>) {
        
        
        
        if let userId = jsonString["user_id"] as? String {
            self.userID = userId
        }else{
            self.userID = ""
        }
        if let uName = jsonString["user_name"] as? String {
            self.userName = uName
        }else{
            self.userName = ""
        }
        if let uRole = jsonString["user_role"] as? String {
            self.userRole = uRole
        }else{
            self.userRole = ""
        }
        if let contactNo = jsonString["contact"] as? String{
            self.contact = contactNo
        }else{
            self.contact = ""
        }
    }
    init() {
        
    }
}

