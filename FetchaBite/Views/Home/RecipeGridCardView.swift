///`RecipeGridCardView.swift` –  this displays a individual recipe gird card within the grid view
//  FetchaBite
//
//  Created by Alexis 
//

import SwiftUI

struct RecipeGridCardView: View {
    let recipe: Recipe
    let isSaved: Bool
    let onToggleSave: () -> Void

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            
            VStack(alignment: .leading, spacing: 0) {
                if let url = recipe.photoUrlLarge ?? recipe.photoUrlSmall {
                    CachedAsyncImage(
                        url: url,
                        placeholder: {
                            AnyView(Image("NoImage")
                                .resizable()
                                .scaledToFill())
                        },
                        content: { image in
                            AnyView(image.resizable().scaledToFill())
                        }
                    )
                    .frame(height: 126)
                    .frame(maxWidth: .infinity)
                    .clipped()
                } else {
                    Image("NoImage")
                        .resizable()
                        .scaledToFill()
                }
             
                VStack(alignment: .leading, spacing: 8) {
                    Text(recipe.name)
                        .font(.custom("Syne-Regular", size: 16, relativeTo: .headline))
                        .foregroundStyle(Color("BrandColor"))
                        .multilineTextAlignment(.leading)
                        .lineLimit(2)
                        .padding(.top, 8)
                }
                .padding([.leading, .bottom, .trailing], 12)
                .frame(height: 127, alignment: .top)
            }
            Button(action: onToggleSave) {
                // Tap to save or unsave this recipe
                Image(systemName: isSaved ? "bookmark.fill" : "bookmark")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 12, height: 16)
                    .foregroundStyle(Color("BrandColor"))
                    .padding(8)
            }
            .padding([.trailing, .bottom], 12)
        }
        .frame(width: 175, height: 253)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius:6, style: .continuous))
        .shadow(color: .black.opacity(0.09), radius: 12, x: 0, y: 5)
    }
}



#Preview {
    GridCardPreviewWrapper()
}
