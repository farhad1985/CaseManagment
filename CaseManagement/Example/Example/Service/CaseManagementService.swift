//
//  CaseManagementService.swift
//  ICRM-Customer
//
//  Created by Farhad on 5/11/17.
//  Copyright © 2017 Farhad. All rights reserved.
//

import Alamofire
import AlamofireObjectMapper

func getToken() -> String {
    return token
}

var token  = ""

struct CaseCustomer {
    var primaryMobile: String!
    var joinVentureId: String!
    var issueTitle: String!
    var caseTypeCode: Int!
    var issueDescription: String!
    var fileByte:String?
}


struct CaseManagementService {
    static func getTypes(_ callback: @escaping (Result<ArrayResponse<CaseType>>)->Void) {
        Alamofire.request(Route.caseTypes.url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).validate().responseObject
            {
                (response:DataResponse<ArrayResponse<CaseType>>) in
                switch response.result
                {
                case .failure(let error):
                    callback(Result.failure(error))
                case .success(let value):
                    callback(Result.success(value))
                }
        }
    }
    
    
    static func getSubTypes(_ type : Int ,_ callback: @escaping (Result<ArrayResponse<SubCaseType>>)->Void)
    {
        Alamofire.request(Route.caseSubTypes.url + "/\(type)", method: .get, parameters: nil, encoding: URLEncoding.default,headers: nil).validate().responseObject
            {
                (response:DataResponse<ArrayResponse<SubCaseType>>) in
                switch response.result
                {
                case .failure(let error):
                    callback(Result.failure(error))
                case .success(let value):
                    callback(Result.success(value))
                }
        }
    }
    
    static func getCases(_ mobile : String, customerId: Int, _ callback: @escaping (Result<ObjectArrayResponse<Case>>)->Void)
    {
        var param: [String: Any]  = Param( pageNumber: 1, pageSize: 1000).toJSON()
        param["mobilePhone"] = mobile
        param["customerId"] = customerId
        Alamofire.request(Route.getCases.url, method: .post, parameters:param, encoding: JSONEncoding.default).validate().responseObject
            {
                (response:DataResponse<
                ObjectArrayResponse<Case>>) in
                switch response.result
                {
                case .failure(let error):
                    callback(Result.failure(error))
                case .success(let value):
                    callback(Result.success(value))
                }
        }
    }
    
    
    static func getCustomerCases(_ customerId : UInt64,_ callback: @escaping (Result<ObjectResponse<CaseResponse>>)->Void)
    {
        Alamofire.request(Route.getCases.url, method: .get, parameters: ["customerId" : customerId], encoding: URLEncoding.default).validate().responseObject
            {
                (response:DataResponse<ObjectResponse<CaseResponse>>) in
                switch response.result
                {
                case .failure(let error):
                    callback(Result.failure(error))
                case .success(let value):
                    callback(Result.success(value))
                }
        }
    }
    
    
    static func addCase(_ newCase : NewCase,_ callback: @escaping (Result<ArrayResponse<Case>>)->Void)
    {
        print("\(Route.createCase.url) with params :: \(String(newCase.toJSONString() ?? ""))")
        Alamofire.request(Route.createCase.url, method: .post, parameters: newCase.toJSON() , encoding: JSONEncoding.default).validate().responseObject
            {
                (response:DataResponse<ArrayResponse<Case>>) in
                switch response.result
                {
                case .failure(let error):
                    callback(Result.failure(error))
                case .success(let value):
                    callback(Result.success(value))
                }
        }
    }
    
    
    static func getToken() {
        let param: [String: Any] = ["mobilePhone": "09124141680", "appCode": 3, "deviceTypeCode": 1]
        Alamofire.request(Route.getCustomerToken.url,
                          method: .post,
                          parameters: param,
                          encoding: JSONEncoding.default)
            .responseObject { (response:DataResponse<PrimitiveObjectResponse<String>>) in
                switch response.result {
                case .failure(let error):
                    print(error.localizedDescription)
                case .success(let value):
                    print(value)
                    token = value.data ?? ""
                }
        }
    }
}
