//
//  APIConstants.swift
//  E-Smart Parent
//
//  Created by Pradeep A C on 14/01/17.
//  Copyright © 2017 Pradeep A C. All rights reserved.
//

import Foundation

public let REQUEST_TIMEOUT_TIME:TimeInterval = 40

public let BASE_URL: String = "http://cluster.nowskitchen.com/api/Student/"

public let LOGIN_URL: String = "AuthenticateUser"

public let EVENTS_URL: String = "GetEventsByClass"

public let CIRCULARS_URL: String = "GetCircularsByClass"

public let HOMEWORKS_URL: String = "GetHomeworkByClass"

public let TIMETABLE_URL: String = "GetTimetableAndSubjects"

public let EXAMRESULT_URL: String = "GetExamResultsByStudent"

public let GETCONVERSATIONLIST_URL: String = "GetConversationList"

public let GETCONVERSATIONHISTORY_URL : String = "GetConversationHistory"

public let UPDATEFIREBASETOKEN_URL: String = "UpdateFirebaseToken"

public let SENDMESSAGE_URL: String = "SendMessage"

public let GETCONTACTS_URL: String = "GetContacts"
