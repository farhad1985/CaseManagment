//
//  BaseResponse.swift
//  ICRM-Customer
//
//  Created by Mojgan Jelodar on 5/21/17.
//  Copyright © 2017 Farhad. All rights reserved.
//

import ObjectMapper


class BaseResponse: Mappable {
    
    var success: Bool!
    var message: String!
    var errorCode: Int!
    
    required init?(map: Map) {}
    
    init() {}
    
    func mapping(map: Map) {
        self.success <- map["success"]
        self.message <- map["message"]
        self.errorCode <- map["errorCode"]
    }
}

class PrimitiveResponse<T: Mappable>: BaseResponse {
    
    var data: T?
    
    override init() {
        super.init()
    }
    
    init(data: T) {
        super.init()
        self.data = data
    }
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        self.data <- map["data"]
    }
}


class PrimitiveObjectResponse<T>: BaseResponse {
    
    var data: T?
    
    override init() {
        super.init()
    }
    
    init(data: T) {
        super.init()
        self.data = data
    }
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        self.data <- map["data"]
    }
}

class ArrayObjectResponse<T:Mappable> : BaseResponse {
    private(set) var data : [T]?
    private(set) var currentPageNumber:Int?
    private(set) var pageSize:Int?
    private(set) var totalRecords:Int?
    
    override func mapping(map: Map)
    {
        super.mapping(map: map)
        self.data <- map["data"]
        self.currentPageNumber <- map["data.currentPageNumber"]
        self.pageSize <- map["data.pageSize"]
        self.totalRecords <- map["data.toatlRecords"]
    }
}

class ArrayResponse<T:Mappable> : BaseResponse {
    private(set) var data : [T]?
    
    override func mapping(map: Map)
    {
        super.mapping(map: map)
        self.data <- map["data"]
    }
}

class ObjectResponse<T:Mappable> : BaseResponse {
    private(set) var data : T?
    
    override func mapping(map: Map)
    {
        super.mapping(map: map)
        self.data <- map["data"]
    }
}


class ArrayPirimitiveResponse : BaseResponse
{
    private(set) var data : [String]?
    
    override func mapping(map: Map)
    {
        super.mapping(map: map)
        self.data <- map["data"]
    }
}

class ObjectArrayResponse<T:Mappable> : BaseResponse {
    private(set) var data : [T]?
    private(set) var currentPageNumber:Int?
    private(set) var pageSize:Int?
    private(set) var totalRecords:Int?
    
    override func mapping(map: Map)
    {
        super.mapping(map: map)
        self.data <- map["data.items"]
        self.currentPageNumber <- map["data.currentPageNumber"]
        self.pageSize <- map["data.pageSize"]
        self.totalRecords <- map["data.toatlRecords"]
    }
}

