///`Category.swift`  – represents  a cuisine type like "British" or "Malaysian"
//  FetchaBite
//
//  Created by Alexis on 
//

import Foundation

/// - `title`: the category name
/// - `imageUrl`: image that displays the category card
/// - `id`:  a auto-generated unique ID.
   
struct Category: Identifiable, Hashable {
    var id = UUID()
    var title: String
    var imageUrl: URL?
}
