//
//  LoginDetails.swift
//  E-Smart Parent
//
//  Created by Pradeep A C on 14/01/17.
//  Copyright © 2017 Pradeep A C. All rights reserved.
//

import Foundation
import SwiftyJSON

class LoginDetails {
    var studendID: String!
    var studentName: String!
    var studentAddress: String!
    var guardianName: String!
    var studentContact: String!
    var schoolID: String!
     var classID: String!
     var sectionID: String!
    var dateOfBirth: String!
    var batchID: String!
    var feesType: String!
    var additionalDetails : AdditionalDetails!
    
    init?(jsonString:Dictionary<String, Any>) {
        
      
            
            if let studentId = jsonString["student_id"] as? String {
                self.studendID = studentId
            }else{
                self.studendID = ""
            }
            if let sName = jsonString["student_name"] as? String {
                self.studentName = sName
            }else{
                self.studentName = ""
            }
            if let address = jsonString["student_address"] as? String {
                self.studentAddress = address
            }else{
                self.studentAddress = ""
            }
            if let guardian = jsonString["student_guardian_name"] as? String{
                self.guardianName = guardian
            }else{
                self.guardianName = ""
            }
            if let contact = jsonString["student_contact"] as? String {
                self.studentContact = contact
            }else{
                self.studentContact = ""
            }
            if let schoolId = jsonString["school_id"] as? String {
                self.schoolID = schoolId
            }else{
                self.schoolID = ""
            }
            if let classId = jsonString["class_id"] as? String {
                self.classID = classId
            }else{
                self.classID = ""
            }
            if let sectionId = jsonString["section_id"] as? String {
                self.sectionID = sectionId
            }else{
                self.sectionID = ""
            }
            if let dob = jsonString["dob"] as? String {
                self.dateOfBirth = dob
            }else{
                self.dateOfBirth = ""
            }
        if let batchId = jsonString["batch_id"] as? String {
            self.batchID = batchId
        }else{
            self.batchID = ""
        }
        if let feestype = jsonString["fees_type"] as? String {
            self.feesType = feestype
        }else{
            self.feesType = ""
        }
        let response = jsonString["additional_details"]! as! String
        guard let responseDict = response.parseJSONString as? NSDictionary
            else {
                return nil
        }
        additionalDetails = AdditionalDetails(jsonString:responseDict as! Dictionary<String, Any>)
        
        
        }
    init() {
        
    }
    }
    

