//
//  CaseService.swift
//  Example
//
//  Created by Farhad Faramarzi on 9/10/18.
//  Copyright © 2018 Golrangsys. All rights reserved.
//

import CaseManagement

class CaseService: CaseManagementProtocol {

    func register(table: UITableView) {
        let nib = UINib(nibName: "CaseCell", bundle: nil)
        table.register(nib, forCellReuseIdentifier: "CaseCell")
    }
    
    func getIssueCell(table: UITableView, index: IndexPath, item: CaseIssue) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "CaseCell", for: index) as! CaseCell
        cell.configCell(caseIssue: item)
        return cell
    }
    
    func getCases(callBack: @escaping (([CaseIssue]) -> ())) {
        CaseManagementService.shared.getCaseList(primaryMobile: "09124141680") { (result) in
            switch result {
            case .success(let value):
                let castList = value.issue.map({ (issue) -> CaseIssue in
                    let caseItem = CaseIssue()
                    caseItem.contactId = issue.contactId
                    caseItem.fullName = issue.fullName
                    caseItem.issueCaseTypeCode = issue.issueCaseTypeCode
                    caseItem.issueCaseTypeName = issue.issueCaseTypeName
                    caseItem.issueCode = issue.issueCode
                    caseItem.issueDate = issue.issueDate
                    caseItem.issueDescription = issue.issueDescription
                    caseItem.issueGuid = issue.issueGuid
                    caseItem.issueReplayDate = issue.issueReplayDate
                    caseItem.issueReply = issue.issueReply
                    caseItem.issueStatusCode = issue.issueStatusCode
                    caseItem.issueStatusName = issue.issueStatusName
                    caseItem.issueTittle = issue.issueTittle
                    caseItem.joinVentureName = issue.joinVentureName
                    caseItem.parentGuid = issue.parentGuid
                    return caseItem
                })
                callBack(castList)
            case .failure:
                callBack([])
            }
        }
    }
    
    func getCaseItems(callBack: @escaping (([CaseItem]) -> ())) {
        CaseManagementService.shared.getCaseType { (result) in
            switch result {
            case .success(let value):
                let items = value.caseTypeCodeInfo.map({ (item) -> CaseItem in
                    let a = CaseItem(id: Int(item.caseTypeCode)!, title: item.caseTypeName)
                    return CaseItem(id: Int(item.caseTypeCode)!, title: item.caseTypeName, partsCast: [a, a])
                })
                callBack(items)
            case .failure:
                callBack([])
            }
        }
    }
    
    func save() {
        
    }
    
}
