///`RecipeDetailsViewModel.swift` –  this mamnages teh state ffor the recipe details view. It switches between the source URL and YouTube URL  views. It also determines which links are valid and shown.
//  FetchaBite
//
//  Created by Alexis
//

import Foundation

class RecipeDetailsViewModel: ObservableObject {
    @Published var selectedTab: Int = 0
    let recipe: Recipe

    init(recipe: Recipe) {
        self.recipe = recipe
    }

    var hasSource: Bool { recipe.sourceUrl != nil }
    var hasYoutube: Bool { recipe.youtubeUrl != nil }
    var hasAnyLinks: Bool { hasSource || hasYoutube }
    
    // Returns the URL to display the current tab so the source (0) or YouTube (1)
    var displayedURL: URL? {
        if selectedTab == 0 {
            return recipe.sourceUrl
        } else if selectedTab == 1 {
            return recipe.youtubeUrl
        }
            return nil
    }
    // Checks if the source URL uses plain HTTP
    var isSourceHTTP: Bool {
        guard let source = recipe.sourceUrl else { return false }
        return source.scheme == "http"
    }
}
