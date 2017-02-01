//
//  HomeworkFeatureViewcontroller.swift
//  E-Smart Parent
//
//  Created by Pradeep A C on 15/01/17.
//  Copyright © 2017 Pradeep A C. All rights reserved.
//

import Foundation
import UIKit

class HomeworkFeatureViewController: UIViewController {
    
    var homeworksArray : Array<HomeworkDetails> = [HomeworkDetails]()
    var homeworkDetail : HomeworkDetails = HomeworkDetails()
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func stringFromDate(_date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let stringDate = dateFormatter.string(from: _date)
        
        return stringDate
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "homeworkDetails" {
            let circularDetailsVC:HomeworkDetailsViewcontroller = segue.destination as! HomeworkDetailsViewcontroller
            
            circularDetailsVC.selectedHomework = self.homeworkDetail
            
        }
        
    }
    
}
extension HomeworkFeatureViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return homeworksArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let homeworkCell = tableView.dequeueReusableCell(withIdentifier: "CircularCell") as! HomeworkTableviewCell
        homeworkCell.subjectTitle.text = homeworksArray[indexPath.section].subjectID
        homeworkCell.dateLabel.text = self.stringFromDate(_date: homeworksArray[indexPath.section].targetDate)
         homeworkCell.homeworkTitle.text = homeworksArray[indexPath.section].itemType
        homeworkCell.homeworkDescription.text = homeworksArray[indexPath.section].itemDescription
        return homeworkCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 103
    }
    
    
}

extension HomeworkFeatureViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.homeworkDetail = self.homeworksArray[indexPath.section]
        self.performSegue(withIdentifier: "homeworkDetails", sender: self)
        
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
