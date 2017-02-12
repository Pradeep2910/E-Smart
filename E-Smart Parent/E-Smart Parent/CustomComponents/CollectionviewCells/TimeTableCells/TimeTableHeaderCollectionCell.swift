//
//  TimeTableHeaderCollectionCell.swift
//  E-Smart Parent
//
//  Created by Pradeep A C on 11/02/17.
//  Copyright © 2017 Pradeep A C. All rights reserved.
//

import Foundation
import UIKit

class TimeTableHeaderCollectionCell: UICollectionViewCell {
     @IBOutlet weak var titleLabel : UILabel!
    
    func loadData(dayDomain : DayDomain, indexPath : IndexPath) {
        if indexPath.section == 0 && indexPath.row == 0 {
            titleLabel.text = "Days"
        }
        else{
            titleLabel.text = dayDomain.getShortForm()
        }
    }
}
