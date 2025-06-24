///`SavedRecipeListCardView.swift` – this is the horizontal acrd used in the saved recipe view.  It shows the recipe image, title , cusine and a bookmark icon that can unsave the saved recipe.
//  FetchaBite
//
//  Created by Alexis
//

import SwiftUI

struct SavedRecipeListCardView: View {
    let recipe: Recipe
    let showBookmark: Bool
    let isSaved: Bool
    let onToggleSave: (()-> Void)?
    
    
    var body: some View{
        ZStack(alignment: .bottomTrailing) {
            
            HStack(spacing: 0) {
                // I Prefer the small image URL if available, else it fallbacks to the large one it also shows a placeholder if it's missing
                if let url = recipe.photoUrlSmall ?? recipe.photoUrlLarge {
                    CachedAsyncImage( url: url, placeholder: { AnyView(Image("NoImage").resizable().scaledToFill()) },
                                           content: { image in AnyView(image.resizable().scaledToFill()) }
                                     )
                                        .frame(width: 70, height: 70)
                                        .clipShape(RoundedRectangle(cornerRadius: 6))
                                        .padding(.vertical, 6)
                                        .padding(.horizontal, 8)
                                } else {
                                    Image("NoImage")
                                        .resizable()
                                        .scaledToFill()
                                }
                                    VStack(alignment:. leading, spacing:4) {
                                        Text(recipe.name)
                                            .font(.custom("Syne-Regular", size: 16, relativeTo: .headline))
                                            .foregroundStyle(Color("BrandColor"))
                                            .lineLimit(2)
                                        
                                        Text(recipe.cuisine)
                                            .font(.custom("Syne-Medium", size: 12, relativeTo: .caption))
                                            .foregroundStyle(Color("SecondaryText"))
                                            .lineLimit(2)
                                    }
                                     .padding(.horizontal, 10)
                                        Spacer()
            }
                if showBookmark , let onToggleSave = onToggleSave {
                    Button(action: onToggleSave) {
                            Image(systemName: isSaved ? "bookmark.fill" : "bookmark")
                                  .resizable()
                                  .aspectRatio(contentMode: .fit)
                                  .frame(width: 18, height: 18)
                                  .foregroundStyle(Color("BrandColor"))
                    }
                    .padding(8)
                }
        }
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 6))
        .shadow(color: .black.opacity(0.07), radius: 3, x: 0, y: 2)
        .padding(.horizontal, 12)
        .padding(.vertical, 6)
    }
}


#Preview {
    ListCardPreviewWrapper()
}
