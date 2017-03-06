//
//  CircularFeatureViewController.swift
//  E-Smart Parent
//
//  Created by Pradeep A C on 14/01/17.
//  Copyright © 2017 Pradeep A C. All rights reserved.
//

import Foundation
import UIKit

class CircularFeatureViewController: UIViewController {
    
    var circularsArray : Array<CircularDetails> = [CircularDetails]()
    var circularDetail : CircularDetails = CircularDetails()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backBarButtonItem?.title = ""
        self.navigationItem.title = "Circulars"

        
    }
    
    func stringFromDate(_date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let stringDate = dateFormatter.string(from: _date)
        
        return stringDate
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "circularDetails" {
            let circularDetailsVC:CircularDetailsViewcontroller = segue.destination as! CircularDetailsViewcontroller
            
            circularDetailsVC.selectedCircular = self.circularDetail
            
        }
        
    }

}
extension CircularFeatureViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return circularsArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let circularCell = tableView.dequeueReusableCell(withIdentifier: "CircularCell") as! CircularTableviewCell
        circularCell.circularName.text = "Circular"
        circularCell.dateLabel.text = self.stringFromDate(_date: circularsArray[indexPath.section].targetDate)
        circularCell.circularDescription.text = circularsArray[indexPath.section].itemDescription
        return circularCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }


}

extension CircularFeatureViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.circularDetail = self.circularsArray[indexPath.section]
        self.performSegue(withIdentifier: "circularDetails", sender: self)
        
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView()
        header.backgroundColor = UIColor.clear
        return header
    }
    


}
