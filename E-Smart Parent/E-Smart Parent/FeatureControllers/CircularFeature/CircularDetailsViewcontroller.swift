//
//  CircularDetailsViewcontroller.swift
//  E-Smart Parent
//
//  Created by Pradeep A C on 15/01/17.
//  Copyright © 2017 Pradeep A C. All rights reserved.
//

import Foundation
import UIKit

class CircularDetailsViewcontroller: UIViewController {
    var selectedCircular : CircularDetails = CircularDetails()
   
    @IBOutlet weak var documentName: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var circularDescription: UILabel!
    @IBOutlet weak var circularTitle: UILabel!
     @IBOutlet weak var attachmentButton: UIButton!

    @IBAction func attachmentButtonTapped(_ sender: Any) {
    }
    
    func stringFromDate(_date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let stringDate = dateFormatter.string(from: _date)
        
        return stringDate
    }
    override func viewDidLoad() {
        self.navigationItem.backBarButtonItem?.title = ""
        self.navigationItem.title = "Circular Details"
        attachmentButton.setImage(UIImage.fontAwesomeIcon(name: String.fontAwesome(code: "fa-download")!, textColor: UIColor.white  , size: CGSize(width: 20, height: 20)), for: .normal)
        self.circularTitle.text = self.selectedCircular.itemName
        self.circularDescription.text = self.selectedCircular.itemDescription
        self.dateLabel.text = self.stringFromDate(_date: self.selectedCircular.targetDate)
        if let docName = self.selectedCircular.attachmentName {
            self.documentName.text = docName
        }
        
    }
}
