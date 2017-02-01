//
//  jsonString.swift
//  E-Smart Parent
//
//  Created by Pradeep A C on 16/01/17.
//  Copyright © 2017 Pradeep A C. All rights reserved.
//

import Foundation

class AdditionalDetails {

    var admissionNumber: String!
    var admissionDate: String!
    var firstName: String!
    var middleName: String!
    var lastName: String!
    var motherName: String!
    var fatherOccupation: String!
    var fatherSalary: String!
    var gender: String!
    var city: String!
    var bloodGroup: String!
    var birthPlace: String!
    var motherTounge: String!
    
    init?(jsonString:Dictionary<String, Any>) {
        
            if let admissionNo = jsonString["admissionNumber"] as? String {
                self.admissionNumber = admissionNo
            }else{
                self.admissionNumber = ""
            }
            if let admissiondate = jsonString["admissionDate"] as? String {
                self.admissionDate = admissiondate
            }else{
                self.admissionDate = ""
            }
            if let fName = jsonString["firstName"] as? String {
                self.firstName = fName
            }else{
                self.firstName = ""
            }
            if let mName = jsonString["middleName"] as? String {
                self.middleName = mName
            }else{
                self.middleName = ""
            }
            if let lName = jsonString["lastName"] as? String {
                self.lastName = lName
            }else{
                self.lastName = ""
            }
            if let mothername = jsonString["motherName"] as? String {
                self.motherName = mothername
            }else{
                self.motherName = ""
            }
            if let fOccupation = jsonString["fatherOccupation"] as? String {
                self.fatherOccupation = fOccupation
            }else{
                self.fatherOccupation = ""
            }
            if let fSalary = jsonString["fatherSalary"] as? String {
                self.fatherSalary = fSalary
            }else{
                self.fatherSalary = ""
            }
            if let gen = jsonString["gender"] as? String {
                self.gender = gen
            }else{
                self.gender = ""
            }
            if let cityString = jsonString["city"] as? String {
                self.city = cityString
            }else{
                self.city = ""
            }
            if let bGroup = jsonString["bloodGroup"] as? String {
                self.bloodGroup = bGroup
            }else{
                self.bloodGroup = ""
            }
            if let bPlace = jsonString["birthPlace"] as? String {
                self.birthPlace = bPlace
            }else{
                self.birthPlace = ""
            }
            if let mTounge = jsonString["motherTongue"] as? String {
                self.motherTounge = mTounge
            }else{
                self.motherTounge = ""
            }
        
        
    }
}
