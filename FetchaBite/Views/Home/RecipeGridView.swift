/// `RecipeGridView.swift` – this displays a grid of recipes filtired by eiher cusine or a dessrt category
//  FetchaBite
//
//  Created by Alexis
//

import SwiftUI

struct RecipeGridView: View {
    let title: String
    let imageUrl: URL?
    let isDessertType: Bool

    @EnvironmentObject var recipeVM: HomeViewModel
    @EnvironmentObject var savedRecipeVM: SavedRecipesViewModel

    // Shows either desserts or cuisines based on what the user tapped
    var filteredRecipes: [Recipe] {
        if isDessertType {
            return recipeVM.filteredRecipes(byDessertType: title)
        } else {
            return recipeVM.filteredRecipes(byCuisine: title)
        }
    }

        var body: some View {
            ZStack(alignment: .top) {
                Color("Background").ignoresSafeArea()
                    ScrollView {
                        VStack(spacing: 0) {
                                Spacer().frame(height: 4)
                            
                        ZStack {
                            if let imageUrl {
                                CachedAsyncImage(url: imageUrl,
                                                placeholder: { AnyView(Color.gray.opacity(0.15)) },
                                                content: { image in AnyView(image.resizable().scaledToFill()) }
                                    )
                                } else {
                                    Color.gray.opacity(0.15)
                                }
                                
                        VStack {
                            Spacer()
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    Color.black.opacity(0.47),
                                    Color.black.opacity(0.25),
                                    .clear,
                                ]),
                                startPoint: .bottom,
                                endPoint: .top
                            )
                            .frame(height: 110)
                        }
                                
                        VStack {
                            Spacer()
                            Text(title)
                                .font(.custom("Syne-SemiBold", size: 32))
                                .foregroundStyle(.white)
                                .shadow(color: .black.opacity(0.45), radius: 7, y: 2)
                                .multilineTextAlignment(.center)
                                .padding(.bottom, 32)
                        }
                        .frame(height: 230)
                    }
                    .frame(height: 230)
                    .clipped()
                    Spacer().frame(height: 26)
                    LazyVGrid(
                        columns: [
                            GridItem(.fixed(175), spacing: 12),
                            GridItem(.fixed(175), spacing: 12),
                        ],
                        spacing: 24
                    ) {
                        ForEach(filteredRecipes) { recipe in
                            // Tapping a card opens the detail view for this recipe
                            NavigationLink(destination: RecipeDetailsView(recipe: recipe)) {
                                
                                RecipeGridCardView(
                                    recipe: recipe,
                                    isSaved: savedRecipeVM.isRecipeSaved(recipe: recipe),
                                    onToggleSave: { savedRecipeVM.toggleSave(recipe: recipe) } )
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                    }
                    .padding(.horizontal, 24)
                    .padding(.bottom, 40)
                }
            }
            .refreshable {
                await recipeVM.loadRecipes()
            }
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text(isDessertType ? "Desserts & Baking" : "Cuisine")
                    .font(.custom("Syne-Bold", size: 20, relativeTo: .title))
                    .foregroundStyle(Color("PrimaryText"))
            }
        }
        .toolbarBackground(Color("BrandColor"), for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    let recipes = loadMockRecipes()
    RecipeGridView(
        title: "American",
        imageUrl: recipes.first?.photoUrlLarge,
        isDessertType: false
    )
    .environmentObject(MockHomeViewModel() as HomeViewModel)
    .environmentObject(makePreviewSavedRecipesViewModel())
}
