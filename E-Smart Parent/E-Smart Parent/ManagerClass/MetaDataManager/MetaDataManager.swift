//
//  MetaDataManager.swift
//  SchoolApp
//
//  Created by Pradeep A C on 21/10/16.
//  Copyright © 2016 Pradeep A C. All rights reserved.
//

import Foundation

class MetaDataManager: NSObject {
    var  plistPath = ""
    var mainDict : [String: AnyObject] = [:]
    override init() {
            super.init()
    }
    
    func getDashboardItems() -> NSArray{
        var propertyListFormat = PropertyListSerialization.PropertyListFormat.xml
        plistPath = Bundle.main.path(forResource:"AppMetaData", ofType: "plist")!
        let plistXml = FileManager.default.contents(atPath: plistPath)!
        do{
            mainDict = try PropertyListSerialization.propertyList(from: plistXml, options: .mutableContainersAndLeaves, format: &propertyListFormat) as! [String : AnyObject]
        }
        catch{
            print("Error reading plist:\(error), format :\(propertyListFormat)")
        }
        return mainDict["dashboardItems"] as! NSArray
    }
    
    func getOptionsItems() -> NSArray{
        var propertyListFormat = PropertyListSerialization.PropertyListFormat.xml
        plistPath = Bundle.main.path(forResource:"AppMetaData", ofType: "plist")!
        let plistXml = FileManager.default.contents(atPath: plistPath)!
        do{
            mainDict = try PropertyListSerialization.propertyList(from: plistXml, options: .mutableContainersAndLeaves, format: &propertyListFormat) as! [String : AnyObject]
        }
        catch{
            print("Error reading plist:\(error), format :\(propertyListFormat)")
        }
        return mainDict["optionsArray"] as! NSArray
    }
    
    
}
