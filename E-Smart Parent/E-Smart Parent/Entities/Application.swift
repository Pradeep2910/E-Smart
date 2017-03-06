//
//  Application.swift
//  E-Smart Parent
//
//  Created by Pradeep A C on 03/03/17.
//  Copyright © 2017 Pradeep A C. All rights reserved.
//

import Foundation

class Application {
    // Can't init is singleton
    private init() { }
    
    //MARK: Shared Instance
    
    static let application: Application = Application()
    
    //MARK: Local Variable
    
    var loginDetails : LoginDetails = LoginDetails()
}
