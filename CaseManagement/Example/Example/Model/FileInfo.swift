//
//  FileInfo.swift
//  ICRM-Customer
//
//  Created by Farhad on 5/20/17.
//  Copyright © 2017 Farhad. All rights reserved.
//

import ObjectMapper

struct FileInfo: Mappable {
    
    private(set) var url: String!
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        self.url <- map["Url"]
    }
}


