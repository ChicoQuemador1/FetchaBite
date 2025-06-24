///`CachedAsyncImage.swift` –  this displays images using async loading with built in caching. This will prvent flickering and saved bandwidth which is a requiremnt in this project.
//  FetchaBite
//
//  Created by Alexis 
//

import SwiftUI

struct CachedAsyncImage: View {
    @StateObject private var loader: ImageLoader
    
    private let placeholder: AnyView
    private let content: (Image) -> AnyView
    
    init( url: URL?,
              @ViewBuilder placeholder: @escaping () -> AnyView = { AnyView(Color.gray.opacity(0.1)) },
              @ViewBuilder content: @escaping (Image) -> AnyView = { img in AnyView(img.resizable()) } )
    {
            // Creates a new image loader for the provided URL and manages image caching and the loading state
            _loader = StateObject(wrappedValue: ImageLoader(url: url))
            
            self.placeholder = placeholder()
            self.content = content
    }
        var body: some View {
            ZStack{
                if let uiImage = loader.image {
                    content(Image(uiImage: uiImage))
                } else {
                    placeholder
                }
            }
            // Loads the image as soon as the view appears 
            .task {
                await loader.load()
            }
        }
    }


