//
//  ForgotPasswordStep2.swift
//  ICRM-JV-Operator
//
//  Created by Farhad on 5/18/17.
//  Copyright © 2017 Shervin. All rights reserved.
//

import ObjectMapper

struct MessageSerivce: Mappable
{
    
    private(set)var success = false
    private(set)var message: String!
    private(set)var internalMessage : String?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        self.success <- map["Success"]
        self.message <- map["Message"]
        self.internalMessage <- map["Data.InternalMessage"]
    }
    
}
