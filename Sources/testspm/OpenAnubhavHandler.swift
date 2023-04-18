//
//  OpenAnubhav.swift
//  
//
//  Created by NirajMehta on 30/03/23.
//


import Foundation


import WebKit
#if SWIFT_PACKAGE
//let frameworkBundle = Bundle.module
#else
let frameworkBundle = Bundle(for: OpenAnubhavHandler.self)
#endif
//MARK: - Handler
#if canImport(UIKit)
import UIKit

public class OpenAnubhavHandler: UIView {
    //MARK: - Variable
    public var onExit: ((AnubhavExit?) -> ())?
    public var onSuccess: ((AnubhavSuccess?) -> ())?
    public var onEvent: ((AnubhavEvent?) -> ())?
    
    var webURLAnubhav:String = ""
    var containerView = UIView()
    var anubhavIndicator = UIActivityIndicatorView(style: .large)
    
    lazy var webKit_Anubhav: WKWebView = {
        let  webConfiguration:WKWebViewConfiguration = WKWebViewConfiguration()
        let userController:WKUserContentController = WKUserContentController()
        userController.add(self, name: MessageHandlers_Anubhav.nativeApp_Handler.rawValue)
        let preferences = WKPreferences()
        preferences.javaScriptEnabled = true
        webConfiguration.preferences = preferences
        webConfiguration.userContentController = userController
        let webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        webView.navigationDelegate = self
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()
    public init() {
        super.init(frame: .zero)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func activityIndicatorAnubhav(views:UIView){
        if views.bounds.size.height != 0.0 {
            anubhavIndicator.translatesAutoresizingMaskIntoConstraints = false
            views.addSubview(anubhavIndicator)
            anubhavIndicator.centerXAnchor.constraint(equalTo: views.centerXAnchor).isActive = true
            anubhavIndicator.centerYAnchor.constraint(equalTo: views.centerYAnchor).isActive = true
            anubhavIndicator.startAnimating()
        }
    }
    
    public func anubhavConfigurationBackend(parameters:AnubhavBackend?,completion: @escaping (Result<String, Error>) -> Void) {
        if parameters?.redirectURL != ""{
            self.webURLAnubhav = parameters?.redirectURL ?? ""
            completion(.success(parameters?.redirectURL ?? ""))
        }else{
            completion(.failure(NetworkingError_Anubhav.missingData))
            
        }
    }
    
    public func anubhavConfigurationSDK(parameters:AnubhavSDK?,completion: @escaping (Result<String, Error>) -> Void) {
        let authtoken =  AnubhavConfigurationSDK().authparm().authtoken ?? ""
        if parameters?.customerMobileNumber != "" && parameters?.consentTemplateId != "" && authtoken != "" {
     
                    completion(.success(""))
              
        }else{
            completion(.failure(NetworkingError_Anubhav.missingData))
        }
    }
    
    //MARK: - WEB view setup
    public func launch(presentView:UIView) {
        if presentView.bounds.size.height != 0.0 {
            containerView = presentView
            defer {
                if let url = URL(string: webURLAnubhav) {
                    webKit_Anubhav.load(URLRequest(url: url, cachePolicy: NSURLRequest.CachePolicy.reloadIgnoringLocalCacheData ))
                }
                
            }
            DispatchQueue.main.async {
                presentView.backgroundColor = .white
                presentView.addSubview(self.webKit_Anubhav)
                presentView.setNeedsDisplay()
                NSLayoutConstraint.activate([
                    self.webKit_Anubhav.topAnchor
                        .constraint(equalTo: presentView.safeAreaLayoutGuide.topAnchor),
                    self.webKit_Anubhav.leftAnchor
                        .constraint(equalTo: presentView.safeAreaLayoutGuide.leftAnchor),
                    self.webKit_Anubhav.bottomAnchor
                        .constraint(equalTo: presentView.safeAreaLayoutGuide.bottomAnchor),
                    self.webKit_Anubhav.rightAnchor
                        .constraint(equalTo: presentView.safeAreaLayoutGuide.rightAnchor)
                ])
            }
        }
    }
    func launchWebview(presentView:UIView,webURL:String?) {
        containerView = presentView
        //if presentView.sizeCheck.height != 0.0 {
        defer {
            
            if let url = URL(string: webURL ?? "") {
                webKit_Anubhav.load(URLRequest(url: url, cachePolicy: NSURLRequest.CachePolicy.reloadIgnoringLocalCacheData ))
            }
            
        }
        DispatchQueue.main.async {
            presentView.backgroundColor = .white
            presentView.addSubview(self.webKit_Anubhav)
            presentView.setNeedsDisplay()
            NSLayoutConstraint.activate([
                self.webKit_Anubhav.topAnchor
                    .constraint(equalTo: presentView.safeAreaLayoutGuide.topAnchor),
                self.webKit_Anubhav.leftAnchor
                    .constraint(equalTo: presentView.safeAreaLayoutGuide.leftAnchor),
                self.webKit_Anubhav.bottomAnchor
                    .constraint(equalTo: presentView.safeAreaLayoutGuide.bottomAnchor),
                self.webKit_Anubhav.rightAnchor
                    .constraint(equalTo: presentView.safeAreaLayoutGuide.rightAnchor)
            ])
        }
    }
    
}
//MARK: - Web Delegate
extension OpenAnubhavHandler: WKUIDelegate,WKNavigationDelegate ,WKScriptMessageHandler {
    
    public func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        
        if message.name == MessageHandlers_Anubhav.nativeApp_Handler.rawValue {
            guard let dict = message.body as? [String: AnyObject],let type = dict[MessageHandlers_Anubhav.nativeApp_type.rawValue] as? String,let payload = dict[MessageHandlers_Anubhav.nativeApp_payload.rawValue] as? NSDictionary else {
                return
            }
            print(payload)
            if type == MessageHandlers_Anubhav.type_app_success.rawValue{
                if containerView.bounds.size.height != 0.0 {
                    containerView.removeFromSuperview()
                }
                /*  guard
                 let archivedRecord = try? JSONSerialization.data(withJSONObject: payload),
                 let datas = try? JSONDecoder().decode(AnubhavSuccess.self, from: archivedRecord)
                 else { return  } */
                
                let requestId = payload["requestId"] as? String  ?? ""
                let metadata = payload["accounts"] as? [NSDictionary]
                
                var arryaccounts :[Accounts]?
                arryaccounts?.removeAll()
                metadata?.forEach({ objc in
                    let mask = objc["mask"] as? String  ?? ""
                    let type = objc["type"] as? String  ?? ""
                    let subType = objc["subType"] as? String  ?? ""
                    let institutionId = objc["institutionId"] as? String  ?? ""
                    arryaccounts?.append(Accounts.init(mask: mask, type: type, subType: subType, institutionId: institutionId))
                })
                let institutions = payload["institutions"] as? [NSDictionary]
                var arry :[Institutions]?
                arry?.removeAll()
                institutions?.forEach({ objc in
                    let fipId = objc["fipId"] as? String  ?? ""
                    let fipName = objc["fipName"] as? String  ?? ""
                    arry?.append(Institutions.init(fipId: fipId, fipName: fipName))
                })
                
                self.onSuccess?(AnubhavSuccess.init(requestId: requestId, metadata: SuccessMetadata.init(accounts: arryaccounts)  , institutions: arry))
                
            }else if type == MessageHandlers_Anubhav.type_onExit.rawValue{
                if containerView.bounds.size.height != 0.0 {
                    containerView.removeFromSuperview()
                }
                
                let errorCode = payload["errorCode"] as? String  ?? ""
                let errorType = payload["errorType"] as? String  ?? ""
                let errorMessage = payload["errorMessage"] as? String  ?? ""
                let displayMessage = payload["displayMessage"] as? String  ?? ""
                let requestId = payload["requestId"] as? String  ?? ""
                let exitStatus = payload["exitStatus"] as? String  ?? ""
                let institutions = payload["institutions"] as? [NSDictionary]
                var arry :[Institutions]?
                arry?.removeAll()
                institutions?.forEach({ objc in
                    let fipId = objc["fipId"] as? String  ?? ""
                    let fipName = objc["fipName"] as? String  ?? ""
                    arry?.append(Institutions.init(fipId: fipId, fipName: fipName))
                })
                
                self.onExit?(AnubhavExit.init(requestId: requestId, error: AnubhavError.init(errorCode: errorCode, errorType: errorType, errorMessage: errorMessage, displayMessage: displayMessage), metadata: metadata.init(institutions:arry, status: exitStatus)))
                
            }else{
                
                let name = payload["name"] as? String ?? type
                let requestId = payload["requestId"] as? String ?? ""
                
                let timestamp = payload["timestamp"] as? String ?? ""
                let metadataJson = payload["metadataJson"] as? String ?? ""
                let errorCode = payload["errorCode"] as? String ?? ""
                let errorType = payload["errorType"] as? String ?? ""
                let errorMessage = payload["errorMessage"] as? String ?? ""
                
                //else other event get here
                self.onEvent?(AnubhavEvent.init(name: name, requestId: requestId, metadata: Eventmetadata.init(timestamp: timestamp, metadataJson: metadataJson, errorCode: errorCode, errorType: errorType, errorMessage: errorMessage)))
            }
            
        }
    }
    
    public func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        if navigationAction.navigationType == .other{//1
            decisionHandler(.allow)
        }else if navigationAction.navigationType == .backForward{
            decisionHandler(.allow)
        }else if navigationAction.navigationType == .formSubmitted{//2
            decisionHandler(.allow)
        }else if navigationAction.navigationType == .reload{
            decisionHandler(.allow)
        }else if navigationAction.navigationType == .formResubmitted{
            decisionHandler(.allow)
        }else if navigationAction.navigationType == .linkActivated{
            decisionHandler(.allow)
        }
        else {
            decisionHandler(.cancel)
        }
        
    }
}
#endif
