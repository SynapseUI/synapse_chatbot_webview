//
//  ChatBotViewController.swift
//  WebViewExample
//
//  Copyright © 2020 Synapse. All rights reserved.
//

import UIKit
import WebKit

class ChatBotViewController: UIViewController, WKNavigationDelegate {
    
    let webView = WKWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let initialUrl = generateInitializationURL()
        let url = URL(string: initialUrl)
        let urlRequest = URLRequest(url: url!)
        
        webView.navigationDelegate = self
        webView.allowsBackForwardNavigationGestures = false
        
        webView.frame = view.frame
        webView.scrollView.bounces = false
        self.view.addSubview(webView)
        webView.load(urlRequest)
    }
    
    
    override func didReceiveMemoryWarning() {
        // Dispose of any resources that can be recreated.
        super.didReceiveMemoryWarning()
    }
        
    func generateInitializationURL() -> String {
        let config = [
            "publicKey": "[SYNAPSE_PUBLIC_KEY]",
            "userId": "[SYNAPSE_USER_ID]",
            "isWebView": "true",
            "defaultPath": "BANK_LOGINS",
            "env": "UAT",
            "fp": "[SYNAPSE_FP]"
        ]

        // Build a dictionary with the Link configuration options
        var components = URLComponents()
        components.scheme = "https"
        components.host = "uat-uiaas-v2.synapsefi.com"
        components.path = "/synapse-chatbot"
        components.queryItems = config.map { URLQueryItem(name: $0, value: $1) }
        return components.string!
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
    
        let chatbotScheme = "chatbot";
        let actionScheme = navigationAction.request.url?.scheme;
        let actionType = navigationAction.request.url?.host;
    
        if (chatbotScheme == actionScheme) {
            switch actionType {
            case "exit"?:
                // close the webview
                _ = self.navigationController?.popViewController(animated: true)
                print("callbackurl:", navigationAction.request.url);
                break
            case "success"?:
                print("callbackurl:", navigationAction.request.url);
                break
            case "error"?:
                print("callbackurl:", navigationAction.request.url);
                break
            default:
                print("callbackurl:", navigationAction.request.url);
                break
            }
            decisionHandler(.cancel)
        } else if (navigationAction.navigationType == .linkActivated && (actionScheme == "http" || actionScheme == "https")) {
            // this is required for open redirect link in mobile browser for capitalOne...etc
            UIApplication.shared.open(navigationAction.request.url!, options: [:], completionHandler: nil)
            decisionHandler(.cancel)
        } else {
           print("Unrecognized URL scheme detected that is neither HTTP, HTTPS, or related to chatbot: \(navigationAction.request.url?.absoluteString)");
           decisionHandler(.allow)
        }
    }
}
    
    
