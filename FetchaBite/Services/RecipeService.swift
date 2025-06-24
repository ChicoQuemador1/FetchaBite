///`RecipeService.swift` –  this handles downloading recipe data from the API. It also makes an async network call, decodes the JSON, and returns a list of `Recipe` objects.
//  FetchaBite
//
//  Created by Alexis 
//



import Foundation

protocol RecipeServiceProtocol {
    func getJSON() async throws -> [Recipe]
}

enum ServiceError: Error, LocalizedError, Equatable {
    case invalidURL
    case invalidResponse
    case failedtoDecodeData(String)
    case malformedData
    case empty
    case invalidData(String)

    var errorDescription: String? {
        
        switch self {
       case .invalidURL: return "The endpoint URL that you're using is invalid"
        case .invalidResponse: return "Failed to issue a valid HTTP response:"
        case .failedtoDecodeData(let string): return "Failed to read the data: \(string)"
        case .malformedData: return "The data provided appears to be malformed"
        case .empty: return "There seems to be no recipes :("
        case .invalidData(let string): return string
        }
        
    }
}


class RecipeService: RecipeServiceProtocol {
    private let baseURL: URL

    init(baseURL: URL? = nil) {
        self.baseURL = baseURL ?? URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json")!
    }
    // It downloads the latest recipes from the remote API and throws if the response is bad or can’t decodes and on success it returns a fresh [Recipe]
    func getJSON() async throws -> [Recipe] {
        let url = baseURL
       
        let (data, response) = try await URLSession.shared.data(from: url)
       
        guard let response = response as? HTTPURLResponse,
              (200..<300).contains(response.statusCode)
        else {
            // Throws if, if I didn’t get a good (2xx) HTTP response
            throw ServiceError.invalidResponse
        }
      
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let recipeListResponse = try decoder.decode(
                RecipesResponse.self,
                from: data
            )
            return recipeListResponse.recipes
        } catch {
            // Wraps the JSON decoder errors with my custom error
            throw ServiceError.failedtoDecodeData(error.localizedDescription)
        }
    }
}
