//
//  Serivce.swift
//  CaseManagement
//
//  Created by Farhad Faramarzi on 9/9/18.
//  Copyright © 2018 Golrangsys. All rights reserved.
//

import Foundation

public protocol CaseManagementProtocol {
    func save()
    func getCaseItems() -> [CaseItem]
//    func getCases() -> [CaseItem]
}
