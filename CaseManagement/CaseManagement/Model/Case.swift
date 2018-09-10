//
//  Case.swift
//  CaseManagement
//
//  Created by Amir Ardalan on 9/4/18.
//  Copyright © 2018 Golrangsys. All rights reserved.
//

import Foundation

public class CaseFileType {
    
    var type : String?
    var url : String?
    
    public init() {}
    
}

public class Case {
    public var trackingCode : String!
    public var caseTypeCode : UInt!
    public var caseTypeCaption : String!
    public var requestCategoryCode : String?
    public var requestCategoryName : String?
    public var compliantReasonCode : String?
    public var compliantReasonName :String?
    public var suggestionReasonCode : String?
    public var suggestionReasonName :String?
    public var secondRequestTypeCode : String?
    public var secondRequestTypeName :String?
    public var statusCode : UInt!
    public var statusName : String!
    public var requestDateTime : String!
    public var response : String?
    public var description : String?
    public var caseFiles : [CaseFileType]?
    public var responseDate : String?
    
    public init() {}
    
    public func getImageFile() -> CaseFileType? {
        let extensions = ["png","jpeg","jpg","tiff"]
        if let caseFiles = self.caseFiles,let caseType = caseFiles.filter({ extensions.contains($0.type?.lowercased() ?? "")}).first
        {
            return caseType
        }
        return nil
    }
    
    public func getAudioFile() -> CaseFileType? {
        let extensions = ["mp4","mp3","m4a","caf","wav","aac", "adts","ac3","aif","aiff","aifc","aiff","snd","au","sd2","wav"]
        if let caseFiles = self.caseFiles,let caseType = caseFiles.filter({ extensions.contains($0.type?.lowercased() ?? "")}).first
        {
            return caseType
        }
        return nil
    }
}
