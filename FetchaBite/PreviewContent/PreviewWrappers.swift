///`PreviewWrappers.swift` –  this file wraps SwiftUi views with preview data and enviormental objects
//  FetchaBite
//
//  Created by Alexis 
//

import SwiftUI
// A preview wrapper for SavedRecipesView its injected with mock ViewModels
struct SavedRecipesPreviewWrapper: View {
    let savedVM = makePreviewSavedRecipesViewModel()
    var body: some View {
        SavedRecipesView()
            .environmentObject(MockHomeViewModel())
            .environmentObject(savedVM)
    }
}

// A preview wrapper for TabBarView with state to test tab switching and the add fullcover sheet
struct TabBarPreviewWrapper: View {
    @State private var selectedTab: Int = 0
    @State private var addActive = false
   
    var body: some View {
        ZStack {
            Color("offwhite").ignoresSafeArea()
            VStack {
                Spacer()
                
                TabBarView(selectedTab: $selectedTab, showAddSheet: $addActive)
            }
        }
    }
    
}

// A preview wrapper that shows a sample RecipeGridCardView
    
struct GridCardPreviewWrapper: View {
    let recipes = loadMockRecipes()
    
    var body: some View {
        ZStack {
            Color("AppBackground").ignoresSafeArea()
            if let recipe = recipes.first {
                RecipeGridCardView(
                    recipe: recipe,
                    isSaved: false,
                    onToggleSave: {}
                )
            }
        }
    }
    
}

// A preview wrapper that shows a SavedRecipeListCardView
struct ListCardPreviewWrapper: View {
    @State private var isSaved = false
    let recipes = loadMockRecipes()
   
    var body: some View {
        if let recipe = recipes.first {
            SavedRecipeListCardView(
                recipe: recipe,
                showBookmark: true,
                isSaved: isSaved,
                onToggleSave: { isSaved.toggle() }
            )
        } else {
            Text("No recipes found in MockRecipes.json!")
        }
        
    }
}

