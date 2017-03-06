//
//  LogoutPopoverController.swift
//  E-Smart Parent
//
//  Created by Pradeep A C on 12/02/17.
//  Copyright © 2017 Pradeep A C. All rights reserved.
//

import Foundation
import UIKit

protocol logoutDelegate {
    func logoutFunction()
}
class LogoutPopoverController: UIViewController {
    var logoutDelegate : logoutDelegate? = nil
    @IBAction func logoutTapped(_ sender: Any) {
        Application.application.loginDetails.isLoggedOut = true
        let appService = ApplicationService()
        appService.updateLoginStatus()
        
        logoutDelegate?.logoutFunction()
    }
}
