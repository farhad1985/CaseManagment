//
//  Issue.swift
//  ICRM-Customer
//
//  Created by Farhad on 5/18/17.
//  Copyright © 2017 Farhad. All rights reserved.
//

import ObjectMapper

struct Issue: Mappable {
    
    private(set)var success = false
    private(set)var message: String!
    private(set)var issue: [IssueList]!

    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        self.success <- map["Success"]
        self.message <- map["Message"]
        self.issue <- map["Data.Issue"]
    }
    
}

struct IssueList: Mappable {
    private(set)var issueGuid: String?
    private(set)var issueTittle: String?
    private(set)var issueCode: String?
    private(set)var issueStatusCode: String?
    private(set)var issueStatusName: String?
    private(set)var issueDate: String?
    private(set)var issueCaseTypeCode: Int?
    private(set)var issueCaseTypeName: String?
    private(set)var issueDescription: String?
    private(set)var parentGuid: String?
    private(set)var issueReply: String?
    private(set)var issueReplayDate: String?
    private(set)var fullName: String?
    private(set)var contactId: String?
    private(set)var fileList: [FileInfo]!
    private(set)var joinVentureName: String?

    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        self.issueGuid <- map["IssueGuid"]
        self.issueTittle <- map["IssueTittle"]
        self.issueCode <- map["IssueCode"]
        self.issueStatusCode <- map["IssueStatuesCode"]
        self.issueStatusName <- map["IssueStatuesName"]
        self.issueDate <- map["IssueDate"]
        self.issueCaseTypeCode <- map["IssueCaseTypeCode"]
        self.issueCaseTypeName <- map["IssueCaseTypeName"]
        self.issueDescription <- map["IssueDescription"]
        self.parentGuid <- map["ParentGuid"]
        self.issueReply <- map["IsssueReply"]
        self.issueReplayDate <- map["IsssueReplyDate"]
        self.fullName <- map["FullName"]
        self.contactId <- map["ContactId"]
        self.fileList <- map["FileList"]
        self.joinVentureName <- map["JoinVentureName"]
    }
}







