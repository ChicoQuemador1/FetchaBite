///`HeaderView.swift` – my main banner that is used across two views. (HomeView and SavedRecipesView)
//  FetchaBite
//
//  Created by Alexis
//

import SwiftUI

struct HeaderView: View {
    let title: String
    let imageName: String?

    init(title: String, imageName: String? = nil) {
        self.title = title
        self.imageName = imageName
    }
        var body: some View {
            ZStack {
            Color("BrandColor")
                .ignoresSafeArea(edges: .top)
                
            HStack(spacing: 8) {
                Spacer()
                Text(title)
                    .font(.custom("Syne-Bold", size: 30, relativeTo: .title))
                    .foregroundStyle(Color("PrimaryText"))
                
                if let imageName = imageName {
                    Image(imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 32, height: 32)
                        .padding(.bottom, 2)
                }
                Spacer()
            }
        }
        .frame(height: 44) 
        .shadow(color: .black.opacity(0.10), radius: 18, y: 8)
    }
}

#Preview {
    VStack(spacing: 0) {
        HeaderView(title: "Fetch a Bite", imageName: "LaunchLogo")
        Spacer()
        Color("Background").ignoresSafeArea()
    }
}
