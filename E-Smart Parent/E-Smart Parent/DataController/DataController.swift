//
//  DataController.swift
//  E-Smart Parent
//
//  Created by Pradeep A C on 03/03/17.
//  Copyright © 2017 Pradeep A C. All rights reserved.
//

import Foundation
import UIKit
import CoreData
class DataController: NSObject {
     let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    
    func getContext () -> NSManagedObjectContext {
        return appDelegate.persistentContainer.viewContext
    }
    
    func saveContext() {
        appDelegate.saveContext()
    }
 
    func insertLoginDetailsEnttity () -> LoginDetailsEntity{
        let context = getContext()
        
        //retrieve the entity that we just created
        let entity =  NSEntityDescription.entity(forEntityName: "LoginDetailsEntity", in: context)
        
        let loginDetailsEnity = NSManagedObject(entity: entity!, insertInto: context)
        return loginDetailsEnity as! LoginDetailsEntity
    }
    
    func getLoginDetailsEntity () -> LoginDetailsEntity?{
        //create a fetch request, telling it about the entity
        let fetchRequest: NSFetchRequest<LoginDetailsEntity> = LoginDetailsEntity.fetchRequest()
        
        do {
            //go get the results
            let searchResults = try getContext().fetch(fetchRequest)
            return searchResults.last
        
        } catch {
            print("Error with request: \(error)")
        }
        return nil
    }
    
    func insertAdditionalDetailsEnttity () -> AdditionalDetailsEntity{
        let context = getContext()
        
        //retrieve the entity that we just created
        let entity =  NSEntityDescription.entity(forEntityName: "AdditionalDetailsEntity", in: context)
        
        let additionalDetails = NSManagedObject(entity: entity!, insertInto: context)
        return additionalDetails as! AdditionalDetailsEntity
    }
    
    func getAdditionalDetailsEntity () -> AdditionalDetailsEntity?{
        //create a fetch request, telling it about the entity
        let fetchRequest: NSFetchRequest<AdditionalDetailsEntity> = AdditionalDetailsEntity.fetchRequest()
        
        do {
            //go get the results
            let searchResults = try getContext().fetch(fetchRequest)
            return searchResults.last
            
        } catch {
            print("Error with request: \(error)")
        }
        return nil
    }
}
