//
//  CaseRequest.swift
//  CaseManagement
//
//  Created by Farhad Faramarzi on 9/3/18.
//  Copyright © 2018 Golrangsys. All rights reserved.
//

import Foundation

public struct CaseItem {
    
    public var id: Int
    public var title: String
    public var caseItems:  [Case] = []
    
    public init(id: Int, title: String) {
        self.id = id
        self.title = title
    }
}
