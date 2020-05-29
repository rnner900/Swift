//
//  AppView.swift
//  WorldTrotterSUI
//
//  Created by Jacob on 23.03.20.
//  Copyright © 2020 Jacob. All rights reserved.
//

import SwiftUI

struct AppView: View {
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        TabView() {
            ConversionView()
                .tabItem {
                    Image("ConvertIcon")
                    Text("Convert")
                }
            MapView()
                .tabItem {
                    Image("MapIcon")
                    Text("Map")
                }
            
            WebView(request: URLRequest(url: URL(string: "https://www.dhbw-stuttgart.de")!))
                .tabItem {
                    Image("MapIcon")
                    Text("Web")
                }
        }
    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
    }
}
