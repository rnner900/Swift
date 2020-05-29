//
//  WebView.swift
//  WorldTrotterSUI
//
//  Created by Jacob on 29.05.20.
//  Copyright © 2020 Jacob. All rights reserved.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
      
    let request: URLRequest
      
    func makeUIView(context: Context) -> WKWebView  {
        return WKWebView()
    }
      
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.load(request)
    }
      
}

struct WebView_Previews: PreviewProvider {
    static var previews: some View {
        WebView(request: URLRequest(url: URL(string: "https://www.dhbw-stuttgart.de")!))
    }
}
