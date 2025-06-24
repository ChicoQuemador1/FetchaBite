///`TabBarView.swift` –  My custom tab bar UI! that overlays the SwiftUI TabView, but still uses its logic behind the scenes.
//  FetchaBite
//
//  Created by Alexis 
//

import SwiftUI

struct TabBarView: View {
    @Binding var selectedTab: Int
    @Binding var showAddSheet: Bool
    
    var body: some View {
        HStack {
            customTabBar(icon: "house", filled: "house.fill", index: 0, label: "Home")
            addButton()
            customTabBar(icon: "bookmark", filled: "bookmark.fill", index: 2, label: "Saved")
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 24)
        .background(Color("BrandColor"))
        .cornerRadius(20)
        .clipShape(RoundedRectangle(cornerRadius:10))
        .shadow(color: .black.opacity(0.13), radius: 20, y: 8 )
        .padding(.horizontal, 16)
        .padding(.bottom, 0)
    }

func customTabBar(icon: String, filled:String, index: Int, label: String) -> some View {
    Button(action: { selectedTab = index }) {
        VStack (spacing : 4) {
            if selectedTab == index {
                Image(systemName: filled)
                     .font(.system(size:22, weight: .semibold))
                     .foregroundStyle(Color("PrimaryText"))
            } else {
                Image(systemName: icon)
                      .font(.system(size:22, weight: .semibold))
                      .foregroundStyle(.gray)
            }
                Text(label)
                .font(.custom("Syne-Bold", size: 12, relativeTo: .caption))
                .foregroundStyle(selectedTab == index ? Color("PrimaryText")  : .gray)
        }
        .frame(maxWidth: .infinity)
    }
}
    
    
func addButton() -> some View {
    let isActive = showAddSheet
    return Button(action: { showAddSheet = true }) {
        VStack(spacing: 4) {
            if isActive {
                Image(systemName: "rectangle.stack.fill.badge.plus")
                      .font(.system(size:22, weight: .semibold))
                      .foregroundStyle(Color("BrandColorYellow"))
            } else {
                Image(systemName: "rectangle.stack.badge.plus")
                      .font(.system(size:22, weight: .semibold))
                      .foregroundStyle(Color("BrandColorYellow"))
            }
                Text("Add Recipe")
                     .font(.custom("Syne-Bold", size: 12, relativeTo: .caption))
                     .foregroundStyle(isActive ? Color("BrandColorYellow"): Color("BrandColorYellow"))
            }
            .frame(maxWidth: .infinity)
        }
    }
}

#Preview {
    TabBarPreviewWrapper()
}


