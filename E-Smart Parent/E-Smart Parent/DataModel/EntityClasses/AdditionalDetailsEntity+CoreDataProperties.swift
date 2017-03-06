//
//  AdditionalDetailsEntity+CoreDataProperties.swift
//  E-Smart Parent
//
//  Created by Pradeep A C on 01/03/17.
//  Copyright © 2017 Pradeep A C. All rights reserved.
//

import Foundation
import CoreData


extension AdditionalDetailsEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AdditionalDetailsEntity> {
        return NSFetchRequest<AdditionalDetailsEntity>(entityName: "AdditionalDetailsEntity");
    }

    @NSManaged public var admissionNumber: String?
    @NSManaged public var admissionDate: String?
    @NSManaged public var firstName: String?
    @NSManaged public var middleName: String?
    @NSManaged public var lastName: String?
    @NSManaged public var motherName: String?
    @NSManaged public var fatherOccupation: String?
    @NSManaged public var fatherSalary: String?
    @NSManaged public var gender: String?
    @NSManaged public var city: String?
    @NSManaged public var bloodGroup: String?
    @NSManaged public var birthPlace: String?
    @NSManaged public var motherTounge: String?
    @NSManaged public var loginDetails: LoginDetailsEntity?

}
