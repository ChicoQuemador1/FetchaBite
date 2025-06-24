///`HomeViewModel.swift` –  this manages the logic behind the home screen.  Loads recipes from the API, extracts a cuisine or dessert category, filters recipes, and adds new ones.
//  FetchaBite
//
//  Created by Alexis
//

import Foundation


class HomeViewModel: ObservableObject {
    @Published var recipes: [Recipe] = []
    @Published var isLoading = false
    @Published var error: ServiceError? = nil
    
    
    // Fetches recipes from the API and updates the UI. Also if fetching or decoding fails, it sets an errorr and it always clears recipes on error, so you I won’t see any stale data
    @MainActor
    func loadRecipes() async  {
        isLoading = true
        error = nil
        
        do {
            let fetchedRecipes = try await service.getJSON()
            recipes = fetchedRecipes
        } catch let fetchError as ServiceError {
            self.error = fetchError
            recipes = []
        } catch {
            self.error = .failedtoDecodeData(error.localizedDescription)
            recipes = []
        }
        isLoading = false
    }
    
    private let service: RecipeServiceProtocol
    
    private let dessertTypes: [String] = [
        "Cake", "Pie", "Tart", "Pudding", "Cookie", "Brownie", "Bar", "Pancake",
        "Trifle", "Fudge", "Mousse", "Souffle", "Bun", "Roll", "Donut", "Custard",
        "Biscuit", "Mess", "Flapjack", "Cheesecake", "Crumble"
    ]
   
    init(service: RecipeServiceProtocol = RecipeService()) {
        self.service = service
    }
    
    // Checks if the recipe name contains a known dessert keyword, and it returns the matched dessert type or it nil if none is found
    func extractDessertType(from recipe: Recipe) -> String? {
        for type in dessertTypes {
            if recipe.name.localizedCaseInsensitiveContains(type) {
                return type
            }
        }
        return nil
    }
    
    // Returns all recipes for a given cuisine
        func filteredRecipes(byCuisine cuisine: String?) -> [Recipe] {
        guard let cuisine = cuisine else {
            return recipes
        }
        return recipes.filter { $0.cuisine == cuisine }
    }
    
    // Returns all recipes for a specific dessert
    func filteredRecipes(byDessertType dessertType: String?) -> [Recipe] {
        guard let dessertType = dessertType else {
            return recipes
        }
        return recipes.filter { extractDessertType(from: $0) == dessertType }
    }
    

    // Validates and adds a new recipe to the list and returns a service error if validation fails otherwise it updates recipes
    func addRecipe(
         name: String,
         cuisine: String,
         photoUrl: String,
         sourceUrl: String,
         youtubeUrl: String ) -> ServiceError? {
             let trimmedName = name.trimmingCharacters(in: .whitespaces)
                if trimmedName.isEmpty {
                    return .invalidData("Recipe name required")
                }
        
             
             
             
             if cuisine.isEmpty {
                 return .invalidData("Select a cuisine")
             }
                var photoUrlLarge: URL? = nil
             
             if !photoUrl.trimmingCharacters(in: .whitespaces).isEmpty {
                 guard let url = URL(string: photoUrl), url.scheme?.hasPrefix("http") == true else {
                        return .invalidData("Image URL must be valid (http/https)")
            }
            photoUrlLarge = url
        }
        var sourceURL: URL? = nil
        
             if !sourceUrl.trimmingCharacters(in: .whitespaces).isEmpty {
                 guard let url = URL(string: sourceUrl), url.scheme?.hasPrefix("http") == true else {
                     return .invalidData("Source URL must be valid")
            }
            sourceURL = url
        }
             // Only accept links from youtube.com or youtube.be
        var youtubeURL: URL? = nil
       
             if !youtubeUrl.trimmingCharacters(in: .whitespaces).isEmpty {
                 guard let url = URL(string: youtubeUrl),
                  url.scheme?.hasPrefix("http") == true,
                  url.host?.contains("youtube.com") == true || url.host?.contains("youtu.be") == true else {
                return .invalidData("YouTube URL must be a valid YouTube link")
            }
            youtubeURL = url
        }

        let newRecipe = Recipe(
            cuisine: cuisine,
            name: trimmedName,
            photoUrlLarge: photoUrlLarge,
            photoUrlSmall: photoUrlLarge,
            uuid: UUID().uuidString,
            sourceUrl: sourceURL,
            youtubeUrl: youtubeURL)
            recipes.append(newRecipe)
                                
             return nil
    }
}

extension HomeViewModel {
    // All unique cuisines in the current recipe list for the cuisine category
    var cuisineCategories: [Category] {
        var seen: Set<String> = []
       
        var result:[Category] = []
      
        for recipe in recipes {
            if !seen.contains(recipe.cuisine) {
               
                let imageUrl = recipe.photoUrlSmall ?? recipe.photoUrlLarge
                    result.append(Category(title: recipe.cuisine, imageUrl: imageUrl))
                    seen.insert(recipe.cuisine)
                }
        }
        return result.sorted { $0.title < $1.title }
    }
    
    // All unique dessert found via extractDessertType function for the desserts & baking category
    var dessertTypeCategories: [Category] {
        var seen: Set<String> = []
       
            var result: [Category] = []
        
        for recipe in recipes {
            if let type = extractDessertType(from: recipe), !seen.contains(type) {
                let imageUrl = recipe.photoUrlSmall ?? recipe.photoUrlLarge
                    result.append(Category(title: type, imageUrl: imageUrl))
                    seen.insert(type)
            }
        }
        return  result.sorted { $0.title < $1.title }
    }
}
