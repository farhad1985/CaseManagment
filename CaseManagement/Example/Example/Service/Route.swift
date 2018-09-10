//
//  Route.swift
//  ICRM-Customer
//
//  Created by Farhad on 4/30/17.
//  Copyright © 2017 Farhad. All rights reserved.
//

import Foundation

enum BaseURL: String {
    case okcrm = "https://okcrm-service.gig.services"
}

enum Route: String {

    // MARK: - CaseManagement
    
    case issueCreateCase = "/CaseManagement/IssueCreateCase"
    case issueGetCaseType = "/CaseManagement/IssueGetCaseType"
    case issueUserGetCaseList = "/CaseManagement/IssueUserGetCaseList"
    case issueCaseReply = "/CaseManagement/IssueCaseReply"
}

extension Route {
    
    func url() -> String {
        var baseUrl = ""
        
        switch self {
        default:
            baseUrl = BaseURL.okcrm.rawValue
        }
        
        return baseUrl + self.rawValue
    }
}






