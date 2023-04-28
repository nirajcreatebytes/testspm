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
//let frameworkBundle = Bundle(for: OpenAnubhavHandler.self)
#endif

#if canImport(UIKit)
import UIKit
//MARK: - Handler
public class OpenAnubhavHandler: UIView {
    //MARK: - Variable
    public var onExit: ((AnubhavExit?) -> ())?
    public var onSuccess: ((AnubhavSuccess?) -> ())?
    public var onEvent: ((AnubhavEvent?) -> ())?
    
    var webURLAnubhav:String = ""
    var containerView = UIView()
    
    lazy var anubhavIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.frame = CGRect(x: 0, y: 0, width:  200.0, height: 200.0)
        activityIndicator.style = .large
        activityIndicator.color = UIColor.systemOrange
        //(red: 255.0, green: 87.0, blue: 50.0, alpha: 1.0)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
    
    lazy var webKit_Anubhav: WKWebView = {
        let  webConfiguration:WKWebViewConfiguration = WKWebViewConfiguration()
        let userController:WKUserContentController = WKUserContentController()
        userController.add(self, name: MessageHandlers_Anubhav.nativeApp_Handler.rawValue)
        let preferences = WKPreferences()
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
        views.addSubview(anubhavIndicator)
        anubhavIndicator.startAnimating()
        anubhavIndicator.center = views.center
        
        anubhavIndicator.centerXAnchor.constraint(equalTo: views.centerXAnchor).isActive = true
        anubhavIndicator.centerYAnchor.constraint(equalTo: views.centerYAnchor).isActive = true
         }
    }
    
    public func anubhavConfigurationBackend(parameters:AnubhavBackend?,presentView:UIView,completion: @escaping (Result<String, Error>) -> Void) {
        containerView = presentView
        activityIndicatorAnubhav(views: presentView)
        if parameters?.redirectURL != ""{
            self.webURLAnubhav = parameters?.redirectURL ?? ""
            
            completion(.success(parameters?.redirectURL ?? ""))
            self.launchWebview(presentView: presentView, webURL: self.webURLAnubhav)
            
        }else{
            anubhavIndicator.stopAnimating()
            anubhavIndicator.removeFromSuperview()
            completion(.failure(NetworkingError_Anubhav.missingData))
            
        }
    }
    
    public func anubhavConfigurationSDK(parameters:AnubhavSDK?,presentView:UIView,completion: @escaping (Result<String, Error>) -> Void) {
        containerView = presentView
        activityIndicatorAnubhav(views: presentView)
        let authtoken =  AnubhavConfigurationSDK().authparm().authtoken ?? ""
        if parameters?.customerMobileNumber != "" && parameters?.consentTemplateId != "" && authtoken != "" {
            Task {
                do {
                    let baseURL = try await
                    URLRequest_Anubhav.shared.usingDirectSDKAnubhav(token: authtoken,parameters: parameters)
                    self.webURLAnubhav = baseURL.redirectUrl ?? ""
                    completion(.success(baseURL.redirectUrl ?? ""))
                    self.launchWebview(presentView: presentView, webURL: self.webURLAnubhav)
                } catch {
                    anubhavIndicator.stopAnimating()
                    anubhavIndicator.removeFromSuperview()
                    completion(.failure(error))
                }
            }
        }else{
            anubhavIndicator.stopAnimating()
            anubhavIndicator.removeFromSuperview()
            completion(.failure(NetworkingError_Anubhav.missingData))
        }
    }
    
    //MARK: - WEB view setup
    func launch(presentView:UIView) {
        
        if presentView.bounds.size.height != 0.0 {
            containerView = presentView
            defer {
                //                anubhavIndicator.stopAnimating()
                //                anubhavIndicator.removeFromSuperview()
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
        
        // containerView = presentView
        //if presentView.sizeCheck.height != 0.0 {
        defer {
            
            if let url = URL(string: webURL ?? "") {
                webKit_Anubhav.load(URLRequest(url: url, cachePolicy: NSURLRequest.CachePolicy.reloadIgnoringLocalCacheData ))
            }
            //            anubhavIndicator.stopAnimating()
            //            anubhavIndicator.removeFromSuperview()
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
extension OpenAnubhavHandler: WKUIDelegate,WKNavigationDelegate ,WKScriptMessageHandler{
    
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
                
                self.onExit?(AnubhavExit.init(requestId: requestId, error: AnubhavError.init(errorCode: errorCode, errorType: errorType, errorMessage: errorMessage, displayMessage: displayMessage), metadata: Metadata.init(institutions:arry, status: exitStatus)))
                
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
    public func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        activityIndicatorAnubhav(views: containerView)
    }
    
    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        anubhavIndicator.stopAnimating()
        anubhavIndicator.removeFromSuperview()
    }
    
    public func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        anubhavIndicator.stopAnimating()
        anubhavIndicator.removeFromSuperview()
    }
}
#endif
