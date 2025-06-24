///`AddRecipeView.swift` –  this is the form interface for adding a new recipe to the app
//  FetchaBite
//
//  Created by Alexis 
//


import SwiftUI


struct CustomField: View {
    let title: String
    let systemImage: String
    var keyboardType: UIKeyboardType = .default
    
    @Binding var text: String

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.custom("Syne-SemiBold", size: 16, relativeTo: .headline))
                .foregroundStyle(Color("PrimaryText"))
            
            HStack {
                Image(systemName: systemImage)
                    .foregroundStyle(Color("SecondaryText"))
                TextField(" ", text: $text)
                    .font(.custom("Syne-Medium", size: 16, relativeTo: .body))
                    .foregroundStyle(Color("SecondaryText"))
                    .keyboardType(keyboardType)
                    .tint(Color("SecondaryText"))
            }
            .padding()
            .background(Color("Background"))
            .cornerRadius(10)
        }
        
    }
}

struct AddRecipeView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var recipeVM: HomeViewModel
    
    @StateObject private var addRecipeVM = AddRecipeViewModel()
    
    @State private var backPressed = false
    @FocusState private var focusedField: Field?
    
    enum Field { case name, cuisine, photoUrl, sourceUrl, youtubeUrl }

        var body: some View {
            NavigationView {
                
                ScrollView {
                    VStack(spacing: 20) {
                        VStack(alignment: .leading, spacing: 12) {
                                CustomField(
                                    title: "Name",
                                    systemImage: "fork.knife",
                                    text: $addRecipeVM.name
                                )
                                 .focused($focusedField, equals: .name)
                            
                                    Text("Cuisine")
                                        .font(.custom("Syne-SemiBold", size: 16, relativeTo: .headline))
                                        .foregroundStyle(Color("PrimaryText"))
                            // User can only pick from the preset list of cuisines since I don't have a custom options yet
                        Menu {
                            ForEach(addRecipeVM.allCuisines, id: \.self) { c in
                                Button(action: {
                                    addRecipeVM.cuisine = c
                                }) {
                                    HStack {
                                        Image(systemName: addRecipeVM.cuisine == c ? "checkmark.rectangle.stack.fill" : "checkmark.rectangle.stack")
                                            .foregroundStyle(Color("Submit"))
                                        Text(c)
                                            .foregroundStyle(Color("SecondaryText"))
                                    }
                                }
                            }
                        } label: {
                           
                            HStack {
                                Text(addRecipeVM.cuisine.isEmpty ? (addRecipeVM.allCuisines.first ?? "Select") : addRecipeVM.cuisine)
                                    .foregroundStyle(Color("SecondaryText"))
                                    .font(.custom("Syne-SemiBold", size: 16))
                                Spacer()
                                Image(systemName: "chevron.up.chevron.down")
                                    .foregroundStyle(Color("SecondaryText"))
                            }
                            .padding()
                            .background(Color("Background"))
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color("Background"), lineWidth: 1.5)
                            )
                        }
                        
                        .frame(maxWidth: .infinity)

                                CustomField(
                                    title: "Image URL",
                                    systemImage: "photo",
                                    keyboardType: .URL, text: $addRecipeVM.photoUrl
                                )
                                .focused($focusedField, equals: .photoUrl)

                                CustomField(
                                    title: "Source URL",
                                    systemImage: "link",
                                    keyboardType: .URL, text: $addRecipeVM.sourceUrl
                                )
                                .focused($focusedField, equals: .sourceUrl)

                                CustomField(
                                    title: "YouTube URL",
                                    systemImage: "play.rectangle",
                                    keyboardType: .URL, text: $addRecipeVM.youtubeUrl
                                )
                                .focused($focusedField, equals: .youtubeUrl)
                    }
                    .padding(.top, 18)
                    .padding(.horizontal, 20)
                    Spacer()
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Information 🔍")
                            .font(.custom("Syne-SemiBold", size: 16, relativeTo: .headline))
                            .foregroundStyle(Color("BrandColor"))
                            .frame(maxWidth: .infinity, alignment: .center)
                            
                            Text("""
                            • Each recipe needs a name, a cuisine, and **either** a source website link or a YouTube video link.
                            • You can only pick from the list of given cuisines for now custom cuisines aren’t supported (yet 😉). 
                            • All links must start with http:// or https:// to work
                            • Currently, there’s no way to pick an image from your gallery (yet 😉). 
                            • The image link is optional though. If you leave it blank, a default “No Image” will be shown.
                            • Your new recipe will show up instantly in the main list!
                            • Once you add a recipe, you can’t delete it (for now 😉).
                            """)
                            .font(.custom("Syne-Medium", size: 12, relativeTo: .body))
                            .foregroundStyle(Color("SecondaryText"))
                            .multilineTextAlignment(.leading)
                            .frame(maxWidth: .infinity, alignment: .center)
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color("Background"))
                        .cornerRadius(18)
                        .padding(.horizontal, 16)
                        .padding(.bottom, 18)
                    }
            }
            .background(Color("BrandColor"))
            .ignoresSafeArea(.keyboard, edges: .bottom)
            .navigationBarTitleDisplayMode(.inline)
            
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        backPressed = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                        
                        backPressed = false
                        dismiss()}
                    }) {
                        Image(systemName: backPressed ? "arrowshape.turn.up.backward.fill" : "arrowshape.turn.up.backward")
                            .font(.system(size: 20))
                            .foregroundStyle(Color("Cancel"))
                        }
                }
                
                ToolbarItem(placement: .principal) {
                    Text("Add a Recipe")
                        .font(.custom("Syne-Bold", size: 30, relativeTo: .title))
                        .foregroundStyle(Color("BrandColorYellow"))
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        // Save the recipe and close it if successful
                        if addRecipeVM.saveRecipe() {
                            dismiss()
                        }
                    }) {
                        Image(systemName: backPressed ? "checkmark.rectangle.stack.fill" : "checkmark.rectangle.stack")
                            .font(.system(size: 20))
                            .foregroundStyle(Color("Submit"))
                    }
                }
            }
                // Pre selects the first available cuisine if ther is none it sets it so it prvents blanks
            .onAppear {
                addRecipeVM.recipeVM = recipeVM
               
                if addRecipeVM.cuisine.isEmpty, let firstCuisine = addRecipeVM.allCuisines.first {
                    addRecipeVM.cuisine = firstCuisine
                }
            }
            
            .alert(isPresented: $addRecipeVM.showAlert) {
                Alert(
                    title: Text("Invalid Entry"),
                    message: Text(addRecipeVM.errorMessage),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }
}



#Preview {
    AddRecipeView()
        .environmentObject(MockHomeViewModel() as HomeViewModel)
}
