///`CategoryCardView.swift` –  this displays an image and title representing a cuisne or dessert category card
//  FetchaBite
//
//  Created by Alexis 
//

import SwiftUI
    
struct CategoryCardView: View {
    let title: String
    let imageUrl: URL?
    
        var body: some View {
            VStack {
                // If I have an image URL, show the image from the web or else it shows a placeholder
                if let url = imageUrl {
                CachedAsyncImage( url: url, placeholder: { AnyView( Image("NoImage").resizable().aspectRatio(1, contentMode: .fill)) },
                                            content: { image in AnyView( image.resizable().aspectRatio(1, contentMode: .fill)) }
                                )
                                .frame(width:  104, height: 104)
                                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                                .shadow(color: Color.black.opacity(0.12), radius: 12, y: 6)
                } else {
                    Image("NoImage")
                        .resizable()
                        .aspectRatio(1, contentMode: .fill)
                }
                    Text(title.capitalized)
                        .font(.custom("Syne-Medium", size: 12, relativeTo: .caption))
                        .foregroundStyle(Color("SecondaryText"))
                        .lineLimit(1)
            }
            .frame(width: 104)
            .padding(.vertical, 4)
        }
}




#Preview {
    CategoryCardView(
        title: "Malaysian",
        imageUrl: URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg")
    )
    .background(Color("Background"))
}


