///`ContentView.swift`  –   Hosts the main Tab bar which lets the user bounce between Home, Add a Recipe, and Saved tabs.
//  FetchaBite
//
//  Created by Alexis 
//

import SwiftUI

struct ContentView: View {
        @State private var selectedTab = 0
        @State private var showAddSheet = false
        @State var selectedCategory: CategorySelection?
    // Here is where the three main screens are plugged into the tab bar.
        var body: some View {
            NavigationStack {
                ZStack {
                    TabView(selection: $selectedTab) {
                        HomeView(selectedCategory: $selectedCategory)
                            .tag(0).toolbar(.hidden, for: .tabBar)
                        SavedRecipesView()
                            .tag(2).toolbar(.hidden, for: .tabBar)
                    }
                    VStack {
                        Spacer()
                        TabBarView(selectedTab: $selectedTab, showAddSheet: $showAddSheet)
                    }
                }
                .sheet(isPresented: $showAddSheet) {
                    AddRecipeView()
                }
                .navigationDestination(item: $selectedCategory) { category in
                    RecipeGridView(title: category.title, imageUrl: category.imageUrl,isDessertType: category.isDessertType)
                }
            }
        }
    }

#Preview {
    ContentView()
        .environmentObject(MockHomeViewModel() as HomeViewModel)
        .environmentObject(makePreviewSavedRecipesViewModel())
}


