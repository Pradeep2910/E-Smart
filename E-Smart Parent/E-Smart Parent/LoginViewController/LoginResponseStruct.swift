//
//  LoginResponseStruct.swift
//  E-Smart Parent
//
//  Created by Pradeep A C on 14/01/17.
//  Copyright © 2017 Pradeep A C. All rights reserved.
//

import Foundation

class LoginResponseStruct {
    var statusCode: String? = nil
    var description: String? = nil
    
    init(status: String, desc: String) {
        self.statusCode = status
        self.description = desc
    }
}
