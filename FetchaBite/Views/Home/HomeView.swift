/// `HomeView.swift` –   The main screen for exploring shared recipes.  It shows a hero banner, category carousels and lets users refresh the list or tap into categories.
//  FetchaBite
//
//  Created by Alexis
//
import SwiftUI

struct HomeView: View {
    @EnvironmentObject var recipeVM: HomeViewModel
    @Binding var selectedCategory: CategorySelection?
    @State private var showErrorAlert = false

    public init(selectedCategory: Binding<CategorySelection?>) {
        self._selectedCategory = selectedCategory
    }

        var body: some View {
            VStack(spacing: 0) {
                HeaderView(title: "Fetch a Bite", imageName: "LaunchLogo")
                Spacer().frame(height: 3)
                
                ZStack(alignment: .bottom) {
                    Image("Hero")
                        .resizable()
                        .scaledToFill()
                        .frame(height: 300)
                        .clipped()
                    LinearGradient(gradient: Gradient(colors: [Color.black.opacity(0.45), .clear]),
                               startPoint: .bottom, endPoint: .top)
                        .frame(height: 120)
                        .frame(maxWidth: .infinity)
                        .clipped()
                    
                    Text("Discover Shared Recipes & Share Yours Too!")
                        .font(.custom("Lexend-Medium", size: 16, relativeTo: .headline))
                        .foregroundStyle(Color.white)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.bottom, 40)
                        .multilineTextAlignment(.center)
                }
                
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 6) {
                        CategoryRowView(title: "Cuisines", cards: recipeVM.cuisineCategories) { card in
                            // Finds the first recipe matching the cuisine to grab images for the cards
                            if let recipe = recipeVM.recipes.first(where: { $0.cuisine == card.title }) {
                                selectedCategory = CategorySelection(
                                    title: card.title,
                                    imageUrl: recipe.photoUrlLarge,
                                    isDessertType: false
                                )
                            }
                        }
                       
                        CategoryRowView(title: "Desserts & Baking", cards: recipeVM.dessertTypeCategories) { card in
                            // Finds the first recipe that matches the dessert type to grab images for the cards
                            if let recipe = recipeVM.recipes.first(where: { recipeVM.extractDessertType(from: $0) == card.title }) {
                                selectedCategory = CategorySelection(
                                    title: card.title,
                                    imageUrl: recipe.photoUrlLarge,
                                    isDessertType: true
                                )
                            }
                        }
                    }
                    .padding(.vertical, 16)
                }
                .refreshable {
                    await recipeVM.loadRecipes()
                }
                .background(Color("Background"))
            }
            .background(Color("Background").ignoresSafeArea())
            // It fetches the latest recipes from the service
            .task {
                await recipeVM.loadRecipes()
            }
            // If the error changes it shows the alert
            .onChange(of: recipeVM.error) { newValue, _ in showErrorAlert = newValue != nil}
            .alert("Something went wrong", isPresented: $showErrorAlert,
                   actions: { Button("OK") { recipeVM.error = nil } },
                   message: { Text(recipeVM.error?.localizedDescription ?? "Unknown error") })}
}

#Preview {
    HomeView(selectedCategory: .constant(nil))
        .environmentObject(MockHomeViewModel() as HomeViewModel)
}
