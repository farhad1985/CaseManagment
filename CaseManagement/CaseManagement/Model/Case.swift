//
//  Case.swift
//  CaseManagement
//
//  Created by Amir Ardalan on 9/4/18.
//  Copyright © 2018 Golrangsys. All rights reserved.
//

import Foundation
struct CaseFileType
{
    
    private(set) var type : String?
    private(set) var url : String?
    
}

struct Case
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
    private(set) var requestDateTime : String!
    private(set) var response : String?
    private(set) var description : String?
    private(set) var caseFiles : [CaseFileType]?
    private(set) var responseDate : String?
    
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
    
//    init?(map: Map) {}
//
//
//    mutating func mapping(map: Map)
//    {
//        self.trackingCode <- map["trackingCode"]
//        self.requestDateTime <- (map["requestDateTimeEpoth"],DateTimeTransform())
//        self.caseTypeCode <- map["caseTypeCode"]
//        self.caseTypeCaption <- map["caseTypeCaption"]
//        self.requestCategoryCode <- map["requestCategoryCode"]
//        self.requestCategoryName <- map["requestCategoryName"]
//        self.compliantReasonCode <- map["compliantReasonCode"]
//        self.compliantReasonName <- map["compliantReasonName"]
//        self.suggestionReasonCode <- map["suggestionReasonCode"]
//        self.suggestionReasonName <- map["suggestionReasonName"]
//        self.secondRequestTypeCode <- map["secondRequestTypeCode"]
//        self.secondRequestTypeName <- map["secondRequestTypeName"]
//        self.statusCode <- map["statusCode"]
//        self.statusName <- map["statusName"]
//        self.response <- map["response"]
//        self.description <- map["description"]
//        self.caseFiles <- map["caseFiles"]
//        self.responseDate <- (map["responseDateTimeEpoth"],DateTimeTransform())
//    }
//
//    func getImageFile() -> CaseFileType? {
//        let extensions = ["png","jpeg","jpg","tiff"]
//        if let caseFiles = self.caseFiles,let caseType = caseFiles.filter({ extensions.contains($0.type?.lowercased() ?? "")}).first
//        {
//            return caseType
//        }
//        return nil
//    }
//
//    func getAudioFile() -> CaseFileType? {
//        let extensions = ["mp4","mp3","m4a","caf","wav","aac", "adts","ac3","aif","aiff","aifc","aiff","snd","au","sd2","wav"]
//        if let caseFiles = self.caseFiles,let caseType = caseFiles.filter({ extensions.contains($0.type?.lowercased() ?? "")}).first
//        {
//            return caseType
//        }
//        return nil
//    }
    
}
