//
//  CaseRequest.swift
//  CaseManagement
//
//  Created by Farhad Faramarzi on 9/3/18.
//  Copyright © 2018 Golrangsys. All rights reserved.
//

import Foundation

public struct CaseRequest {
    
    var id: Int
    var title: String
    var partsCast: [CaseRequest] = []
    var caseItems:  [Case] = []
    
    public init(id: Int, title: String, partsCast: [CaseRequest]) {
        self.id = id
        self.title = title
        self.partsCast = partsCast
    }
    
    public init(id: Int, title: String) {
        self.id = id
        self.title = title
    }
}
