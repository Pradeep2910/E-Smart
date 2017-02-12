//
//  TimeTableFeature.swift
//  E-Smart Parent
//
//  Created by Pradeep A C on 11/02/17.
//  Copyright © 2017 Pradeep A C. All rights reserved.
//

import Foundation
import UIKit
class TimeTableFeature: UIViewController {
    var dayDomainArray = [DayDomain]()
     @IBOutlet var timeTableCollectionview : UICollectionView?
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.view.layoutIfNeeded()
        self.view.layoutSubviews()
        guard let flowLayout = self.timeTableCollectionview?.collectionViewLayout as? UICollectionViewFlowLayout else {
            return
        }
        flowLayout.invalidateLayout()
    }

}

extension TimeTableFeature : UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        let dayDomain = dayDomainArray.first
        if let count = dayDomain?.periodsArray.count {
            return count + 1
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dayDomainArray.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let index = indexPath.row == 0 ? indexPath.row : indexPath.row - 1
            let dayDomain = dayDomainArray[index]
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "headerCollectionCell", for: indexPath) as? TimeTableHeaderCollectionCell
            cell?.loadData(dayDomain: dayDomain, indexPath: indexPath)
            cell?.layer.borderColor = UIColor.black.cgColor
            cell?.layer.borderWidth = 1.0
            return cell!
        }
        else if indexPath.row == 0 && indexPath.section >= 1{
            let dayDomain = dayDomainArray[indexPath.row]
            let periodDomain = dayDomain.periodsArray[indexPath.section - 1]
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "periodCollectionCell", for: indexPath) as? PeriodTitleCollectionCell
            cell?.loadData(periodDomain: periodDomain)
            cell?.layer.borderColor = UIColor.black.cgColor
            cell?.layer.borderWidth = 1.0
            
            return cell!
        }

        else {
            let dayDomain = dayDomainArray[indexPath.row - 1]
            let periodDomain = dayDomain.periodsArray[indexPath.section - 1]
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "subjectCollectionCell", for: indexPath) as? SubjectCollectionCell
            cell?.loadData(periodDomain: periodDomain)
            cell?.layer.borderColor = UIColor.black.cgColor
            cell?.layer.borderWidth = 1.0
            return cell!
        }

    }
}

extension TimeTableFeature : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfCell : CGFloat = CGFloat(dayDomainArray.count + 1)
        let cellWidth = UIScreen.main.bounds.size.width / numberOfCell
        
        if indexPath.section == 0 {
            return CGSize(width: cellWidth, height: 30.0)
        }
        else{
            return CGSize(width: cellWidth, height: 75.0)
        }
    }
}
