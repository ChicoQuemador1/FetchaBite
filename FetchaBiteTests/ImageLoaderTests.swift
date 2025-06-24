///`ImageLoaderTests.swift` –  the unit tests for the ImageLoader class.  It verifies if the correct images are loading for caching behavior, and error handling for invalid or nil URLs.
//  FetchaBiteTests
//
//  Created by Alexis
//

import Foundation

import UIKit
import XCTest
@testable import FetchaBite

@MainActor
final class ImageLoaderTests: XCTestCase {
    func testLoadImageFromURLCachesToDisk() async throws {
        // this generates a 10x10 red pixel image for disk caching test
        let pixel = UIGraphicsImageRenderer(size: CGSize(width: 10, height: 10)).image { ctx in
            UIColor.red.setFill()
            ctx.fill(CGRect(x: 0, y: 0, width: 10, height: 10))
        }
        
        // then saves the image to the disk. This is bassically simulating a download scenario
        let imageData = pixel.pngData()!
        
        let tempDir = FileManager.default.temporaryDirectory
        
        let sourceURL = tempDir.appendingPathComponent("testImage.png")
       
        try imageData.write(to: sourceURL)
        
        // Creates a ImageLoader with a file URL
        let loader = ImageLoader(url: sourceURL)
            XCTAssertNil(loader.image)
       
        // then attempts to load the image
        await loader.load()
            XCTAssertNotNil(loader.image)
            XCTAssertTrue(loader.image!.size.width > 0 && loader.image!.size.height > 0)
       
        let cachesDir = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
        
        // it then inspects the system cache directory to see if the image was actually cached
        let cacheContents = try FileManager.default.contentsOfDirectory(at: cachesDir, includingPropertiesForKeys: nil)
       
        let cachedFile = cacheContents.first { $0.lastPathComponent.contains("testImage") }
            XCTAssertNotNil(cachedFile)
       
        if let fileURL = cachedFile {
            //  It ensures that the cached image file isn't empty
            let cachedData = try Data(contentsOf: fileURL)
                XCTAssertFalse(cachedData.isEmpty)
        }
    }
    
    func testLoadImageWithNilURLDoesNothing() async {
        let loader = ImageLoader(url: nil)
       
        await loader.load()
            XCTAssertNil(loader.image)
    }
    
    func testConsecutiveLoadsDoNotDuplicateFetch() async {
        let pixel = UIGraphicsImageRenderer(size: CGSize(width: 10, height: 10)).image { ctx in
            UIColor.blue.setFill()
            ctx.fill(CGRect(x: 0, y: 0, width: 10, height: 10))
        }
        
        let pixelData = pixel.pngData()!
       
        let tempFile = FileManager.default.temporaryDirectory.appendingPathComponent("cacheTest.png")
       
        try! pixelData.write(to: tempFile)
       
        let loader1 = ImageLoader(url: tempFile)
        await loader1.load()
            XCTAssertNotNil(loader1.image)
        
        
        try? FileManager.default.removeItem(at: tempFile)
        
        let loader2 = ImageLoader(url: tempFile)
       
        // After deleting the file loading again should either fail or handle the cache miss
        await loader2.load()
            XCTAssertNotNil(loader2.image)
    }
}
