//
//  HomeworkDetailsViewcontroller.swift
//  E-Smart Parent
//
//  Created by Pradeep A C on 15/01/17.
//  Copyright © 2017 Pradeep A C. All rights reserved.
//

import Foundation
import UIKit

class HomeworkDetailsViewcontroller: UIViewController {
    var selectedHomework : HomeworkDetails = HomeworkDetails()
    @IBOutlet weak var documentName: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var homeworkDescription: UILabel!
    @IBOutlet weak var homeworkTitle: UILabel!
      @IBOutlet weak var homeworkSubject: UILabel!
    @IBAction func attachmentButtonTapped(_ sender: Any) {
    }
    func stringFromDate(_date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let stringDate = dateFormatter.string(from: _date)
        
        return stringDate
    }
    override func viewDidLoad() {
        self.homeworkSubject.text = self.selectedHomework.subjectID
        self.homeworkTitle.text = self.selectedHomework.itemType
        self.homeworkDescription.text = self.selectedHomework.itemDescription
       self.dateLabel.text = self.stringFromDate(_date: self.selectedHomework.targetDate)
        if let docName = self.selectedHomework.attachmentName {
            self.documentName.text = docName
        }
    }
}
