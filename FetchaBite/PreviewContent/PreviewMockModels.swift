///`PreviewMockModels.swift` – this file will provide mock data and preview-ready ViewModels for SwiftUI previews
//  FetchaBite
//
//  Created by Alexis 
//

import Foundation

// Loads mock recipes from the bundled MockRecipes.json file and returns an empty array if it is not found or if decoding fails

import Foundation

func loadMockRecipes() -> [Recipe] {
    guard
        let url = Bundle.main.url(forResource: "MockRecipes", withExtension: "json"),
        let data = try? Data(contentsOf: url),
        let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
        let jsonRecipes = json["recipes"] as? [[String: Any]]
    else {
        return []
    }

    // Only takes the first 6 from the mock recipes JSON file
    let pickedRecipes = jsonRecipes.prefix(6).compactMap { dict -> Recipe? in
        guard
            let cuisine = dict["cuisine"] as? String,
            let name = dict["name"] as? String,
            let photoUrlLarge = dict["photo_url_large"] as? String,
            let photoUrlSmall = dict["photo_url_small"] as? String,
            let uuid = dict["uuid"] as? String
        else { return nil }

        // Not all recipes have all URLs in the JSON so this takes care of it
        let sourceUrl = (dict["source_url"] as? String).flatMap { URL(string: $0) }
        let youtubeUrl = (dict["youtube_url"] as? String).flatMap { URL(string: $0) }

        return Recipe(
            cuisine: cuisine,
            name: name,
            photoUrlLarge: URL(string: photoUrlLarge),
            photoUrlSmall: URL(string: photoUrlSmall),
            uuid: uuid,
            sourceUrl: sourceUrl,
            youtubeUrl: youtubeUrl
        )
    }

    return Array(pickedRecipes)
}


// A HomeViewModel pre-filled with mock recipes for my preview
final class MockHomeViewModel: HomeViewModel {
    init(_ recipes: [Recipe] = loadMockRecipes()) {
        super.init()
        self.recipes = recipes
    }
}

// It returns a SavedRecipesViewModel injected with mock recipes for my preview & testing if needed
func makePreviewSavedRecipesViewModel() -> SavedRecipesViewModel {
    let vm = SavedRecipesViewModel()
    
    vm.injectPreviewRecipes(loadMockRecipes())
        return vm
}

// It safely returns an element at the index, or nil if it's out of bounds
extension Array {
    subscript(safe index: Int) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}
