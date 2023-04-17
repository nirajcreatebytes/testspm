//
//  URLRequest_Anubhav.swift
//  
//
//  Created by NirajMehta on 30/03/23.
//

import Foundation
import SystemConfiguration
#if canImport(FoundationNetworking)
import FoundationNetworking
import SystemConfiguration
#endif

#if canImport(concurrency)
public class URLRequest_Anubhav {
    
    public static let shared = URLRequest_Anubhav()
    
    public init() { }
    
    public func usingDirectSDKAnubhav(token:String?,parameters:AnubhavSDK?) async throws -> AnubhavRedirectURL {
        
        if isInternetAvailable() == false{
            throw NetworkingError_Anubhav.noInternetConnection
        }
        let parameters = parameters
        let postData = parameters.dictionary?.json.data(using: .utf8)
        
        var request = URLRequest(url: URL(string: URLFieldsAnubhav.redirectUrl.rawValue)!,timeoutInterval: Double.infinity)
        request.addValue("\(HeaderFields_Anubhav.bearer.rawValue) \(token ?? "")", forHTTPHeaderField: "\(HeaderFields_Anubhav.authorization.rawValue)")
        request.addValue(HeaderFields_Anubhav.appjson.rawValue, forHTTPHeaderField: HeaderFields_Anubhav.content.rawValue)
        
        request.httpMethod = HttpMethod_Anubhav.post.rawValue
        request.httpBody = postData
        
        // Use the async variant of URLSession to fetch data
        let (data, response) = try await URLSession.shared.data(for: request)
        //print(response)
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw NetworkingError_Anubhav.invalidServerResponse
        }
        // Parse the JSON data
        let result = try JSONDecoder().decode(AnubhavRedirectURL.self, from: data)
        if result.redirectUrl == nil {
            throw NetworkingError_Anubhav.missingData
        }
        return result
    }
    func isInternetAvailable() -> Bool {
        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return false
        }
        
        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        if SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) == false {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
        
    }
}
#endif
