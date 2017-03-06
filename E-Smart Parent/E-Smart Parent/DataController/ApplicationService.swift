//
//  ApplicationService.swift
//  E-Smart Parent
//
//  Created by Pradeep A C on 03/03/17.
//  Copyright © 2017 Pradeep A C. All rights reserved.
//

import Foundation

class ApplicationService: NSObject {
    let dataController = DataController()
    
    func insertLoginDetailsToDB(){
        let loginDomain = Application.application.loginDetails
        let loginEntity = dataController.insertLoginDetailsEnttity()
        loginEntity.batchID = loginDomain.batchID
        loginEntity.classID = loginDomain.classID
        loginEntity.dateOfBirth = loginDomain.dateOfBirth
        loginEntity.feesType = loginDomain.feesType
        loginEntity.guardianName = loginDomain.guardianName
        loginEntity.schoolID = loginDomain.schoolID
        loginEntity.sectionID = loginDomain.sectionID
        loginEntity.studendID = loginDomain.studendID
        loginEntity.studentAddress = loginDomain.studentAddress
        loginEntity.studentContact = loginDomain.studentContact
        loginEntity.studentName = loginDomain.studentName
        loginEntity.isLoggedOut = loginDomain.isLoggedOut
        dataController.saveContext()
    }
    
    func insertAdditionalDetailsToDB() {
        let additionalDetailsDomain = Application.application.loginDetails.additionalDetails
        let additionalEntity = dataController.insertAdditionalDetailsEnttity()
        additionalEntity.admissionDate = additionalDetailsDomain?.admissionDate
        additionalEntity.admissionNumber = additionalDetailsDomain?.admissionNumber
        additionalEntity.birthPlace = additionalDetailsDomain?.birthPlace
        additionalEntity.bloodGroup = additionalDetailsDomain?.bloodGroup
        additionalEntity.city = additionalDetailsDomain?.city
        additionalEntity.fatherOccupation = additionalDetailsDomain?.fatherOccupation
        additionalEntity.fatherSalary = additionalDetailsDomain?.fatherSalary
        additionalEntity.firstName = additionalDetailsDomain?.firstName
        additionalEntity.gender = additionalDetailsDomain?.gender
        additionalEntity.lastName = additionalDetailsDomain?.lastName
        additionalEntity.middleName = additionalDetailsDomain?.middleName
        additionalEntity.motherName = additionalDetailsDomain?.motherName
        additionalEntity.motherTounge = additionalDetailsDomain?.motherTounge
        dataController.saveContext()
    }
    
    func getLoginDetails() -> LoginDetails? {
        let loginDetails = Application.application.loginDetails
        guard let loginEnity = dataController.getLoginDetailsEntity() else{
            return nil
        }
        
        loginDetails.batchID = loginEnity.batchID
        loginDetails.classID = loginEnity.classID
        loginDetails.dateOfBirth = loginEnity.dateOfBirth
        loginDetails.feesType = loginEnity.feesType
        loginDetails.guardianName = loginEnity.guardianName
        loginDetails.schoolID = loginEnity.schoolID
        loginDetails.sectionID = loginEnity.sectionID
        loginDetails.studendID = loginEnity.studendID
        loginDetails.studentAddress = loginEnity.studentAddress
        loginDetails.studentContact = loginEnity.studentContact
        loginDetails.studentName = loginEnity.studentName
        loginDetails.isLoggedOut = loginEnity.isLoggedOut

        return loginDetails
    }
    
    func updateLoginStatus(){
        let loginDetails = Application.application.loginDetails
        guard let loginEnity = dataController.getLoginDetailsEntity() else{
            return
        }
        loginEnity.isLoggedOut = loginDetails.isLoggedOut
        dataController.saveContext()
    }

    
    
    func updateLoginDetails(){
        let loginDetails = Application.application.loginDetails
        guard let loginEnity = dataController.getLoginDetailsEntity() else{
            return
        }
        loginEnity.batchID = loginDetails.batchID
        loginEnity.classID = loginDetails.classID
        loginEnity.dateOfBirth = loginDetails.dateOfBirth
        loginEnity.feesType = loginDetails.feesType
        loginEnity.guardianName = loginDetails.guardianName
        loginEnity.schoolID = loginDetails.schoolID
        loginEnity.sectionID = loginDetails.sectionID
        loginEnity.studendID = loginDetails.studendID
        loginEnity.studentAddress = loginDetails.studentAddress
        loginEnity.studentContact = loginDetails.studentContact
        loginEnity.studentName = loginDetails.studentName
        loginEnity.isLoggedOut = loginDetails.isLoggedOut
        dataController.saveContext()
    }
    
}
