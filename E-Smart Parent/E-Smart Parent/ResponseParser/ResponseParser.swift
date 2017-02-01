//
//  ResponseParser.swift
//  E-Smart Parent
//
//  Created by Pradeep A C on 14/01/17.
//  Copyright © 2017 Pradeep A C. All rights reserved.
//

import Foundation
import SwiftyJSON

class ResponseParser {
    class func parseLoginResponse (jsonData: NSDictionary?) -> LoginDetails? {
        if jsonData != nil {
            let response = jsonData?["data"]! as! String
            guard let responseDictArray = response.parseJSONString as? NSArray
                else {
                    return nil
            }
            if responseDictArray.count > 0 {
                let loginDetails = LoginDetails(jsonString:responseDictArray.lastObject as! Dictionary<String, Any>)
                return loginDetails
            }
            else{
                return nil
            }
            
        }
        else
        {
            return nil
        }
        
    }
    
    
    class func parseAttendanceHistoryResponse (jsonData: NSDictionary?) -> NSArray? {
        if jsonData != nil {
            let response = jsonData?["data"]! as! String
            guard let responseDictArray = response.parseJSONString as? NSArray
                else {
                    return nil
            }
            return responseDictArray
        }
        else
        {
            return nil
        }
    }

    
    class func parseEventsResponse (jsonData: NSDictionary?) -> [EventDetails]? {
        if jsonData != nil {
            let response = jsonData?["data"]! as! String
            guard let responseDictArray = response.parseJSONString as? NSArray
                else {
                    return nil
            }
            if (responseDictArray.count) > 0 {
                var arrayOfEvents = [EventDetails]()
                for jsonObj in responseDictArray {
                    let event = EventDetails(jsonString: jsonObj as! Dictionary<String, Any>)
                    arrayOfEvents.append(event!)
                }
                return arrayOfEvents
            }
            return nil
        }
        else
        {
            return nil
        }
    }
    
    
    
    class func parseCircularsResponse (jsonData: NSDictionary?) -> [CircularDetails]? {
        if jsonData != nil {
            let response = jsonData?["data"]! as! String
            guard let responseDictArray = response.parseJSONString as? NSArray
                else {
                    return nil
            }
            if (responseDictArray.count) > 0 {
                var arrayOfCirculars = [CircularDetails]()
                for jsonObj in responseDictArray {
                    let circular = CircularDetails(jsonString: jsonObj as! Dictionary<String, Any>)
                    arrayOfCirculars.append(circular!)
                }
                return arrayOfCirculars
            }
            return nil
        }
        else
        {
            return nil
        }
    }
    
    class func parseHomeworksResponse (jsonData: NSDictionary?) -> [HomeworkDetails]? {
        if jsonData != nil {
            let response = jsonData?["data"]! as! String
            guard let responseDictArray = response.parseJSONString as? NSArray
                else {
                    return nil
            }
            if (responseDictArray.count) > 0 {
                var arrayOfHomeworks = [HomeworkDetails]()
                for jsonObj in responseDictArray {
                    let circular = HomeworkDetails(jsonString: jsonObj as! Dictionary<String, Any>)
                    arrayOfHomeworks.append(circular!)
                }
                return arrayOfHomeworks
            }
            return nil
        }
        else
        {
            return nil
        }
    }
    
    class func parseResponse (jsonData: NSDictionary?) {
        if jsonData != nil {
            let response = jsonData?["data"]! as! String
            
           
            
        }
    }
    class func parseConversationListResponse (jsonData: NSDictionary?) -> [ConversationList]? {
        if jsonData != nil {
            let response = jsonData?["data"]! as! String
            guard let responseDictArray = response.parseJSONString as? NSArray
                else {
                    return nil
            }
            if (responseDictArray.count) > 0 {
                var arrayOfConversations = [ConversationList]()
                for jsonObj in responseDictArray {
                    let conversationList = ConversationList(jsonString: jsonObj as! Dictionary<String, Any>)
                    arrayOfConversations.append(conversationList!)
                }
                return arrayOfConversations
            }
            return nil
        }
        else
        {
            return nil
        }
    }
    
    class func parseConversationHistoryAndMessageResponse (jsonData: NSDictionary?) -> [ConversationMessages]? {
        if jsonData != nil {
            let response = jsonData?["data"]! as! String
            guard let responseDictArray = response.parseJSONString as? NSArray
                else {
                    return nil
            }
            if (responseDictArray.count) > 0 {
                var arrayOfMessages = [ConversationMessages]()
                for jsonObj in responseDictArray {
                    let conversationMessage = ConversationMessages(jsonString: jsonObj as! Dictionary<String, Any>)
                    arrayOfMessages.append(conversationMessage!)
                }
                return arrayOfMessages
            }
            return nil
        }
        else
        {
            return nil
        }
    }
    
    class func parseGetContactsResponse (jsonData: NSDictionary?) -> [ContactDetails]? {
        if jsonData != nil {
            let response = jsonData?["data"]! as! String
            guard let responseDictArray = response.parseJSONString as? NSArray
                else {
                    return nil
            }
            if (responseDictArray.count) > 0 {
                var arrayOfContacts = [ContactDetails]()
                for jsonObj in responseDictArray {
                    let contactDetail = ContactDetails(jsonString: jsonObj as! Dictionary<String, Any>)
                    arrayOfContacts.append(contactDetail!)
                }
                return arrayOfContacts
            }
            return nil
        }
        else
        {
            return nil
        }
    }
    
    
    
    class func parseExamResultResponse (jsonData: NSDictionary?) -> Dictionary<String,[ExamResultDetails]>? {
        if jsonData != nil {
            let response = jsonData?["data"]! as! String
            guard let responseDictArray = response.parseJSONString as? NSArray
                else {
                    return nil
            }
            if (responseDictArray.count) > 0 {
                var arrayOfResults = [ExamResultDetails]()
                for jsonObj in responseDictArray {
                    let examResult = ExamResultDetails(jsonString: jsonObj as! Dictionary<String, Any>)
                    arrayOfResults.append(examResult!)
                }
                
                if arrayOfResults.count > 0 {
                    var finalExamResultsDict = Dictionary<String,[ExamResultDetails]>()
                    let firstKey = arrayOfResults[0].examID
                    finalExamResultsDict[firstKey!] = [arrayOfResults[0]]
                    for (index, _) in arrayOfResults.enumerated() {
                        if index > 0 {
                            let result = arrayOfResults[index]
                            if finalExamResultsDict.keys.contains(result.examID) {
                                var examResultArray = finalExamResultsDict[result.examID!]! as[ExamResultDetails]
                                examResultArray.append(arrayOfResults[index])
                                finalExamResultsDict[result.examID!] = examResultArray
                            }
                            else{
                                finalExamResultsDict[result.examID!] = [result]
                            }

                        }
                    
                    
                    }
                    return finalExamResultsDict
                }
                
            }
            
            
            return nil
        }
        else
        {
            return nil
        }
    }



}
