//
//  Models_Anubhav.swift
//  
//
//  Created by NirajMehta on 30/03/23.
//

import Foundation
// MARK: - AnubhavSuccess
public struct AnubhavSuccess: Codable {
    
    let requestId : String?
    let metadata : SuccessMetadata?
    let institutions : [Institutions]?
    public enum CodingKeys: String, CodingKey {
        case requestId = "requestId"
        case metadata = "metadata"
        case institutions = "institutions"
    }
    
}
public struct SuccessMetadata: Codable {
    let accounts : [Accounts]?
    
    public enum CodingKeys: String, CodingKey {
        case accounts = "accounts"
    }
    
}


public struct Accounts: Codable {
    let mask : String?
    let type : String?
    let subType : String?
    let institutionId : String?
    
    public enum CodingKeys: String, CodingKey {
        
        case mask = "mask"
        case type = "type"
        case subType = "subType"
        case institutionId = "institutionId"
    }
    
    
}

public struct Institutions : Codable  {
    let fipId : String?
    let fipName : String?
    
    public enum CodingKeys: String, CodingKey {
        
        case fipId = "fipId"
        case fipName = "fipName"
    }
    
    
}

//MARK: - anubhavOPEN
public struct AnubhavOPEN: Codable {
    let requestId : String?
    let timestamp : String?
    
    public enum CodingKeys: String, CodingKey {
        
        case requestId = "requestId"
        case timestamp = "timestamp"
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        requestId = try values.decodeIfPresent(String.self, forKey: .requestId)
        timestamp = try values.decodeIfPresent(String.self, forKey: .timestamp)
    }
    
}
public struct metadata: Codable {
    let institutions : [Institutions]?
    let status : String?
    
    
    public enum CodingKeys: String, CodingKey {
        case institutions = "institutions"
        case status = "status"
    }
    
}


public struct AnubhavError: Codable {
    let errorCode : String?
    let errorType : String?
    let errorMessage : String?
    let displayMessage : String?
    
    public enum CodingKeys: String, CodingKey {
        case errorCode = "errorCode"
        case errorType = "errorType"
        case errorMessage = "errorMessage"
        case displayMessage = "displayMessage"
    }
    
}

public struct Eventmetadata: Codable {
    let timestamp: String?
    let metadataJson: String?
    let errorCode : String?
    let errorType : String?
    let errorMessage : String?
    
    public enum CodingKeys: String, CodingKey {
        case timestamp = "timestamp"
        case metadataJson = "metadataJson"
        case errorCode = "errorCode"
        case errorType = "errorType"
        case errorMessage = "errorMessage"
    }
}
public struct AnubhavEvent: Codable {
    let name : String?
    let requestId : String?
    let metadata : Eventmetadata?
    
    public enum CodingKeys: String, CodingKey {
        case name = "name"
        case requestId = "requestId"
        case metadata = "metadata"
    }
}

//MARK: - anubhavExit
public struct AnubhavExit: Codable {
    let requestId : String?
    let error : AnubhavError?
    let metadata : metadata?
    
    public enum CodingKeys: String, CodingKey {
        case requestId = "requestId"
        case metadata = "metadata"
        case error = "error"
        
    }
    
}

//MARK: - Auth Request Model
public struct Auth : Codable {
    let authtoken: String?
    public enum CodingKeys: String, CodingKey {
        case authtoken = "auth"
    }
    public init(authtoken:String?){
        self.authtoken = authtoken
    }
}
//MARK: - Backend Request Model
public struct AnubhavBackend : Codable {
    let requestID: String?
    let redirectURL: String?
    
    public enum CodingKeys: String, CodingKey {
        case requestID = "requestId"
        case redirectURL = "redirectUrl"
    }
    public init(requestID:String?,redirectURL:String?){
        self.requestID = requestID
        self.redirectURL = redirectURL
    }
    
}

public class AnubhavConfigurationBackend {
    public init() {}
    public private(set) var requestID: String = ""
    public private(set) var redirectURL: String = ""
    public private(set) var auth: Auth?
    public func withWebViewUrl(_ URL: String) {
        self.redirectURL = URL
    }
    public func requestId(_ ID: String) {
        self.requestID = ID
    }
    public func auth(_ auth: Auth) {
        self.auth = auth
    }
    public func authparm() -> Auth {
        return auth ?? Auth(authtoken: "")
    }
    public func build() -> AnubhavBackend {
        return AnubhavBackend(requestID: requestID, redirectURL: redirectURL)
    }
}


//MARK: - RedirectURL Response Model
public struct AnubhavRedirectURL: Codable {
    let consentHandle : String?
    let redirectUrl : String?
    let webviewBaseUrl : String?
    
