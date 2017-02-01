//
//  PaddedMessageLabel.swift
//  E-Smart Parent
//
//  Created by Pradeep A C on 19/01/17.
//  Copyright © 2017 Pradeep A C. All rights reserved.
//

import Foundation
import UIKit

class PaddedMessageLabel: UILabel {
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        super.drawText(in: UIEdgeInsetsInsetRect(rect, insets))
    }
}
