//
//  IssueGetCaseType.swift
//  ICRM-Customer
//
//  Created by Farhad on 5/18/17.
//  Copyright © 2017 Farhad. All rights reserved.
//

import ObjectMapper

struct IssueGetCaseType: Mappable {
    
    private(set)var success = false
    private(set)var message: String!
    private(set)var caseTypeCodeInfo: [CaseTypeCodeInfo]!
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        self.success <- map["Success"]
        self.message <- map["Message"]
        self.caseTypeCodeInfo <- map["Data.CaseTypeCodeInfo"]
    }
    
}

struct CaseTypeCodeInfo: Mappable {
    
    private(set)var caseTypeCode: String!
    private(set)var caseTypeName: String!
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        self.caseTypeCode <- map["CaseTypeCode"]
        self.caseTypeName <- map["CaseTypeName"]
    }
    
}