    enum CodingKeys: String, CodingKey {
        case consentHandle = "consentHandle"
        case redirectUrl = "redirectUrl"
        case webviewBaseUrl = "webviewBaseUrl"
    }
    
}

//MARK: - RedirectURL Request Model
final public class AnubhavConfigurationSDK {
    public init() {}
    public private(set) var customerMobileNumber: String = ""
    public private(set) var consentTemplateId: String = ""
    public private(set) var customerAAId: String = ""
    public private(set) var webhook: Webhook?
    public private(set) var rules: [String]? = nil
    public private(set) var accountFilters: [String]? = nil
    public private(set) var auth: Auth?
    public func withMobileNumber(_ number: String) {
        self.customerMobileNumber = number
    }
    public func consentTemplate(_ id: String) {
        self.consentTemplateId = id
    }
    public func customerAAId(_ id: String) {
        self.customerAAId = id
    }
    public func webhook(_ webhook: Webhook) {
        self.webhook = webhook
    }
    public func accountFilters(_ filter: [String]) {
        self.accountFilters = filter
    }
    public func rules(_ rule: [String]) {
        self.rules = rule
    }
    public func auth(_ auth: Auth) {
        self.auth = auth
    }
    public func authparm() -> Auth {
        return auth ?? Auth(authtoken: "")
    }
    public func build() -> AnubhavSDK {
        return AnubhavSDK(customerMobileNumber: customerMobileNumber, consentTemplateId: consentTemplateId, customerAAId: customerAAId, accountFilters: accountFilters, webhook: webhook, rules: rules)
    }
}
public struct AnubhavSDK : Codable {
    let customerMobileNumber : String?
    let consentTemplateId : String?
    let customerAAId : String?
    let accountFilters : [String]?
    let webhook : Webhook?
    let rules : [String]?
    
    public enum CodingKeys: String, CodingKey {
        
        case customerMobileNumber = "customerMobileNumber"
        case consentTemplateId = "consentTemplateId"
        case customerAAId = "customerAAId"
        case accountFilters = "accountFilters"
        case webhook = "webhook"
        case rules = "rules"
    }
    public init(customerMobileNumber:String?,consentTemplateId:String?,customerAAId:String?,accountFilters:[String]?,webhook:Webhook?,rules : [String]?){
        self.customerMobileNumber = customerMobileNumber
        self.consentTemplateId = consentTemplateId
        self.customerAAId = customerAAId
        self.accountFilters = accountFilters
        self.webhook = webhook
        self.rules = rules
        
        
    }
}

public struct Webhook : Codable {
    let analyzedDataPush : String?
    let consentStatus : String?
    let rawDataPush : String?
    let addOnParams : AddOnParams?
    
    public enum CodingKeys: String, CodingKey {
        
        case analyzedDataPush = "analyzedDataPush"
        case consentStatus = "consentStatus"
        case rawDataPush = "rawDataPush"
        case addOnParams = "addOnParams"
    }
    public init(analyzedDataPush:String?,consentStatus:String?,rawDataPush:String?,addOnParams:AddOnParams?){
        self.analyzedDataPush = analyzedDataPush
        self.consentStatus = consentStatus
        self.rawDataPush = rawDataPush
        self.addOnParams = addOnParams
    }
}

public struct AddOnParams : Codable {
    let param1 : String?
    
    public enum CodingKeys: String, CodingKey {
        case param1 = "param1"
        
    }
    
    public init(param1:String?){
        self.param1 = param1
    }
    
}
extension Dictionary {
    
    var json : String {
        get {
            let jsonData = try? JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
            
            if let jsonData = jsonData {
                let jsonString = String(decoding: jsonData, as: UTF8.self)
                return jsonString
            }
            return ""
        }
    }
    
    var data : Data? {
        get {
            let jsonData = try? JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
            if let jsonData = jsonData {
                return jsonData
            }
            return nil
        }
    }
}

extension Data {
    var json : [String:Any]  {
        get {
            let dictData = try? JSONSerialization.jsonObject(with: self, options: []) as? [String:Any]
            if let dict = dictData {
                return dict
            }
            return [:]
        }
        
    }
    
    var jsonDictionary : [String:Any]?  {
        get {
            let dictData = try? JSONSerialization.jsonObject(with: self, options: []) as? [String:Any]
            if let dict = dictData {
                return dict
            }
            return nil
        }
        
    }
    
    var stringValue : String {
        get {
            
            let jsonString = String(decoding: self, as: UTF8.self)
            return jsonString
            
        }
    }
    
    
}
extension Encodable {
    
    var dictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }
    
}
public enum Result<T, E: Swift.Error> {
    case success(T)
    case failure(E)
    
    public func dematerialize() throws -> T {
        switch self {
        case let .success(value):
            return value
        case let .failure(error):
            throw error
        }
    }
}
