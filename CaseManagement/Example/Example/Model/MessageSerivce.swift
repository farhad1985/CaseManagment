//
//  CaseType.swift
//  OKala
//
//  Created by Mojgan Jelodar on 12/30/17.
//  Copyright © 2017 Mo. All rights reserved.
//

import ObjectMapper

//Mark: CaseType
struct CaseType : Mappable
{
    private(set) var id : Int!
    private(set) var name : String!
    
    init?(map: Map) {}
    
    
    mutating func mapping(map: Map)
    {
        self.id <- map["caseTypeCode"]
        self.name <- map["caseTypeName"]
    }
}
//Mark: SubCaseType
struct SubCaseType : Mappable
{
    private(set) var code : Int!
    private(set) var name : String!
    private(set) var categoryId : String!
    
    init?(map: Map) {}
    
    
    mutating func mapping(map: Map)
    {
        self.code <- (map["requestCategoryCode"] , TransformOf<Int, String>(fromJSON: { Int($0!) }, toJSON: { $0.map { String($0) } }))
        self.name <- map["requestCategoryName"]
        self.categoryId <- map["requestCategoryGuid"]
    }
}
//Mark: New Case
class NewCase : Param
{
    
    private(set) var caseTypeCode : Int!
    private(set) var caseSubTypeCode : Int?
    private(set) var message : String!
    private(set) var imageAsBase64 : String?
    private(set) var voiceAsBase64 : String?
    private(set) var caseVoice : CaseVoice?
    private(set) var caseFile : CaseFile?
    private(set) var mobilePhone : String?
    
    init( cid : Int64? = nil,
          typeId : Int,
          subTypeId : Int?,
          message : String,
          imageAsBase64 : String?,
          imageFileType : String?,
          voiceAsBase64 : String?,
          voiceFileType : String?,
          mobile : String? = nil)
    {
        super.init()
        if let id = cid {
            self.customerId = Int(id)
        }
        
        self.mobilePhone = mobile
        
        self.caseTypeCode = typeId
        self.caseSubTypeCode = subTypeId ?? 1
        self.message = message
        if  imageAsBase64 != nil {
            self.caseFile = CaseFile(fileByte: imageAsBase64!, fileExtention: imageFileType!)
        }
        if voiceAsBase64 != nil {
            self.caseVoice = CaseVoice(fileByte: voiceAsBase64!, fileExtention: voiceFileType!)
        }
    }
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    
    override func mapping(map: Map)
    {
        super.mapping(map: map)
        self.customerId <- map["customerId"]
        self.caseTypeCode <- map["caseTypeCode"]
        self.caseSubTypeCode <- map["caseSubTypeCode"]
        self.message <- map["messageDescription"]
        self.caseFile <- map["caseFile"]
        self.caseVoice <- map["caseVoice"]
        self.mobilePhone <- map["mobileNumber"]
    }
}

//Mark: Case
struct CaseFile : Mappable {
    
    private(set) var fileByte : String?
    private(set) var fileExtention : String?
    
    init(fileByte: String, fileExtention: String) {
        self.fileByte = fileByte
        self.fileExtention = fileExtention
    }
    
    init?(map: Map) {}
    mutating func mapping(map: Map) {
        self.fileByte <- map["fileByte"]
        self.fileExtention <- map["fileExtention"]
    }
}

//Mark: Case
struct CaseVoice : Mappable {
    
    private(set) var fileByte : String?
    private(set) var fileExtention : String?
    
    init(fileByte: String, fileExtention: String) {
        self.fileByte = fileByte
        self.fileExtention = fileExtention
    }
    
    init?(map: Map) {}
    mutating func mapping(map: Map) {
        self.fileByte <- map["fileByte"]
        self.fileExtention <- map["fileExtention"]
    }
}

//Mark: Case
struct CaseResponse : Mappable {
    
    private(set) var list : [Case]?
    
    init?(map: Map) {}
    mutating func mapping(map: Map)
    {
        self.list <- map["getContactCase"]
    }
}

//Mark: Case
struct CaseFileType : Mappable
{
    
    private(set) var type : String?
    private(set) var url : String?
    
    init?(map: Map) {}
    mutating func mapping(map: Map)
    {
        self.type <- map["type"]
        self.url <- map["url"]
    }
}



