///`RecipeWebView.swift` –  this embeds a web view for loading the recipes sourceURl or youtubeURL
//  FetchaBite
//
//  Created by Alexis 
//

import SwiftUI
import WebKit

struct RecipeWebView: UIViewRepresentable {
    let webView: WKWebView
    let url: URL
    
    func makeUIView(context: Context) -> WKWebView {
        WKWebView()
    }
    // Always loads the latest URL when this view updates
    func updateUIView(_ webView: WKWebView, context: Context) {
            webView.load(URLRequest(url: url))
    }
}
    
#Preview {
    RecipeWebView(
        webView: WKWebView(),
        url: URL(string: "https://www.bbcgoodfood.com/recipes/2869/new-york-cheesecake")!)
}
