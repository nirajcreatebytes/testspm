//
//  Parameters_Anubhav.swift
//  
//
//  Created by NirajMehta on 30/03/23.
//

import Foundation

public enum MessageHandlers_Anubhav : String {
    case nativeApp_Handler = "nativeApp"
    case nativeApp_type = "type"
    case nativeApp_payload = "payload"
    case type_app_success = "app_success"
    case type_onExit = "EXIT"
    case type_OPEN = "OPEN"
    case type_app_failure = "app_failure"
}
enum HttpMethod_Anubhav : String {
    case post = "POST"
    case get = "GET"
    case put = "PUT"
}

public enum NetworkingError_Anubhav: Error {
    case invalidURL
    case missingData
    case invalidServerResponse
    case noInternetConnection
    case missingpresentView
}
enum HeaderFields_Anubhav : String {
    case basic = "Basic"
    case authorization = "Authorization"
    case content = "Content-Type"
    case appjson = "application/json"
    case appurlencoded = "application/x-www-form-urlencoded"
    case bearer = "Bearer"
}
enum URLFieldsAnubhav : String {
    case redirectUrl = "https://api.finarkein.in/factory/v1/finarkein/consent/aa"
}

