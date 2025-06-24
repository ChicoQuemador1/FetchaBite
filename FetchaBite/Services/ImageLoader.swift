///`ImageLoaderViewModel.swift` – this loads images asynchronously and caches them in memory.  If the image exists in the  cache, it reuses it or otherwise, it downloads and stores it.
//FetchaBite
//
//  Created by Alexis 
//

import SwiftUI

@MainActor
final class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    
    private(set) var isLoading = false
    private let cache: ImageCache
    private let url: URL?
    
    init(url: URL?, cache: ImageCache = ImageCache.shared) {
        self.url = url
        self.cache = cache
    }

    // Loads the image for the given URL and uses the shared cache to give updates on the main thread
func load() async {
    guard let url = url, image == nil, !isLoading else { return }
    isLoading = true

    if let cached = cache[url]{
        image = cached
        isLoading = false
        return
    }

    do{
        let(data, _) = try await URLSession.shared.data(from: url)
        guard let uiImage = UIImage(data: data) else { return }
        image = uiImage
        cache[url] = uiImage
    } catch {
        // Swallowing errors for now could log or show the user if I wanted
        }
    isLoading = false
    }
}
