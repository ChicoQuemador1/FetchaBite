///`SavedRecipesViewModelTests.swift` –  this tests saving and removing recipes from disk using user defaults. It covers toggle save logic, filtering, and state persistence.
//  FetchaBiteTests
//
//  Created by Alexis
//

import XCTest
@testable import FetchaBite

final class SavedRecipesViewModelTests: XCTestCase {
    let testKey = "savedRecipes"

    // Helper to load mock recipes
    func loadMockRecipes() -> [Recipe] {
        let bundle = Bundle(for: type(of: self))
        
        guard let url = bundle.url(forResource: "MockRecipes", withExtension: "json") else {
            XCTFail("Missing MockRecipes.json in test bundle")
            return []
        }
        do {
            let data = try Data(contentsOf: url)
           
            let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
           
            let response = try decoder.decode(RecipesResponse.self, from: data)
                return response.recipes
        } catch {
            XCTFail("Failed to decode MockRecipes.json: \(error)")
            return []
        }
    }

    // Clear saved recipes from the user defaults before each test to avoid a data bleed between all my tests
    override func setUp() {
        super.setUp()
        UserDefaults.standard.removeObject(forKey: testKey)
    }

    // Saves a sample recipe to the user defaults to simulate an existing saved state
    func testLoadFromDiskInitializesSavedRecipes() throws {
        let mockRecipes = loadMockRecipes()
        
        let sampleRecipe = mockRecipes.first!
        
        let data = try JSONEncoder().encode([sampleRecipe])
            UserDefaults.standard.set(data, forKey: testKey)
        
        let savedVM = SavedRecipesViewModel()
            XCTAssertTrue(savedVM.savedRecipes.contains(where: { $0.uuid == sampleRecipe.uuid }))
            XCTAssertTrue(savedVM.isRecipeSaved(recipe: sampleRecipe))
    }

    func testToggleAddsAndRemovesRecipes() throws {
        let savedVM = SavedRecipesViewModel()
        
        let mockRecipes = loadMockRecipes()
       
        let recipe = mockRecipes.first!
            XCTAssertFalse(savedVM.isRecipeSaved(recipe: recipe))
        // Toggling should add the recipe to the saved state
            savedVM.toggleSave(recipe: recipe)
                XCTAssertTrue(savedVM.isRecipeSaved(recipe: recipe))
                XCTAssertTrue(savedVM.savedRecipes.contains(where: { $0.uuid == recipe.uuid }))
       
        let savedData = UserDefaults.standard.data(forKey: testKey)
            XCTAssertNotNil(savedData)
        
        if let data = savedData {
            
            let decoded = try JSONDecoder().decode([Recipe].self, from: data)
                XCTAssertEqual(decoded.count, 1)
                XCTAssertEqual(decoded.first?.name, recipe.name)
        }
        // Toggling again should remove it and update the user defaults
        savedVM.toggleSave(recipe: recipe)
                XCTAssertFalse(savedVM.isRecipeSaved(recipe: recipe))
                    XCTAssertFalse(savedVM.savedRecipes.contains(where: { $0.uuid == recipe.uuid }))
        
        let removedData = UserDefaults.standard.data(forKey: testKey)
            XCTAssertNotNil(removedData)
        
        let decodedAfterRemoval = try JSONDecoder().decode([Recipe].self, from: removedData!)
            XCTAssertTrue(decodedAfterRemoval.isEmpty)
    }
    // Filtering by cuisine should only return recipes that match the filter
    func testFilteredRecipesByCuisine_MockRecipes() {
        let savedVM = SavedRecipesViewModel()
        
        let mockRecipes = loadMockRecipes()
            savedVM.injectPreviewRecipes(mockRecipes)
        
        let allCuisines = Set(mockRecipes.map { $0.cuisine })
            for cuisine in allCuisines {
            
            let filtered = savedVM.filteredRecipes(cuisine: cuisine)
            XCTAssertTrue(filtered.allSatisfy { $0.cuisine == cuisine })
        }
        // Filtering by a non-existent cuisine returns an empty array
        let filteredNone = savedVM.filteredRecipes(cuisine: "NonexistentCuisine")
            XCTAssertTrue(filteredNone.isEmpty)
    }
}
