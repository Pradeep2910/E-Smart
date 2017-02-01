//
//  ConversationListTableviewCell.swift
//  E-Smart Parent
//
//  Created by Pradeep A C on 18/01/17.
//  Copyright © 2017 Pradeep A C. All rights reserved.
//

import Foundation
import UIKit

class ConversationListTableviewCell: UITableViewCell {
    @IBOutlet weak var toUserId: UILabel!
    @IBOutlet weak var messageContent: UILabel!
    
    @IBOutlet weak var messageCount: UILabel!
    @IBOutlet weak var messageDate: UILabel!
}
