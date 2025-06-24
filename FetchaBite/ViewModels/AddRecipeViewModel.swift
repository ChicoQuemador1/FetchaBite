///`AddRecipeViewModel.swift` –  this handles the logic behind the Add Recipe form.  It validates user input, passes it to the HomeViewModel, and resets state on success.
//  FetchaBite
//
//  Created by Alexis
//

import Foundation
import SwiftUI

class AddRecipeViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var cuisine: String = ""
    @Published var photoUrl: String = ""
    @Published var sourceUrl: String = ""
    @Published var youtubeUrl: String = ""
    @Published var error: ServiceError? = nil
    @Published var showAlert: Bool = false
    
var recipeVM: HomeViewModel?
    // All cuisines found in the current recipe list. This is used for the picker
    var allCuisines: [String] {
        let apiCuisines = Set(recipeVM?.recipes.map { $0.cuisine } ?? [])
            return Array(apiCuisines).sorted()
    }
    // Validates form input and tries to add the recipe to the HomeViewModel and thows error alert if validation fails,  SO resets form on success
    func saveRecipe() -> Bool {
        guard let recipeVM = recipeVM else { return false }
              
              let result = recipeVM.addRecipe(
                    name: name,
                    cuisine: cuisine,
                    photoUrl: photoUrl,
                    sourceUrl: sourceUrl,
                    youtubeUrl: youtubeUrl
        )
        // HomeViewModel returns a service rrror if validation fails otherwise it adds the recipe
        if let error = result {
            self.error = error
            self.showAlert = true
            return false
        }
        self.reset()
            return true
    }
    // Resets all form fields and error states
    func reset() {
        name = ""
        cuisine = ""
        photoUrl = ""
        sourceUrl = ""
        youtubeUrl = ""
        error = nil
        showAlert = false
    }
}


extension AddRecipeViewModel {
    // Shows a error message  for display in alerts
    var errorMessage: String {
        if let error = error, case .invalidData(let msg) = error {
            return msg
        }
        return "Unknown error"
    }
}
