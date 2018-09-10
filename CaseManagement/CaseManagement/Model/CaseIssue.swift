//
//  Issue.swift
//  ICRM-Customer
//
//  Created by Farhad on 5/18/17.
//  Copyright © 2017 Farhad. All rights reserved.
//

import Foundation

public class CaseIssue {
    public var issueGuid: String?
    public var issueTittle: String?
    public var issueCode: String?
    public var issueStatusCode: String?
    public var issueStatusName: String?
    public var issueDate: String?
    public var issueCaseTypeCode: Int?
    public var issueCaseTypeName: String?
    public var issueDescription: String?
    public var parentGuid: String?
    public var issueReply: String?
    public var issueReplayDate: String?
    public var fullName: String?
    public var contactId: String?
    public var fileList: [CaseFileInfo]!
    public var joinVentureName: String?
    
    public init() {}
}







