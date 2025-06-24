///`SavedRecipesViewModel.swift` –  this handles local saving and loading of bookmarked recipes. This uses user defaults to persist user favorites and provides helper methods to filter and refresh.
//  FetchaBite
//
//  Created by Alexis 
//

import Foundation

class SavedRecipesViewModel: ObservableObject {
    @Published private(set) var savedRecipes: [Recipe] = [] {
        didSet { saveRecipes()}
    }
    
    private let userDefaultsKey = "savedRecipes"

    init() {
        loadRecipes()
    }
    
    // Checks if this recipe is already saved by the UUID
    func isRecipeSaved(recipe: Recipe) -> Bool {
        savedRecipes.contains(where: {$0.uuid == recipe.uuid})
    }
    // Adds or removes a recipe from saved recipes and If two recipes have the same UUID  then both will be affected
    func toggleSave(recipe: Recipe ) {
        
        if let idx = savedRecipes.firstIndex(where: { $0.uuid == recipe.uuid}) {
            savedRecipes.remove(at: idx)
        } else {
            savedRecipes.append(recipe)
        }
    }
    
    // Filters saved recipes by cuisine
    func filteredRecipes(cuisine: String?) -> [Recipe] {
       
        guard let cuisine = cuisine else {
            return savedRecipes
        }
        return savedRecipes.filter { $0.cuisine == cuisine }
    }
    
   
    // Serializes saved recipes to user defaults. This is for the local persitence
    func saveRecipes() {
        do {
            let data = try JSONEncoder().encode(savedRecipes)
            
            UserDefaults.standard.set(data, forKey: userDefaultsKey)
        } catch {
            assertionFailure("Failed to save recipes: \(error)")
        }
    }
    // Loads the saved recipes from user defaults on startup
    func loadRecipes() {
        
        guard let data = UserDefaults.standard.data(forKey: userDefaultsKey) else { return }
       
        do {
            let recipes = try JSONDecoder().decode([Recipe].self, from: data)
            savedRecipes = recipes
        } catch {
            assertionFailure("Failed to load recipes: \(error)")
        }
    }
    
    func refresh() {
        loadRecipes()
    }

}



#if DEBUG
extension SavedRecipesViewModel {
    func injectPreviewRecipes(_ recipes: [Recipe]) {
        self.savedRecipes = recipes
    }
}
#endif


