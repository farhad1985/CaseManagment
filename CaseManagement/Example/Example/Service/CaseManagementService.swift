//
//  CaseManagementService.swift
//  ICRM-Customer
//
//  Created by Farhad on 5/11/17.
//  Copyright © 2017 Farhad. All rights reserved.
//

import Alamofire
import AlamofireObjectMapper

struct CaseCustomer {
    var primaryMobile: String!
    var joinVentureId: String!
    var issueTitle: String!
    var caseTypeCode: Int!
    var issueDescription: String!
    var fileByte:String?
}


struct CaseManagementService {
    private let token = "37456D20-10EB-E711" //"iiii-cccc-rrrrrrrr-mmmm"
    private let subSystem = 1 //20
    private let version = 0
    private let deviceType = 10 //2
    
    static let shared = CaseManagementService()
    
    private init() {}
    
    func getCreateCase(caseCustomer: CaseCustomer, callBack: @escaping (Result<MessageSerivce>) -> Void) {
        var params: Parameters = [
            "PrimaryMobile": caseCustomer.primaryMobile,
            "JoinVentureId": caseCustomer.joinVentureId,
            "IssueTittle": caseCustomer.issueTitle,
            "CaseTypeCode": caseCustomer.caseTypeCode,
            "IssueDescription": caseCustomer.issueDescription,
            "Token": token,
            "SubSystem": subSystem,
            "Version": version,
            "DeviceType": deviceType
        ]
        
        if let fileByte = caseCustomer.fileByte {
            
            if !fileByte.isEmpty {
                params["FileByte"] = fileByte
                params["FileName"] = "filename.png"
            }
        }
        
        Alamofire.request(Route.issueCreateCase.url(), method: .post, parameters: params, encoding: JSONEncoding.default).responseObject { (response: DataResponse<MessageSerivce>) in
            switch response.result {
            case .success(let value):
                callBack(Result.success(value))
                
            case .failure(let error):
                callBack(Result.failure(error))
            }
        }
    }
    
    func getCaseType(callBack: @escaping (Result<IssueGetCaseType>) -> Void) {
        let params: Parameters = [
            "Token": token,
            "SubSystem": subSystem,
            "Version": version,
            "DeviceType": deviceType
        ]
        
        Alamofire.request(Route.issueGetCaseType.url(), method: .post, parameters: params).responseObject { (response: DataResponse<IssueGetCaseType>) in
            
            switch response.result {
            case .success(let value):
                callBack(Result.success(value))
                
            case .failure(let error):
                callBack(Result.failure(error))
            }
        }
    }
    
    func getCaseList(primaryMobile: String,
                     issueGuid: String? = nil,
                     fromDate: String? = nil,
                     toDate: String? = nil,
                     caseTypeCode: Int? = nil,
                     isAnswered: Bool? = nil,
                     trackingCode:String? = nil,
                     jvCode:String? = nil,
                     callBack: @escaping (Result<Issue>) -> Void) {
        
        var params: Parameters = [
            "PrimaryMobile": primaryMobile,
            "Token": token,
            "SubSystem": subSystem,
            "Version": version,
            "DeviceType": deviceType,
        ]
        
        if let caseTypeCode = caseTypeCode {
            params["CaseTypeCode"] = caseTypeCode
        }
        
        if let fromDate = fromDate {
            params["FromDate"] = fromDate
        }
        
        if let toDate = toDate {
            params["ToDate"] = toDate
        }
        
        if let isAnswered = isAnswered {
            params["IsAnswered"] = "\(isAnswered)"
        }
        
        if let trackingCode = trackingCode {
            params["IssueCode"] = trackingCode
        }
        
        if let jvCode = jvCode {
            params["JoinVentureId"] = jvCode
        }
        
        print("params :: \(params)")
        
        Alamofire.request(Route.issueUserGetCaseList.url(), method: .post, parameters: params).responseObject { (response: DataResponse<Issue>) in
            
            switch response.result {
            case .success(let value):
                callBack(Result.success(value))
                
            case .failure(let error):
                callBack(Result.failure(error))
            }
        }
    }
    
    func issueCaseReply(issueGuid: String,
                        issuReply: String,
                        callBack: @escaping (Result<MessageSerivce>) -> Void) {
        let params: Parameters = [
            "IssueGuid": issueGuid,
            "IssuReply": issuReply,
            "Token": token,
            "SubSystem": subSystem,
            "Version": version,
            "DeviceType": deviceType
        ]
        
        Alamofire.request(Route.issueCaseReply.url(), method: .post, parameters: params).responseObject { (response: DataResponse<MessageSerivce>) in
            
            switch response.result {
            case .success(let value):
                callBack(Result.success(value))
                
            case .failure(let error):
                callBack(Result.failure(error))
            }
        }
    }
}







