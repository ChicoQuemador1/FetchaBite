///`ImageCache.swift` –  this caches images both in memory (NSCache) and on disk (files). It also helps speed up image loading and reduce network requests.
//  FetchaBite
//
//  Created by Alexis 
//

import UIKit

protocol  ImageCaching {
    subscript(_ url: URL) -> UIImage? {  get set }
}

final class ImageCache: ImageCaching {
    static let shared = ImageCache()
    private let cache = NSCache<NSURL, UIImage>()
    private let fileManager = FileManager.default
   
    // Looks for the image in memory cache first, then try loading from the disk
    subscript(_ key: URL) -> UIImage? {
        get{
            if let image = cache.object(forKey: key as NSURL) {
                return image
            }
          
            
            let fileURL = cacheURL(for: key)
           
            if let data = try? Data(contentsOf: fileURL),
               
                let image = UIImage(data: data) {
                cache.setObject (image, forKey: key as NSURL)
                return image
            }
            // Image wasn’t cached anywhere
            return nil
        }
        // Stores the image in both memory and disk cache for persistence
        set {
            if let image = newValue {
                cache.setObject(image, forKey: key as NSURL)
                
                if let data = image.pngData() {
                    try? data.write(to: cacheURL(for: key))
                }
                
            }
        }
    }

    
// Generates a file URL for the image while encoding the original URL to a safe filename
private func cacheURL(for key: URL) -> URL {
    let fileName = key.absoluteString.addingPercentEncoding(withAllowedCharacters: .alphanumerics) ?? UUID().uuidString
    
    let cacheDirectoryURL = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first!
            return cacheDirectoryURL.appendingPathComponent( fileName, isDirectory: false)
        }
}

