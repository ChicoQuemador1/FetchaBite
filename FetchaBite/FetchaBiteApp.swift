///`FetchaBiteApp` –  This is the app’s entry point. It sets up environment objects and launches the main UI !!!!!
//  FetchaBite
//
//  Created by Alexis 
//

import SwiftUI

@main
struct FetchaBiteApp: App {
        @StateObject private var recipeVM = HomeViewModel()
        @StateObject private var savedRecipeVM = SavedRecipesViewModel()
        
        var body: some Scene {
                WindowGroup {
                    ContentView()
                        .environmentObject(savedRecipeVM)
                        .environmentObject(recipeVM)
                        .preferredColorScheme(.light)
                }
        }
}
