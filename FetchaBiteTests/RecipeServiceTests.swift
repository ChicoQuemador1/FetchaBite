///`RecipeServiceTests.swift` –  the unit tests for the RecipeService network layer. this covers success and failure cases when fetching or decoding recipes from API responses.
//  FetchaBiteTests
//
//  Created by Alexis
//

import XCTest
@testable import FetchaBite

final class RecipeServiceTests: XCTestCase {
    private var service: RecipeService!

    override func setUp() {
        
        super.setUp()
        service = RecipeService()
    }

    override func tearDown() {
    service = nil
        super.tearDown()
    }
    // Should succeed and return an empty list when the endpoint returns an empty JSON array
    func  testFetchRecipes_withEmptyDataResponse() {
        let emptyURL = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-empty.json")!
            service = RecipeService(baseURL: emptyURL)
       
        let expectation = self.expectation(description: "Fetch empty recipes")
       
        
        Task {
            do {
                let recipes = try await service.getJSON()
                XCTAssertTrue(recipes.isEmpty, "Expected no recipes for empty JSON response")
            } catch {
                XCTFail("Expected empty recipes list, but got an error: \(error)")
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5.0)
    }
    // If it gets here, parsing didn't fail
    func testFetchRecipes_withMalformedDataResponse() {
        let badURL = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-malformed.json")!
            service = RecipeService(baseURL: badURL)
       
    let expectation = self.expectation(description: "Fetch malformed JSON")
        Task {
            do {
                let _ = try await service.getJSON()
                XCTFail("Expected parsing to fail for malformed JSON, but got recipes")
            } catch {
                XCTAssertTrue(error is ServiceError, "Expected a ServiceError for malformed JSON, got \(error)")
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5.0)
    }

    func testDecodeValidRecipes() throws {
        let mockJSONURL = Bundle.main.url(forResource: "MockRecipes", withExtension: "json")
            XCTAssertNotNil(mockJSONURL, "MockRecipes.json not found in bundle")
        
        let data = try Data(contentsOf: mockJSONURL!)
       
        let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
       
        let result = try decoder.decode(RecipesResponse.self, from: data)
            XCTAssertTrue(result.recipes.count >= 1, "Expected at least 1 recipe in JSON")
      
        
        let firstRecipe = result.recipes.first
            XCTAssertEqual(firstRecipe?.name, "Apam Balik")
            XCTAssertEqual(firstRecipe?.cuisine, "Malaysian")
           XCTAssertNotNil(firstRecipe?.photoUrlLarge)
            XCTAssertTrue(firstRecipe?.photoUrlLarge?.absoluteString.hasSuffix(".jpg") ?? false)
    }
    // Decoding an object should throw a decoding error. this tests that the error is thrown.
    func testDecodeMalformedDataThrowsError() {
        let malformedJSON = Data("{}".utf8)
       
        let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
        XCTAssertThrowsError(try decoder.decode(RecipesResponse.self, from: malformedJSON)) { error in
            XCTAssertTrue(error is DecodingError)
        }
    }
    
}

