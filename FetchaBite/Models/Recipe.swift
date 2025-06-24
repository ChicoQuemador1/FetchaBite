///`Recipe.swift` –   represents a single recipe fetched from the API.
//  FetchaBite
//
//  Created by Alexis
//

import Foundation

/// - `name`: the title of the dish
/// - `cuisine`: the recipe's region ( the country bassically)
/// - `photoUrlLarge`: A larger image to show in detail views or the hero sections 
/// - `photoUrlSmall`: A thumbnail image for the list and grid views
/// - `uuid`:  ID used for identifying recipes across views
/// - `sourceUrl`: link to the original recipe
/// - `youtubeUrl`:link to a YouTube recipe

struct Recipe: Codable, Identifiable, Equatable, Hashable {
    let cuisine: String
    let name: String
    let photoUrlLarge: URL?
    let photoUrlSmall: URL?
    let uuid: String
    let sourceUrl: URL?
    let youtubeUrl: URL?
    var id: String { uuid }
}

struct RecipesResponse: Codable {
    let recipes: [Recipe]
}


