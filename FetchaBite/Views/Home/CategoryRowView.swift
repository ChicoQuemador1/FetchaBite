///`CategoryRowView.swift` –  this dispalys a horizontal scroll row of tappable category cards
//  FetchaBite
//
//  Created by Alexis 
//

import SwiftUI

struct CategoryRowView: View {
    let title: String
    let cards: [Category]
    let onSelect: (Category) -> Void
            
        var body: some View {
            VStack(alignment: .leading, spacing: 4) {
                
                ZStack(alignment: .center) {
                    Divider()
                        .background(Color("BrandColor").opacity(0.13))
                    
                    Text(title.uppercased())
                        .font(.custom("Syne-SemiBold", size: 18))
                        .foregroundStyle(Color("BrandColor"))
                        .padding(.horizontal, 8)
                        .background( RoundedRectangle(cornerRadius: 6)
                            .fill(Color("Background"))
                        )
                }
                
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(spacing: 12) {
                        // Tapping this card calls the parent's on select closure with the chosen category
                        ForEach(cards) { card in
                            Button(action: { onSelect(card) }) {
                                CategoryCardView(title: card.title, imageUrl: card.imageUrl)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .padding(.horizontal, 12)
                    .frame(minWidth: UIScreen.main.bounds.width, alignment: .leading)
                }
                
            }
        
        }
}


#Preview {
    CategoryRowView(
        title: "Cuisines",
        cards: [
            
            Category(
                title: "Malaysian",
                imageUrl: URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg")
            ),
            Category(
                title: "British",
                imageUrl: URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/535dfe4e-5d61-4db6-ba8f-7a27b1214f5d/small.jpg")
            ),
            Category(
                title: "American",
                imageUrl: URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b6efe075-6982-4579-b8cf-013d2d1a461b/small.jpg")
            ),
            Category(
                title: "Canadian",
                imageUrl: URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/3b33a385-3e55-4ea5-9d98-13e78f840299/small.jpg")
            ),
            Category(
                title: "French",
                imageUrl: URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/ec155176-ebb3-4e83-a320-c5c1d8d0c559/small.jpg")
            )
            
        ],
        onSelect: { _ in }
    )
    .background(Color("Background"))
}
