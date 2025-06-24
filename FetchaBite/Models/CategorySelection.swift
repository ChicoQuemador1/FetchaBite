///`CategorySelection.swift` –   tracks what category the user tapped on like "American" or "Cake"
//  FetchaBite
//
//  Created by Alexis
//

import Foundation

/// - `title`: the name of the cuisine or dessert type
/// - `imageUrl`: the image for the category.
/// - `isDessertType`: if this is true, this category is a dessert type otherwise, it's a cuisine.

struct CategorySelection: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let imageUrl: URL?
    let isDessertType: Bool
}
