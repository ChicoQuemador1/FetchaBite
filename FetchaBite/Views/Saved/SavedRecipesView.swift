///`SavedRecipesView.swift` –  this displays all the bookmarked recipes in one view. this features filter by cusine, a ull to refresh and leads to recipe deatils view.
//  FetchaBite
//
//  Created by Alexis
//

import SwiftUI

struct SavedRecipesView: View {
    @EnvironmentObject var savedRecipeVM: SavedRecipesViewModel
    @EnvironmentObject var recipeVM: HomeViewModel
    @State private var showFilterSheet = false
    @State private var filter: String? = nil
    // Grabs all unique cuisines from the saved recipes to populate the filter function
    var allCuisines: [String] {
        let cuisines = Set(savedRecipeVM.savedRecipes.map { $0.cuisine })
        return Array(cuisines).sorted()
    }
    
    var body: some View {
        VStack (spacing: 0) {
            HeaderView(title: "Saved Recipes")
        Spacer()
            HStack{
                Text("\(savedRecipeVM.filteredRecipes(cuisine: filter).count) Recipes Saved")
                    .font(.custom("Syne-SemiBold", size: 16, relativeTo: .headline))
                    .foregroundStyle(Color("BrandColor"))
                Spacer()
                Button  {
                    showFilterSheet = true
                } label: {
                            HStack(spacing: 4) {
                                Image(systemName: "line.3.horizontal.decrease.circle")
                                Text("Filter")
                                    .font(.custom("Syne-SemiBold", size: 16,  relativeTo: .headline))
                            }
                             .foregroundStyle(Color("BrandColor"))
                    }
            }
            .padding(.horizontal)
            .padding(.vertical,12)
            
            Divider()
            
            ScrollView{
                VStack(spacing:0) {
                    // Show only recipes that match the selected cuisine
                    ForEach(savedRecipeVM.filteredRecipes(cuisine: filter)) {
                        recipe in
                        NavigationLink(destination: RecipeDetailsView(recipe: recipe)) {
                            SavedRecipeListCardView(
                                recipe: recipe,
                                showBookmark: true,
                                isSaved: true,
                                onToggleSave: {savedRecipeVM.toggleSave(recipe: recipe)}
                            )
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                }
            }
            // re-fetches saved recipes in case of any changes
            .refreshable { savedRecipeVM.refresh() }
            .safeAreaInset(edge: .bottom) {
                Color.clear.frame(height: 70)
            }
            Spacer()
        }
        .background(Color("Background").ignoresSafeArea())
        .confirmationDialog("Filter by Cuisine", isPresented: $showFilterSheet, titleVisibility: .visible) {
            Button("All", role: .none) { filter = nil }
            ForEach(allCuisines, id: \.self) { cuisine in
                Button(cuisine) { filter = cuisine }
            }
        }
    }
}

#Preview {
    SavedRecipesPreviewWrapper()
}

