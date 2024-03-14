//
//  WebView.swift
//  Inventory
//
//  Created by Mayur Rangari on 14/03/24.
//

import SwiftUI
import WebKit

//struct WebView: UIViewRepresentable {
//    let url: URL
//    
//    func makeUIView(context: Context) -> WKWebView {
//        let webView = WKWebView()
//        return webView
//    }
//    
//    func updateUIView(_ uiView: WKWebView, context: Context) {
//        let request = URLRequest(url: url)
//        uiView.load(request)
//    }
//}



struct WebView: UIViewRepresentable {
    let url: URL
    let isLoading: Bool
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        webView.backgroundColor = .darkGray
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        uiView.backgroundColor = .darkGray

        uiView.load(request)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    class Coordinator: NSObject, WKNavigationDelegate {}
}
