//
//  ExamResultFeatureViewcontroller.swift
//  E-Smart Parent
//
//  Created by Pradeep A C on 22/01/17.
//  Copyright © 2017 Pradeep A C. All rights reserved.
//

import Foundation
import UIKit

class ExamResultFeatureViewcontroller: UIViewController {
    var examResultDict : Dictionary<String,[ExamResultDetails]>?
    var selectedCategory : [ExamResultDetails] = []
    let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)

}

extension ExamResultFeatureViewcontroller : UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let examCategoryCell = tableView.dequeueReusableCell(withIdentifier: "categoryCell")
        let lazyMapCollection = examResultDict?.keys
        examCategoryCell?.layer.borderWidth = 1.0
        examCategoryCell?.layer.borderColor = UIColor.lightGray.cgColor
        examCategoryCell?.layer.cornerRadius = 10.0
        examCategoryCell?.tintColor = UIColor.black
        let categoryArray = Array(lazyMapCollection!)
        examCategoryCell?.textLabel?.text = categoryArray[indexPath.row]
        return examCategoryCell!
    }
}

extension ExamResultFeatureViewcontroller : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let lazyMapCollection = examResultDict?.keys
        
        let categoryArray = Array(lazyMapCollection!)
        let categoryKey = categoryArray[indexPath.row]
        selectedCategory = (examResultDict?[categoryKey])!
        
        let examResultBarGraph = self.storyBoard.instantiateViewController(withIdentifier: "examResultBarGraph") as! ExamResltBarGraphController
        examResultBarGraph.examResults = self.selectedCategory
        self.navigationController?.pushViewController(examResultBarGraph, animated: true)
    }
}
