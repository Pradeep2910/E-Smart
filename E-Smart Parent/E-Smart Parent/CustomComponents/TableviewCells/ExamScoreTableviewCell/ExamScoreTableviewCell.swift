//
//  ExamScoreTableviewCell.swift
//  E-Smart Parent
//
//  Created by Pradeep A C on 03/03/17.
//  Copyright © 2017 Pradeep A C. All rights reserved.
//

import Foundation
import UIKit

class ExamScoreTableviewCell: UITableViewCell {
    @IBOutlet weak var subjectLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var gradeLabel: UILabel!
    
    func configureCell() {
        subjectLabel.layer.borderColor = UIColor.black.cgColor
        subjectLabel.layer.borderWidth = 1.0
        scoreLabel.layer.borderColor = UIColor.black.cgColor
        scoreLabel.layer.borderWidth = 1.0
        gradeLabel.layer.borderColor = UIColor.black.cgColor
        gradeLabel.layer.borderWidth = 1.0
    }
}
