//
//  WebPage.swift
//  sixmin
//
//  Created by tuan.nguyenv on 10/21/20.
//

import SwiftUI

struct WebPage: View {
    var viewModel: ViewModel
    var body: some View {
        WebView(viewModel: viewModel)
            .onAppear(perform: {
                
            })
    }
}


import Foundation
import Combine
import WebKit

class ViewModel: ObservableObject {
    var webViewNavigationPublisher = PassthroughSubject<WebViewNavigation, Never>()
    var showLoader = PassthroughSubject<Bool, Never>()
    var valuePublisher = PassthroughSubject<String, Never>()
    var urlString: String
    init(url: String) {
        urlString = url
    }
}

enum WebViewNavigation {
    case backward, forward
}

enum WebUrl {
    case localUrl, publicUrl
}

struct WebView: UIViewRepresentable {
    var urlType: WebUrl = .publicUrl
    // Viewmodel object
    @ObservedObject var viewModel: ViewModel
    
    // Make a coordinator to co-ordinate with WKWebView's default delegate functions
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> WKWebView {
        // Enable javascript in WKWebView to interact with the web app
        let preferences = WKPreferences()
//        preferences.javaScriptEnabled = true
        
        let configuration = WKWebViewConfiguration()
        // Here "iOSNative" is our interface name that we pushed to the website that is being loaded
        configuration.userContentController.add(self.makeCoordinator(), name: "iOSNative")
        configuration.preferences = preferences
        
        let webView = WKWebView(frame: CGRect.zero, configuration: configuration)
        webView.navigationDelegate = context.coordinator
        webView.allowsBackForwardNavigationGestures = true
        webView.scrollView.isScrollEnabled = true
       return webView
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        if let url = URL(string: viewModel.urlString){
            webView.load(URLRequest(url: url))
        }
    }
    
    class Coordinator : NSObject, WKNavigationDelegate {
        var parent: WebView
        var webViewNavigationSubscriber: AnyCancellable? = nil
        
        init(_ uiWebView: WebView) {
            self.parent = uiWebView
        }
        
        deinit {
            webViewNavigationSubscriber?.cancel()
        }
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            // Page loaded so no need to show loader anymore
            self.parent.viewModel.showLoader.send(false)
        }
        
        func webViewWebContentProcessDidTerminate(_ webView: WKWebView) {
            parent.viewModel.showLoader.send(false)
        }
        
        func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
            parent.viewModel.showLoader.send(false)
        }
        
        func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
            parent.viewModel.showLoader.send(true)
        }
        
        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            parent.viewModel.showLoader.send(true)
            self.webViewNavigationSubscriber = self.parent.viewModel.webViewNavigationPublisher.receive(on: RunLoop.main).sink(receiveValue: { navigation in
                switch navigation {
                    case .backward:
                        if webView.canGoBack {
                            webView.goBack()
                        }
                    case .forward:
                        if webView.canGoForward {
                            webView.goForward()
                        }
                }
            })
        }
        
        // This function is essential for intercepting every navigation in the webview
        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            decisionHandler(.allow)
        }
    }
}

extension WebView.Coordinator: WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        // Make sure that your passed delegate is called
        if message.name == "iOSNative" {
            if let body = message.body as? [String: Any?] {
                print("JSON value received from web is: \(body)")
            } else if let body = message.body as? String {
                print("String value received from web is: \(body)")
            }
        }
    }
}
