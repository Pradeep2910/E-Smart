//
//  SubjectCollectionCell.swift
//  E-Smart Parent
//
//  Created by Pradeep A C on 11/02/17.
//  Copyright © 2017 Pradeep A C. All rights reserved.
//

import Foundation
import UIKit

class SubjectCollectionCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel : UILabel!
    func loadData(periodDomain : PeriodDomain) {
        titleLabel.text = periodDomain.subject
    }
}
