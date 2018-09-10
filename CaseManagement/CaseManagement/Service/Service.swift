//
//  Serivce.swift
//  CaseManagement
//
//  Created by Farhad Faramarzi on 9/9/18.
//  Copyright © 2018 Golrangsys. All rights reserved.
//

import UIKit

public protocol CaseManagementProtocol {
    func save()
    func getCaseItems(callBack: @escaping (([CaseItem]) -> ()))
    func getCases(callBack: @escaping (([CaseIssue]) -> ()))
    
    // show data into the custom cell
    func register(table: UITableView)
    func getIssueCell(table: UITableView, index: IndexPath, item: CaseIssue) -> UITableViewCell
}
