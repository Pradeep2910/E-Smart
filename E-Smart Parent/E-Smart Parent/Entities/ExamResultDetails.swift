//
//  ExamResultDetails.swift
//  E-Smart Parent
//
//  Created by Pradeep A C on 22/01/17.
//  Copyright © 2017 Pradeep A C. All rights reserved.
//

import Foundation

class ExamResultDetails {
    var examID: String!
    var subjectID: String!
    var score: NSNumber!
    
    init?(jsonString:Dictionary<String, Any>) {
        
        
        
        if let examId = jsonString["exam_id"] as? String {
            self.examID = examId
        }else{
            self.examID = ""
        }
        if let subId = jsonString["subject_id"] as? String {
            self.subjectID = subId
        }else{
            self.subjectID = ""
        }
        if let scoreValue = jsonString["score"] as? NSNumber {
            self.score = scoreValue
        }else{
            self.score = nil
        }
    }
    init() {
        
    }

}
