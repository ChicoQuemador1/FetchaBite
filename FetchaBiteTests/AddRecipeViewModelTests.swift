///`AddRecipeViewModelTests.swift` –  this validates AddRecipeViewModel behavior. It ensures form validation, error messaging, and recipe saving.
//  FetchaBiteTests
//
//  Created by Alexis
//

import XCTest
@testable import FetchaBite

final class AddRecipeViewModelTests: XCTestCase {

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

    func testAllCuisinesMatchesMockRecipes() {
        let mainVM = HomeViewModel()
            mainVM.recipes = loadMockRecipes()
        
        let addVM = AddRecipeViewModel()
            addVM.recipeVM = mainVM
        
        let allCuisines = addVM.allCuisines
        
        // All cuisines found by the add ViewModel should exactly match those in the mock recipes set
            let expectedCuisines = Set(loadMockRecipes().map { $0.cuisine })
            XCTAssertEqual(Set(allCuisines), expectedCuisines)
    }

    func testSaveRecipeValidationAndErrorPropagation() {
        let mainVM = HomeViewModel()
        
        let addVM = AddRecipeViewModel()
            addVM.recipeVM = mainVM
        // Should fail since there is  blank name that triggers a validation error and shows an alert.
       
            addVM.reset()
            addVM.name = "   "
            addVM.cuisine = "French"
            addVM.photoUrl = ""
            addVM.sourceUrl = ""
            addVM.youtubeUrl = ""
       
        let result1 = addVM.saveRecipe()
            XCTAssertFalse(result1)
            XCTAssertTrue(addVM.showAlert)
            XCTAssertEqual(addVM.error, ServiceError.invalidData("Recipe name required"))
            XCTAssertEqual(addVM.errorMessage, "Recipe name required")

        // Should fail since there is a blank cuisine that triggers a validation error.
            addVM.reset()
            addVM.name = "Valid Name"
            addVM.cuisine = ""
            addVM.photoUrl = ""
            addVM.sourceUrl = ""
            addVM.youtubeUrl = ""
        
        let result2 = addVM.saveRecipe()
            XCTAssertFalse(result2)
            XCTAssertEqual(addVM.error, ServiceError.invalidData("Select a cuisine"))
    }
    
    // It Should succeed and  add the new recipe and then reset error state and store in the main ViewModel
    func testSaveRecipeSuccessAddsRecipeAndResets() {
        let mainVM = HomeViewModel()
       
        let addVM = AddRecipeViewModel()
            addVM.recipeVM = mainVM
            addVM.name = "New Recipe"
                addVM.cuisine = "Italian"
            addVM.photoUrl = "https://example.com/photo.png"
            addVM.sourceUrl = "https://example.com"
            addVM.youtubeUrl = "https://www.youtube.com/watch?v=xyz"
        
        let result = addVM.saveRecipe()
            XCTAssertTrue(result)
            XCTAssertNil(addVM.error)
            XCTAssertFalse(addVM.showAlert)
            XCTAssertEqual(mainVM.recipes.count, 1)
            XCTAssertEqual(mainVM.recipes.first?.name, "New Recipe")
    }
}
