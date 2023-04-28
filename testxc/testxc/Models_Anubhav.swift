//
//  Models_Anubhav.swift
//  
//
//  Created by NirajMehta on 30/03/23.
//

import Foundation
// MARK: - AnubhavSuccess
public struct AnubhavSuccess: Codable {
    
    public var requestId : String?
    public var  metadata : SuccessMetadata?
    public var  institutions : [Institutions]?
    public enum CodingKeys: String, CodingKey {
        case requestId = "requestId"
        case metadata = "metadata"
        case institutions = "institutions"
    }
    public init(requestId:String?,metadata: SuccessMetadata?,institutions:[Institutions]?){
        self.requestId = requestId
        self.metadata = metadata
        self.institutions = institutions
    }
}
public struct SuccessMetadata: Codable {
    public var  accounts : [Accounts]?
    
    public enum CodingKeys: String, CodingKey {
        case accounts = "accounts"
    }
    public init(accounts:[Accounts]?){
        self.accounts = accounts
    }
}


public struct Accounts: Codable {
    public var  mask : String?
    public var  type : String?
    public var  subType : String?
    public var  institutionId : String?
    
    public enum CodingKeys: String, CodingKey {
        
        case mask = "mask"
        case type = "type"
        case subType = "subType"
        case institutionId = "institutionId"
    }
    public init(mask:String?,type:String?,subType:String?,institutionId:String?){
        self.mask = mask
        self.type = type
        self.subType = subType
        self.institutionId = institutionId
    }
    
}

public struct Institutions : Codable  {
    public var  fipId : String?
    public var  fipName : String?
    
    public enum CodingKeys: String, CodingKey {
        
        case fipId = "fipId"
        case fipName = "fipName"
    }
    public init(fipId:String?,fipName:String){
        self.fipId = fipId
        self.fipName = fipName
    }
    
}

//MARK: - anubhavOPEN
//public struct AnubhavOPEN: Codable {
//    public var  requestId : String?
//    public var  timestamp : String?
//
//    public enum CodingKeys: String, CodingKey {
//
//        case requestId = "requestId"
//        case timestamp = "timestamp"
//    }
//
//    public init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        requestId = try values.decodeIfPresent(String.self, forKey: .requestId)
//        timestamp = try values.decodeIfPresent(String.self, forKey: .timestamp)
//    }
//
//}
public struct Metadata: Codable {
    public var institutions : [Institutions]?
    public var status : String?
    
    
    public enum CodingKeys: String, CodingKey {
        case institutions = "institutions"
        case status = "status"
    }
    public init(institutions:[Institutions]?,status:String?){
        self.institutions = institutions
        self.status = status
    }
}


public struct AnubhavError: Codable {
    public var errorCode : String?
    public var errorType : String?
    public var errorMessage : String?
    public var displayMessage : String?
    
    public enum CodingKeys: String, CodingKey {
        case errorCode = "errorCode"
        case errorType = "errorType"
        case errorMessage = "errorMessage"
        case displayMessage = "displayMessage"
    }
    public init(errorCode:String?,errorType:String?,errorMessage:String?,displayMessage:String?){
        self.errorCode = errorCode
        self.errorType = errorType
        self.errorMessage = errorMessage
        self.displayMessage = displayMessage
        
    }
}

public struct Eventmetadata: Codable {
    public var timestamp: String?
    public var metadataJson: String?
    public var errorCode : String?
    public var errorType : String?
    public var errorMessage : String?
    
    public enum CodingKeys: String, CodingKey {
        case timestamp = "timestamp"
        case metadataJson = "metadataJson"
        case errorCode = "errorCode"
        case errorType = "errorType"
        case errorMessage = "errorMessage"
    }
    public init(timestamp:String?,metadataJson:String?,errorCode:String?,errorType:String?,errorMessage:String?){
        self.timestamp = timestamp
        self.metadataJson = metadataJson
        self.errorCode = errorCode
        self.errorType = errorType
        self.errorMessage = errorMessage
    }
}
public struct AnubhavEvent: Codable {
    public var name : String?
    public var  requestId : String?
    public var metadata : Eventmetadata?
    
    public enum CodingKeys: String, CodingKey {
        case name = "name"
        case requestId = "requestId"
        case metadata = "metadata"
    }
    public init(name:String?,requestId:String?,metadata:Eventmetadata?){
        self.name = name
        self.requestId = requestId
        self.metadata = metadata
    }
}

//MARK: - anubhavExit
public struct AnubhavExit: Codable {
    public var requestId : String?
    public var error : AnubhavError?
    public var metadata : Metadata?
    
    public enum CodingKeys: String, CodingKey {
        case requestId = "requestId"
        case metadata = "metadata"
        case error = "error"
        
    }
    public init(requestId:String?,error:AnubhavError?,metadata:Metadata?){
        self.requestId = requestId
        self.error = error
        self.metadata = metadata
        
    }
}

//MARK: - Auth Request Model
public struct Auth : Codable {
    public var authtoken: String?
    public enum CodingKeys: String, CodingKey {
        case authtoken = "auth"
    }
    public init(authtoken:String?){
        self.authtoken = authtoken
    }
}
//MARK: - Backend Request Model
public struct AnubhavBackend : Codable {
    public var requestID: String?
    public var redirectURL: String?
    
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
    public var consentHandle : String?
    public var redirectUrl : String?
    public var webviewBaseUrl : String?
    
    enum CodingKeys: String, CodingKey {
        case consentHandle = "consentHandle"
        case redirectUrl = "redirectUrl"
        case webviewBaseUrl = "webviewBaseUrl"
    }
    public init(consentHandle:String?,redirectUrl:String?,webviewBaseUrl:String?){
        self.consentHandle = consentHandle
        self.redirectUrl = redirectUrl
        self.webviewBaseUrl = webviewBaseUrl
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
    public var customerMobileNumber : String?
    public var consentTemplateId : String?
    public var customerAAId : String?
    public var accountFilters : [String]?
    public var webhook : Webhook?
    public var rules : [String]?
    
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
    public var analyzedDataPush : String?
    public var consentStatus : String?
    public var rawDataPush : String?
    public var addOnParams : AddOnParams?
    
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
    public var param1 : String?
    
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
