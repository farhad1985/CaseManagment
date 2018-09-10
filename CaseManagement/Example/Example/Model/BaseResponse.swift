//
//  BaseResponse.swift
//  ICRM-Customer
//
//  Created by Mojgan Jelodar on 5/21/17.
//  Copyright © 2017 Farhad. All rights reserved.
//

import ObjectMapper

class BaseResponseBankSaman: Mappable {
    var responseCode: String!
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        self.responseCode <- map["ResponseCode"]
    }
}

class BaseResponse<T:Mappable>: Mappable
{
    var success: Bool!
    var data: T?
    var internalMessage: String!

    required init?(map: Map) {}

    func mapping(map: Map)
    {
        self.success <- map["Success"]
        self.data <- map["Data"]
        self.internalMessage <- map["Message"]
    }


}
class Response<T>: Mappable
{
    var success: Bool!
    var data: T?
    var internalMessage: String!
    
    required init?(map: Map) {}
    
    func mapping(map: Map)
    {
        self.success <- map["Success"]
        self.data <- map["Data"]
        self.internalMessage <- map["Message"]
    }
    
    
}
