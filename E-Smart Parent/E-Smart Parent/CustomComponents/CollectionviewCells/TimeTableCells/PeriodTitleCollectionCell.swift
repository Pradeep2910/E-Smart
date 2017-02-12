//
//  PeriodTitleCollectionCell.swift
//  E-Smart Parent
//
//  Created by Pradeep A C on 11/02/17.
//  Copyright © 2017 Pradeep A C. All rights reserved.
//

import Foundation
import UIKit

class PeriodTitleCollectionCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel : UILabel!
    @IBOutlet weak var fromTimeLabel : UILabel!
    @IBOutlet weak var toTimeLabel : UILabel!
    
    func loadData(periodDomain: PeriodDomain) {
        titleLabel.text = periodDomain.title
        fromTimeLabel.text = periodDomain.startTime
        toTimeLabel.text = periodDomain.endTime
    }
}
