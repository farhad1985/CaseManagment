//
//  Route.swift
//  Patoghi Driver
//
//  Created by Farhad Faramarzi on 4/29/18.
//  Copyright © 2018 Golrang. All rights reserved.
//

import Foundation

let baseUrl =  "https://gtarabar-api.gig.services"
//let baseUrl =  "https://customerapi.patoughi.com"

enum Route: String {
    
    // Case
    
    case createCase = "/C/CRM/CreateCase"
    case caseTypes = "/C/CRM/CaseTypes"
    case caseSubTypes = "/C/CRM/CaseSubTypes"
    case getCases = "/C/CRM/GetCases"
    case getCaseStatus = "/C/CRM/GetCaseStatus"
    
    // Token
    case getCustomerToken = "/General/GetCustomerToken"

    var url: String {
        return baseUrl + self.rawValue
    }
}