struct Case : Mappable
{
    private(set) var trackingCode : String!
    private(set) var caseTypeCode : UInt!
    private(set) var caseTypeCaption : String!
    private(set) var requestCategoryCode : String?
    private(set) var requestCategoryName : String?
    private(set) var compliantReasonCode : String?
    private(set) var compliantReasonName :String?
    private(set) var suggestionReasonCode : String?
    private(set) var suggestionReasonName :String?
    private(set) var secondRequestTypeCode : String?
    private(set) var secondRequestTypeName :String?
    private(set) var statusCode : UInt!
    private(set) var statusName : String!
    private(set) var requestDateTime : Date!
    private(set) var response : String?
    private(set) var description : String?
    private(set) var caseFiles : [CaseFileType]?
    private(set) var responseDate : Date?
    
    
    init?(map: Map) {}
    
    
    mutating func mapping(map: Map) {
        self.trackingCode <- map["trackingCode"]
        self.requestDateTime <- (map["requestDateTimeEpoth"], DateTimeTransform())
        self.caseTypeCode <- map["caseTypeCode"]
        self.caseTypeCaption <- map["caseTypeCaption"]
        self.requestCategoryCode <- map["requestCategoryCode"]
        self.requestCategoryName <- map["requestCategoryName"]
        self.compliantReasonCode <- map["compliantReasonCode"]
        self.compliantReasonName <- map["compliantReasonName"]
        self.suggestionReasonCode <- map["suggestionReasonCode"]
        self.suggestionReasonName <- map["suggestionReasonName"]
        self.secondRequestTypeCode <- map["secondRequestTypeCode"]
        self.secondRequestTypeName <- map["secondRequestTypeName"]
        self.statusCode <- map["statusCode"]
        self.statusName <- map["statusName"]
        self.response <- map["response"]
        self.description <- map["description"]
        self.caseFiles <- map["caseFiles"]
        self.responseDate <- (map["responseDateTimeEpoth"], DateTimeTransform())
    }
    
    func getImageFile() -> CaseFileType? {
        let extensions = ["png","jpeg","jpg","tiff"]
        if let caseFiles = self.caseFiles,let caseType = caseFiles.filter({ extensions.contains($0.type?.lowercased() ?? "")}).first
        {
            return caseType
        }
        return nil
    }
    
    func getAudioFile() -> CaseFileType? {
        let extensions = ["mp4","mp3","m4a","caf","wav","aac", "adts","ac3","aif","aiff","aifc","aiff","snd","au","sd2","wav"]
        if let caseFiles = self.caseFiles,let caseType = caseFiles.filter({ extensions.contains($0.type?.lowercased() ?? "")}).first
        {
            return caseType
        }
        return nil
    }
    
}


class Param : Mappable {
    
    var appCode              = 3 // appCode 3 is for driver and "2" is borker
    var deviceTypecode       = 1
    var token                = "1"
    var pageNumber   : Int   = 1
    var pageSize     : Int   = 2000
    var customerId   : Int?
    var cId          : Int?
    var orderId      : String?
    
    init() {
        token = getToken()
    }
    
    init(customerId cid : Int? = nil , orderId oid : String? = nil) {
        token = getToken()
        self.customerId = cid
        self.orderId = oid
    }
    
    init(customerId cid : Int? = nil , orderId oid : String, token: String) {
        self.token = getToken()
        self.customerId = cid
        self.orderId = oid
    }
    
    init(customerId : Int? = nil , pageNumber : Int , pageSize : Int = 1000) {
        token = getToken()
        self.customerId = customerId
        self.pageNumber = pageNumber
        self.pageSize = pageSize
    }
    
    /* this means driverCustomerId */
    init(customerId : Int) {
        token = getToken()
        self.customerId = customerId
    }
    
    /* this means customerID */
    init(cId : Int) {
        token = getToken()
        self.cId = cId
    }
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        appCode <- map["appCode"]
        deviceTypecode <- map["deviceTypecode"]
        token <- map["token"]
        customerId <- map["driverCustomerId"]
        cId <- map["customerId"]
        orderId <- map["orderId"]
        pageNumber <- map["pageNumber"]
        pageSize <- map["pageSize"]
    }
}


open class DateTimeTransform: TransformType {
    public typealias Object = Date
    public typealias JSON = TimeInterval
    
    public init() {}
    
    open func transformFromJSON(_ value: Any?) -> Date? {
        if let dateTimestamp = value as? TimeInterval {
            return Date(timeIntervalSince1970: dateTimestamp)
        }
        return nil;
    }
    
    open func transformToJSON(_ value: Date?) -> TimeInterval? {
        if let date = value {
            return date.timeIntervalSince1970
        }
        return nil
    }
}

