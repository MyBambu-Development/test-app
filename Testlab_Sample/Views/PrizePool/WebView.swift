//
//  WebView.swift
//  Testlab_Sample
//
//  Created by Chase Moffat on 3/6/25.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    let url: URL
    //Creates a new webView based on the URL passed
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        let request = URLRequest(url: url)
        webView.load(request)
        return webView
    }
    //Empty function to conform with UIViewRepresentable
    func updateUIView(_ webView: WKWebView, context: Context) {}
}
