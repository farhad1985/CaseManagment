//
//  CaseService.swift
//  Example
//
//  Created by Farhad Faramarzi on 9/10/18.
//  Copyright © 2018 Golrangsys. All rights reserved.
//

import CaseManagement

class CaseService: CaseManagementProtocol {
    
    private let token = "37456D20-10EB-E711" //"iiii-cccc-rrrrrrrr-mmmm"
    private let subSystem = 1 //20
    private let version = 0
    private let deviceType = 10 //2

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
        CaseManagementService.getCases("09124141680", customerId: 10233) { (result) in
            switch result {
            case .success(let value):
                print(value)
                let castList = value.data!.map({ (issue) -> CaseIssue in
                    let caseItem = CaseIssue()
                    caseItem.issueCaseTypeCode = Int(issue.caseTypeCode)
                    caseItem.issueCaseTypeName = issue.secondRequestTypeName
                    caseItem.issueCode = String(issue.caseTypeCode)
                    caseItem.issueDate = String(describing: issue.requestDateTime!)
                    caseItem.issueDescription = issue.description
                    caseItem.issueReplayDate = String(describing: issue.responseDate ?? Date())
                    caseItem.issueStatusCode = String(issue.statusCode)
                    caseItem.issueStatusName = issue.statusName
                    return caseItem
                })
                callBack(castList)
            case .failure:
                callBack([])
            }
        }
    }
    
    func getCaseItems(callBack: @escaping (([CaseItem]) -> ())) {
        CaseManagementService.getTypes { (result) in
            switch result {
            case .success(let value):
                let items = value.data!.map({ (item) -> CaseItem in
                    return CaseItem(id: Int(item.id), title: item.name)
                })
                callBack(items)
            case .failure:
                callBack([])
            }
        }
    }
    
    func getSubCaseItems(parent caseItem: CaseItem, callBack: @escaping (([CaseItem]) -> ())) {
        CaseManagementService.getSubTypes(caseItem.id) { (result) in
            switch result {
            case .success(let value):
                let items = value.data!.map({ (item) -> CaseItem in
                    return CaseItem(id: Int(item.code), title: item.name)
                })

                callBack(items)
            case .failure(let error):
                print(error.localizedDescription)
                callBack([])
            }
        }
    }
    
    func save(caseTypeCode: Int,
              subCaseTypeCode: Int,
              issueDescription: String,
              picFileByte: String?,
              audioFileByte: String?) {
        
        let caseCustomer = NewCase(cid: 10233,
                                   typeId: caseTypeCode,
                                   subTypeId: subCaseTypeCode,
                                   message: issueDescription,
                                   imageAsBase64: picFileByte,
                                   imageFileType: nil,
                                   voiceAsBase64: audioFileByte,
                                   voiceFileType: nil,
                                   mobile: "09124141680")

        CaseManagementService.addCase(caseCustomer) { (result) in
            switch result {
            case .success(let value):
                print(value)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
