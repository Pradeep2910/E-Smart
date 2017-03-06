//
//  LoginDetailsEntity+CoreDataProperties.swift
//  E-Smart Parent
//
//  Created by Pradeep A C on 01/03/17.
//  Copyright © 2017 Pradeep A C. All rights reserved.
//

import Foundation
import CoreData


extension LoginDetailsEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LoginDetailsEntity> {
        return NSFetchRequest<LoginDetailsEntity>(entityName: "LoginDetailsEntity");
    }

    @NSManaged public var studendID: String?
    @NSManaged public var studentName: String?
    @NSManaged public var studentAddress: String?
    @NSManaged public var guardianName: String?
    @NSManaged public var studentContact: String?
    @NSManaged public var schoolID: String?
    @NSManaged public var classID: String?
    @NSManaged public var sectionID: String?
    @NSManaged public var dateOfBirth: String?
    @NSManaged public var batchID: String?
    @NSManaged public var feesType: String?
    @NSManaged public var isLoggedOut: Bool
    @NSManaged public var additionalDetails: AdditionalDetailsEntity?

}
