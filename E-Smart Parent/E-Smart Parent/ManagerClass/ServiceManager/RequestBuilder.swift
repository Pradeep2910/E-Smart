//
//  RequestBuilder.swift
//  E-Smart Parent
//
//  Created by Pradeep A C on 14/01/17.
//  Copyright © 2017 Pradeep A C. All rights reserved.
//

import Foundation
import Alamofire

class RequestBuilder {
    var reachability : Reachability = Reachability()!
    func buildRequestForLoginWithParams(params: [String: AnyObject]?, completionHandler: @escaping (_ success:Bool, _ response: LoginDetails?,_ error: NSError?) -> ()) {
        reachability.whenReachable = { reachability in
            // this is called on a background thread, but UI updates must
            // be on the main thread, like this:
            DispatchQueue.main.async {
                
                
                ServiceManagerClass().initiateRequest(url: (BASE_URL + LOGIN_URL), requestType: .post, headers: nil, queryParams: nil, params: params, completionHandler: {
                    (success, response, error) in
                    if success {
                        let loginResponse = ResponseParser.parseLoginResponse(jsonData: response)
                        if loginResponse?.loginResponse != nil{
                        completionHandler(false,loginResponse, error)
                        }
                        else{//if loginResponse?.statusCode == "1" {
                        completionHandler(true,loginResponse, error)
                        }
                        //                } else {
                        //                    completionHandler(false,loginResponse, nil)
                        //                }
                    } else {
                        completionHandler(false,nil, error)
                    }
                })
            }
        }
        reachability.whenUnreachable = { reachability in
            // this is called on a background thread, but UI updates must
            // be on the main thread, like this:
            DispatchQueue.main.async {
                completionHandler(false, nil, NSError(domain: "Not Reachable", code: 0, userInfo: nil))
            }
        }
        
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
    
    
    
    func buildRequestForAttendanceHistory(url: String?, completionHandler: @escaping (_ success:Bool, _ response: NSArray?,_ error: NSError?) -> ()) {
            reachability.whenReachable = { reachability in
            // this is called on a background thread, but UI updates must
            // be on the main thread, like this:
            DispatchQueue.main.async {
                
                
                
                ServiceManagerClass().initiateRequest(url: url, requestType: .get, headers: nil, queryParams: nil, params: nil, completionHandler: {
                    (success, response, error) in
                    if success {
                        let eventResponse = ResponseParser.parseAttendanceHistoryResponse(jsonData: response)
                        //if loginResponse?.statusCode == "1" {
                        completionHandler(true,eventResponse, error)
                        //                } else {
                        //                    completionHandler(false,loginResponse, nil)
                        //                }
                    } else {
                        completionHandler(false,nil, error)
                    }
                })
            }
        }
        reachability.whenUnreachable = { reachability in
            // this is called on a background thread, but UI updates must
            // be on the main thread, like this:
            DispatchQueue.main.async {
                completionHandler(false, nil, NSError(domain: "Not Reachable", code: 0, userInfo: nil))
            }
        }
        
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
        
    }

    
    
    
    
    func buildRequestForEventsWithParams(params: [String: AnyObject]?, completionHandler: @escaping (_ success:Bool, _ response: [EventDetails]?,_ error: NSError?) -> ()) {
        reachability.whenReachable = { reachability in
            // this is called on a background thread, but UI updates must
            // be on the main thread, like this:
            DispatchQueue.main.async {
                
                
                
                ServiceManagerClass().initiateRequest(url: (BASE_URL + EVENTS_URL), requestType: .post, headers: nil, queryParams: nil, params: params, completionHandler: {
                    (success, response, error) in
                    if success {
                        let eventResponse = ResponseParser.parseEventsResponse(jsonData: response)
                        //if loginResponse?.statusCode == "1" {
                        completionHandler(true,eventResponse, error)
                        //                } else {
                        //                    completionHandler(false,loginResponse, nil)
                        //                }
                    } else {
                        completionHandler(false,nil, error)
                    }
                })
            }
        }
        reachability.whenUnreachable = { reachability in
            // this is called on a background thread, but UI updates must
            // be on the main thread, like this:
            DispatchQueue.main.async {
                completionHandler(false, nil, NSError(domain: "Not Reachable", code: 0, userInfo: nil))
            }
        }
        
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
        
    }
    
    func buildRequestForCircularsWithParams(params: [String: AnyObject]?, completionHandler: @escaping (_ success:Bool, _ response: [CircularDetails]?,_ error: NSError?) -> ()) {
        reachability.whenReachable = { reachability in
            // this is called on a background thread, but UI updates must
            // be on the main thread, like this:
            DispatchQueue.main.async {
                
                
                
                
                ServiceManagerClass().initiateRequest(url: (BASE_URL + CIRCULARS_URL), requestType: .post, headers: nil, queryParams: nil, params: params, completionHandler: {
                    (success, response, error) in
                    if success {
                        let eventResponse = ResponseParser.parseCircularsResponse(jsonData: response)
                        //if loginResponse?.statusCode == "1" {
                        completionHandler(true,eventResponse, error)
                        //                } else {
                        //                    completionHandler(false,loginResponse, nil)
                        //                }
                    } else {
                        
                        completionHandler(false,nil, error)
                    }
                })
            }
        }
        reachability.whenUnreachable = { reachability in
            // this is called on a background thread, but UI updates must
            // be on the main thread, like this:
            DispatchQueue.main.async {
                completionHandler(false, nil, NSError(domain: "Not Reachable", code: 0, userInfo: nil))
            }
        }
        
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
        
    }
    
    func buildRequestForHomeworksWithParams(params: [String: AnyObject]?, completionHandler: @escaping (_ success:Bool, _ response: [HomeworkDetails]?,_ error: NSError?) -> ()) {
        reachability.whenReachable = { reachability in
            // this is called on a background thread, but UI updates must
            // be on the main thread, like this:
            DispatchQueue.main.async {
                
                
                
                
                ServiceManagerClass().initiateRequest(url: (BASE_URL + HOMEWORKS_URL), requestType: .post, headers: nil, queryParams: nil, params: params, completionHandler: {
                    (success, response, error) in
                    if success {
                        let eventResponse = ResponseParser.parseHomeworksResponse(jsonData: response)
                        //if loginResponse?.statusCode == "1" {
                        completionHandler(true,eventResponse, error)
                        //                } else {
                        //                    completionHandler(false,loginResponse, nil)
                        //                }
                    } else {
                        
                        completionHandler(false,nil, error)
                    }
                })
            }
        }
        reachability.whenUnreachable = { reachability in
            // this is called on a background thread, but UI updates must
            // be on the main thread, like this:
            DispatchQueue.main.async {
                completionHandler(false, nil, NSError(domain: "Not Reachable", code: 0, userInfo: nil))
            }
        }
        
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
        
    }
    
    func buildRequestForTimetableWithParams(params: [String: AnyObject]?, completionHandler: @escaping (_ success:Bool, _ response: [DayDomain]?,_ error: NSError?) -> ()) {
        
        reachability.whenReachable = { reachability in
            // this is called on a background thread, but UI updates must
            // be on the main thread, like this:
            DispatchQueue.main.async {
                
                
                
                
                ServiceManagerClass().initiateRequest(url: (BASE_URL + TIMETABLE_URL), requestType: .post, headers: nil, queryParams: nil, params: params, completionHandler: {
                    (success, response, error) in
                    if success {
                        let eventResponse = ResponseParser.parseTimeTableResponse(jsonData: response)
                        //if loginResponse?.statusCode == "1" {
                        completionHandler(true,eventResponse, error)
                        //                } else {
                        //                    completionHandler(false,loginResponse, nil)
                        //                }
                    } else {
                        
                        completionHandler(false,nil, error)
                    }
                })
            }
        }
        reachability.whenUnreachable = { reachability in
            // this is called on a background thread, but UI updates must
            // be on the main thread, like this:
            DispatchQueue.main.async {
                completionHandler(false, nil, NSError(domain: "Not Reachable", code: 0, userInfo: nil))
            }
        }
        
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
        
    }
    
    
    func buildRequestForExamResultsWithParams(params: [String: AnyObject]?, completionHandler: @escaping (_ success:Bool, _ response: Dictionary<String,[ExamResultDetails]>?,_ error: NSError?) -> ()) {
        
        reachability.whenReachable = { reachability in
            // this is called on a background thread, but UI updates must
            // be on the main thread, like this:
            DispatchQueue.main.async {
                
                
                
                
                ServiceManagerClass().initiateRequest(url: (BASE_URL + EXAMRESULT_URL), requestType: .post, headers: nil, queryParams: nil, params: params, completionHandler: {
                    (success, response, error) in
                    if success {
                        let eventResponse = ResponseParser.parseExamResultResponse(jsonData: response)
                        //if loginResponse?.statusCode == "1" {
                        completionHandler(true,eventResponse, error)
                        //                } else {
                        //                    completionHandler(false,loginResponse, nil)
                        //                }
                    } else {
                        
                        completionHandler(false,nil, error)
                    }
                })
            }
        }
        reachability.whenUnreachable = { reachability in
            // this is called on a background thread, but UI updates must
            // be on the main thread, like this:
            DispatchQueue.main.async {
                completionHandler(false, nil, NSError(domain: "Not Reachable", code: 0, userInfo: nil))
            }
        }
        
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
        
    }
    
    
    func buildRequestUpdateTokenWithParams(params: [String: AnyObject]?, completionHandler: @escaping (_ success:Bool, _ response: NSArray?,_ error: NSError?) -> ()) {
        
        reachability.whenReachable = { reachability in
            // this is called on a background thread, but UI updates must
            // be on the main thread, like this:
            DispatchQueue.main.async {
                
                
                
                
                ServiceManagerClass().initiateRequest(url: (BASE_URL + UPDATEFIREBASETOKEN_URL), requestType: .post, headers: nil, queryParams: nil, params: params, completionHandler: {
                    (success, response, error) in
                    if success {
                        let eventResponse = ResponseParser.parseResponse(jsonData: response)
                        //if loginResponse?.statusCode == "1" {
                        completionHandler(true,[eventResponse] as NSArray?, error)
                        //                } else {
                        //                    completionHandler(false,loginResponse, nil)
                        //                }
                    } else {
                        
                        completionHandler(false,nil, error)
                    }
                })
            }
        }
        reachability.whenUnreachable = { reachability in
            // this is called on a background thread, but UI updates must
            // be on the main thread, like this:
            DispatchQueue.main.async {
                completionHandler(false, nil, NSError(domain: "Not Reachable", code: 0, userInfo: nil))
            }
        }
        
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
        
    }

    func buildRequestGetConversationListWithParams(params: [String: AnyObject]?, completionHandler: @escaping (_ success:Bool, _ response: [ConversationList]?,_ error: NSError?) -> ()) {
        
        reachability.whenReachable = { reachability in
            // this is called on a background thread, but UI updates must
            // be on the main thread, like this:
            DispatchQueue.main.async {
                
                
                
                
                ServiceManagerClass().initiateRequest(url: (BASE_URL + GETCONVERSATIONLIST_URL), requestType: .post, headers: nil, queryParams: nil, params: params, completionHandler: {
                    (success, response, error) in
                    if success {
                        let eventResponse = ResponseParser.parseConversationListResponse(jsonData: response)
                        //if loginResponse?.statusCode == "1" {
                        completionHandler(true,eventResponse, error)
                        //                } else {
                        //                    completionHandler(false,loginResponse, nil)
                        //                }
                    } else {
                        
                        completionHandler(false,nil, error)
                    }
                })
            }
        }
        reachability.whenUnreachable = { reachability in
            // this is called on a background thread, but UI updates must
            // be on the main thread, like this:
            DispatchQueue.main.async {
                completionHandler(false, nil, NSError(domain: "Not Reachable", code: 0, userInfo: nil))
            }
        }
        
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
        
    }
    

    func buildRequestGetConversationHistoryWithParams(params: [String: AnyObject]?, completionHandler: @escaping (_ success:Bool, _ response: [ConversationMessages]?,_ error: NSError?) -> ()) {
        
        reachability.whenReachable = { reachability in
            // this is called on a background thread, but UI updates must
            // be on the main thread, like this:
            DispatchQueue.main.async {
                
                
                
                
                ServiceManagerClass().initiateRequest(url: (BASE_URL + GETCONVERSATIONHISTORY_URL), requestType: .post, headers: nil, queryParams: nil, params: params, completionHandler: {
                    (success, response, error) in
                    if success {
                        let eventResponse = ResponseParser.parseConversationHistoryAndMessageResponse(jsonData: response)
                        //if loginResponse?.statusCode == "1" {
                        completionHandler(true,eventResponse, error)
                        //                } else {
                        //                    completionHandler(false,loginResponse, nil)
                        //                }
                    } else {
                        
                        completionHandler(false,nil, error)
                    }
                })
            }
        }
        reachability.whenUnreachable = { reachability in
            // this is called on a background thread, but UI updates must
            // be on the main thread, like this:
            DispatchQueue.main.async {
                completionHandler(false, nil, NSError(domain: "Not Reachable", code: 0, userInfo: nil))
            }
        }
        
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
        
    }
    
    
    func buildRequestSendMessageWithParams(params: [String: AnyObject]?, completionHandler: @escaping (_ success:Bool, _ response: [ConversationMessages]?,_ error: NSError?) -> ()) {
        
        reachability.whenReachable = { reachability in
            // this is called on a background thread, but UI updates must
            // be on the main thread, like this:
            DispatchQueue.main.async {
                
                
                
                
                ServiceManagerClass().initiateRequest(url: (BASE_URL + SENDMESSAGE_URL), requestType: .post, headers: nil, queryParams: nil, params: params, completionHandler: {
                    (success, response, error) in
                    if success {
                        let eventResponse = ResponseParser.parseConversationHistoryAndMessageResponse(jsonData: response)
                        //if loginResponse?.statusCode == "1" {
                        completionHandler(true,eventResponse, error)
                        //                } else {
                        //                    completionHandler(false,loginResponse, nil)
                        //                }
                    } else {
                        
                        completionHandler(false,nil, error)
                    }
                })
            }
        }
        reachability.whenUnreachable = { reachability in
            // this is called on a background thread, but UI updates must
            // be on the main thread, like this:
            DispatchQueue.main.async {
                completionHandler(false, nil, NSError(domain: "Not Reachable", code: 0, userInfo: nil))
            }
        }
        
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
        
    }
    
    func buildRequestGetContactsWithParams(params: [String: AnyObject]?, completionHandler: @escaping (_ success:Bool, _ response: [ContactDetails]?,_ error: NSError?) -> ()) {
        
        reachability.whenReachable = { reachability in
            // this is called on a background thread, but UI updates must
            // be on the main thread, like this:
            DispatchQueue.main.async {
                
                
                
                
                ServiceManagerClass().initiateRequest(url: (BASE_URL + GETCONTACTS_URL), requestType: .post, headers: nil, queryParams: nil, params: params, completionHandler: {
                    (success, response, error) in
                    if success {
                        let eventResponse = ResponseParser.parseGetContactsResponse(jsonData: response)
                        //if loginResponse?.statusCode == "1" {
                        completionHandler(true,eventResponse, error)
                        //                } else {
                        //                    completionHandler(false,loginResponse, nil)
                        //                }
                    } else {
                        
                        completionHandler(false,nil, error)
                    }
                })
            }
        }
        reachability.whenUnreachable = { reachability in
            // this is called on a background thread, but UI updates must
            // be on the main thread, like this:
            DispatchQueue.main.async {
                completionHandler(false, nil, NSError(domain: "Not Reachable", code: 0, userInfo: nil))
            }
        }
        
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
        
    }
    

    
    
    
    
}
