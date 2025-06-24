///`HomeViewModelTests.swift` –  this tests the logic of the HomeViewModel. This covers recipe loading, filtering by cuisine or dessert category, and keyword extraction.
//  FetchaBiteTests
//
//  Created by Alexis
//

import XCTest
@testable import FetchaBite

final class HomeViewModelTests: XCTestCase {

    // Helper to load mock recipes from bundled JSON for use in all my tests
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

    struct StubRecipeService: RecipeServiceProtocol {
        var result: Result<[Recipe], ServiceError>
        
    func getJSON() async throws -> [Recipe] {
            try result.get()
        }
    }

    func testLoadRecipesSuccessSetsRecipes() async {
        let dummyRecipes = loadMockRecipes()
       
        let stubService = StubRecipeService(result: .success(dummyRecipes))
        
        let viewModel = HomeViewModel(service: stubService)
        
        await viewModel.loadRecipes()
            XCTAssertEqual(viewModel.recipes, dummyRecipes)
            XCTAssertNil(viewModel.error)
            XCTAssertFalse(viewModel.isLoading)
    }

    func testFilteredRecipesByCuisine_MockData() {
        let recipes = loadMockRecipes()
        
        let viewModel = HomeViewModel()
            viewModel.recipes = recipes

        let allCuisines = Set(recipes.map { $0.cuisine })
        
        for cuisine in allCuisines {
            
            let filtered = viewModel.filteredRecipes(byCuisine: cuisine)
                XCTAssertTrue(filtered.allSatisfy { $0.cuisine == cuisine })
        }
        // It filters by a non-existent cuisine and it should return an empty array
        let filteredNone = viewModel.filteredRecipes(byCuisine: "NonexistentCuisine")
            XCTAssertTrue(filteredNone.isEmpty)
    }

    func testFilteredRecipesByDessertType_MockRecipes() {
        let recipes = loadMockRecipes()
        
        let viewModel = HomeViewModel()
            viewModel.recipes = recipes

        // All the returned desserts should match the provided dessert keyword
        let cakeDesserts = viewModel.filteredRecipes(byDessertType: "Cake")
            XCTAssertTrue(cakeDesserts.allSatisfy { $0.name.localizedCaseInsensitiveContains("Cake") })

        
        let pieDesserts = viewModel.filteredRecipes(byDessertType: "Pie")
            XCTAssertTrue(pieDesserts.allSatisfy { $0.name.localizedCaseInsensitiveContains("Pie") })

        
        let fakeDesserts = viewModel.filteredRecipes(byDessertType: "NotADessertType")
            XCTAssertTrue(fakeDesserts.isEmpty)
    }

    func testExtractTypeIdentifiesDessertKeyword() {
        let viewModel = HomeViewModel()
        // Should find "Cake" in the recipe name as a dessert. SO it should return nil for "Salad".
            XCTAssertEqual(viewModel.extractDessertType(from: Recipe(
                cuisine: "American", name: "Strawberry Cake", photoUrlLarge: nil, photoUrlSmall: nil, uuid: "u", sourceUrl: nil, youtubeUrl: nil)), "Cake")
            XCTAssertNil(viewModel.extractDessertType(from: Recipe(
                cuisine: "American", name: "Salad", photoUrlLarge: nil, photoUrlSmall: nil, uuid: "w", sourceUrl: nil, youtubeUrl: nil)))
    }
}
