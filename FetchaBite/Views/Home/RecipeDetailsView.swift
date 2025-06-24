///`RecipeDetailsView.swift` –  this displays a full screen detail view from th selcted recipe from the gird view. It will show web-based cotent such as a website or youtube video.
//  FetchaBite
//
//  Created by Alexis 
//

import SwiftUI
import WebKit

struct RecipeDetailsView: View {
    @StateObject var viewModel: RecipeDetailsViewModel
    @State private var webView = WKWebView()
    
    init(recipe: Recipe) {
        _viewModel = StateObject(wrappedValue: RecipeDetailsViewModel(recipe: recipe))
    }
    
    var body: some View {
        VStack(spacing: 0) {
            
            ZStack {
                RoundedRectangle(cornerRadius: 6)
                    .fill(Color("BrandColor"))
                    .frame(height: 30)
                    .shadow(color: Color.black.opacity(0.08), radius: 4, y: 2)
                // Disable tab if no link of this type exists
                Picker("View", selection: $viewModel.selectedTab) {
                    Text("Source").tag(0).disabled(!viewModel.hasSource)
                    Text("Youtube").tag(1).disabled(!viewModel.hasYoutube)
                }
                .pickerStyle(.segmented)
            }
            
            Group {
                // Some sources only provide insecure HTTP links so it then recommends opening it in Safari for safety
                if viewModel.hasAnyLinks {
                    if viewModel.selectedTab == 0, let source = viewModel.recipe.sourceUrl {
                        if viewModel.isSourceHTTP {
                            // Force reload the web content
                            VStack {
                                Spacer()
                                Text("This recipe source uses an insecure (HTTP) link. Please open in Safari below.")
                                    .foregroundStyle(Color("SecondaryText"))
                                    .font(.custom("Syne-SemiBold", size: 16))
                                    .multilineTextAlignment(.center)
                                    .padding(.horizontal, 24)
                                    .padding(.bottom, 24)
                                Button(action: { UIApplication.shared.open(source) } )
                                {
                                    Text("Open in Safari")
                                        .font(.custom("Syne-SemiBold", size: 18))
                                        .foregroundStyle(Color("PrimaryText"))
                                        .padding(.horizontal, 28)
                                        .padding(.vertical, 12)
                                        .background(
                                            Capsule()
                                                .fill(Color("SecondaryText").opacity(0.95))
                                                .shadow(color: Color.black.opacity(0.08), radius: 8, y: 4)
                                        )
                                }
                                Spacer()
                            }
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(Color("BrandColor"))
                        } else {
                            RecipeWebView(webView: webView, url: source)
                                .background(Color("BrandColor"))
                                .ignoresSafeArea(edges: .bottom)
                        }
                    } else if viewModel.selectedTab == 1, let youtube = viewModel.recipe.youtubeUrl {
                        RecipeWebView(webView: webView, url: youtube)
                            .background(Color("BrandColor"))
                            .ignoresSafeArea(edges: .bottom)
                    } else {
                        Spacer()
                        Text("Content not available")
                            .foregroundStyle(Color("SecondaryText"))
                            .padding()
                        Spacer()
                    }
                } else {
                    Spacer()
                    Text("Content not available")
                        .foregroundStyle(Color("SecondaryText"))
                        .padding()
                    Spacer()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("BrandColor"))
        }
        .toolbarBackground(Color("BrandColor"), for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text(viewModel.recipe.name)
                    .font(.custom("Syne-Bold", size: 20, relativeTo: .title))
                    .foregroundStyle(Color("PrimaryText"))
                    .lineLimit(1)
                    .minimumScaleFactor(0.7)
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                // Force reload the web content
                Button {
                    webView.reload()
                } label: {
                    Image(systemName: "arrow.clockwise")
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .background(Color("BrandColor"))
        .refreshable {
            webView.reload()
        }
        
    }
}
#Preview {
    let recipes = loadMockRecipes()
    RecipeDetailsView(recipe: recipes.first!)
}
