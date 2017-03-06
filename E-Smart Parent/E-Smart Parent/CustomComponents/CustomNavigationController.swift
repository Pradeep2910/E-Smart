//
//  CustomNavigationController.swift
//  E-Smart Parent
//
//  Created by Pradeep A C on 04/03/17.
//  Copyright © 2017 Pradeep A C. All rights reserved.
//

import Foundation
import UIKit

class CustomNavigationController: UINavigationController {
    func configure() {
        let titleDict: NSDictionary = [NSForegroundColorAttributeName: UIColor.white]
        self.navigationBar.titleTextAttributes = titleDict as? [String : Any]
        self.navigationBar.barTintColor = UIColor(hexString: "4054B2")
        self.navigationBar.tintColor = UIColor.white
        self.automaticallyAdjustsScrollViewInsets = false
        self.navigationBar.isTranslucent = false
    }
}
