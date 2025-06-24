<h1 align="center"> Fetch a Bite </h1>
 
<p align="center">
  <img src="https://github.com/ChicoQuemador1/Fetch-a-Bite/blob/main/Other/logo.png?raw=true" width="600" alt="Fetch-a-Bite Logo" />
</p>

<p align="center">
  <a href="https://github.com/ChicoQuemador1/Fetch-a-Bite/stargazers">
    <img src="https://img.shields.io/github/stars/ChicoQuemador1/Fetch-a-Bite?color=yellow" alt="Stars Badge"/>
  </a>
  <a href="https://github.com/ChicoQuemador1/Fetch-a-Bite">
    <img src="https://img.shields.io/github/repo-size/ChicoQuemador1/Fetch-a-Bite?color=ff69b4" alt="Repo Size Badge"/>
  </a>
  <br>
  <a href="https://swift.org/">
    <img src="https://img.shields.io/badge/swift-F54A2A?style=for-the-badge&logo=swift&logoColor=white" />
  </a>
  <a href="https://developer.apple.com/xcode/swiftui/">
    <img src="https://img.shields.io/badge/SwiftUI-007aff?style=for-the-badge&logo=swift&logoColor=white" />
  </a>
  <a href="https://developer.apple.com/xcode/">
    <img src="https://img.shields.io/badge/Xcode-1575F9?style=for-the-badge&logo=xcode&logoColor=white" />
  </a>
  <a href="https://developer.apple.com/ios/">
    <img src="https://img.shields.io/badge/iOS-000000?style=for-the-badge&logo=apple&logoColor=white" />
  </a>
</p>

---


## Screenshots:

<p align="center">
  <img src="https://github.com/ChicoQuemador1/Fetch-a-Bite/blob/main/Other/AppScreens/01.png" width="240"/>
  <img src="https://github.com/ChicoQuemador1/Fetch-a-Bite/blob/main/Other/AppScreens/02.png" width="240"/>
  <img src="https://github.com/ChicoQuemador1/Fetch-a-Bite/blob/main/Other/AppScreens/03.png" width="240"/>
</p>
<p align="center">
  <img src="https://github.com/ChicoQuemador1/Fetch-a-Bite/blob/main/Other/AppScreens/04.png" width="240"/>
  <img src="https://github.com/ChicoQuemador1/Fetch-a-Bite/blob/main/Other/AppScreens/05.png" width="240"/>
  <img src="https://github.com/ChicoQuemador1/Fetch-a-Bite/blob/main/Other/AppScreens/06.png" width="240"/>
</p>
<p align="center">
  <img src="https://github.com/ChicoQuemador1/Fetch-a-Bite/blob/main/Other/AppScreens/07.png" width="240"/>
  <img src="https://github.com/ChicoQuemador1/Fetch-a-Bite/blob/main/Other/AppScreens/08.png" width="240"/>
  <img src="https://github.com/ChicoQuemador1/Fetch-a-Bite/blob/main/Other/AppScreens/09.png" width="240"/>
</p>
<p align="center">
  <img src="https://github.com/ChicoQuemador1/Fetch-a-Bite/blob/main/Other/AppScreens/10.png" width="240"/>
  <img src="https://github.com/ChicoQuemador1/Fetch-a-Bite/blob/main/Other/AppScreens/11.png" width="240"/>
  <img src="https://github.com/ChicoQuemador1/Fetch-a-Bite/blob/main/Other/AppScreens/12.png" width="240"/>
</p>

---

## Features: 

- **Browse Recipes by Category:** On the Home tab, swipe through different cuisines such as American, British, or Croatian, and dessert types like Cakes, Cookies, and Pies. Tap any category to see a grid of recipes.
- **Category Grid View:** Each category shows a grid of recipes. Every card displays a recipe photo, name, and bookmark icon if it is saved.
- **Recipe Details Page:**  Tap any recipe card to open a details page that shows the recipe name at the top, along with a segmented picker for viewing the source website or YouTube video. The selected content opens directly in an in-app web view, or you’ll see a warning if the link is insecure or missing.
- **Save Favorites:** Save any recipe by tapping the bookmark icon. Saved recipes are shown with images in the Saved tab.
- **Add Your Own Recipe:** Tap the plus button in the center of the tab bar. Fill in the name, select a cuisine, and enter URLs for an image, source, and video. Your recipe will be added and can be viewed everywhere in the app.
- **Pull-to-Refresh:** Swipe down to refresh recipes in the Home, Recipe Grid, or Saved tabs.
- **Local Persistence and Caching:** Recipes you save are stored locally. Images are cached to the disk so they load quickly and can be viewed offline.
- **Custom Tab Bar:** The app uses SwiftUI’s TabView for navigation, but I built a custom UI overlay on top of it. The tab bar features SF Symbols for Home, Add, and Saved tabs, with a floating plus button in the center for adding new recipes.
- **In-App Web Views:** Source and YouTube links open in a built-in SwiftUI WebView.
- **Filter Saved Recipes:** In the Saved tab, tap the Filter button to filter saved recipes by cuisine.
  
---

## Running the Project:

<pre>
1. <b>Prerequisites:</b> Xcode 14.3+ and iOS 16 SDK. (The project uses SwiftUI NavigationStack, so iOS 16 or higher is required.)
2. <b>Open:</b> Open <code>FetchaBite.xcodeproj</code> in Xcode.
3. <b>Dependencies:</b> No external packages are used. Just build the project (Cmd+B) to fetch Swift packages if any are included (none at the moment).
4. <b>Run:</b> Choose an iOS Simulator or device and hit Run (Cmd+R). The app should launch to the Home tab, where you’ll see horizontal rows of cuisines and dessert categories. Tap any category to view recipes for that section.
5. <b>Adding Recipes:</b> Go to the Add tab (center + button). Fill in all the fields using URLs. Tap the add button to save your recipe.
6. <b>Saving:</b> On Home or in a grid, tap the bookmark icon on a recipe card to save it. In the Saved tab, swipe down to refresh the list.
7. <b>Testing:</b> Run all unit and view model tests with Cmd+U.
</pre>

---


### Focus Areas 

Understanding how the architecture fit together was one of my biggest learning curves on this project. SwiftUI, in particular, was challenging for me from a visual and layout perspective. I spent a lot of time reading documentation, watching YouTube tutorials, and figuring out how to run tests, use the simulator, and even build the project on my phone, which turned out to be a lot of fun. As I got deeper into the project, I actually started to enjoy the complexity and found myself getting excited about new iOS updates, especially after following WWDC for iOS 26, since I really loved working on the UI. I definitely spent more time on the front end than the backend, focusing on making everything look and feel right, but I still made sure to complete everything required for the assignment. Despite those challenges, I tackled all the must-have features, especially the efficient network usage aspect. To meet that goal, I made sure to load images only when needed in the UI to avoid unnecessary bandwidth use, and I built my own custom image caching system to store images on disk and prevent repeated network requests. I implemented all of this from scratch, without relying on any third-party solutions, URLSession’s default cache, or URLCache, just as requested in the assignment.

---


### Time Spent: 

I worked on this project from **May 22nd to June 23rd**, spending around **36 hours** overall a little over an hour to two hours most days, with a few long weekends. I only kinda timed coding and not watching videos and reading to learn. This is an approximation but hers is how that time broke down:

<pre>
| Area                             | Time Spent | Files |
|-----------------------------------|------------|-----------------------------------------------------------------------------------------------|
| Project setup & architecture      | ~3h        | FetchaBiteApp.swift, ContentView.swift, TabBarView.swift                                      
| Networking & Models               | ~4h        | RecipeService.swift, Recipe.swift, MockRecipes.json                                            
| ViewModels & category logic       | ~5h        | HomeViewModel.swift, SavedRecipesViewModel.swift, Category.swift, CategorySelection.swift      
| Image loading & caching           | ~3h        | ImageLoader.swift, ImageCache.swift, CachedAsyncImage.swift                                   
| Add Recipe feature (form/logic)   | ~3h        | AddRecipeViewModel.swift, AddRecipeView.swift                                                 
| Core Screens & navigation         | ~8h        | HomeView.swift, RecipeGridView.swift, CategoryRowView.swift, RecipeDetailsView.swift, HeaderView.swift, CategoryCardView.swift, RecipeGridCardView.swift, SavedRecipeListCardView.swift, SavedRecipesView.swift, RecipeWebView.swift, PreviewWrappers.swift, PreviewMockModels.swift, SavedRecipeListCardView.swift 
| UI polish (fonts, color, MARKs)   | ~3h        | HeaderView.swift, custom fonts, documenting                                                   
| Testing & test data               | ~4h        | AddRecipeViewModelTests.swift, HomeViewModelTests.swift, ImageLoaderTests.swift, RecipeServiceTests.swift, SavedRecipesViewModelTests.swift, PreviewMockModels.swift |
| Code cleanup & README             | ~3h        | All files, doc comments, README.md                                                            
| **Total**                         | **~36h**   |                                                                                               
</pre>


Some days were focused on bug fixes or reviewing videos and documentation, while other days involved long coding sprints. My goal was to demonstrate my ability to write readable and testable code. 

---

### Trade-offs and Decisions:

Honestly, my biggest trade off was just keeping things simple with user defaults for saving recipes. It’s super quick and easy, but I know it’s not built for big apps or anything long term. One downside is that any recipes you add are gone if you close the app, so if this ever became a real product, I’d want to use something like Core Data  for proper persistence and multi person stuff. For figuring out which recipes count as desserts, I just used a keyword check which in short term  gets the job done for now, but I know it could definitely mislabel things, so a better system would be to add explicit tags or categories. The image caching was a whole thing too. I had to build it myself from scratch instead of relying on any default URLCache or third-party tricks like I did for my other projects. It took me a while to figure out, but now I actually get how image caching works behind the scenes, which is pretty cool. Error handling is super basic too, just plain alerts, and there’s no sign-in or user profiles because this is really just a single-user demo. If I had more time, I’d want to add a search bar, more UI feedback, and some accessibility upgrades, but for this project I really focused on getting the core stuff to work smoothly and making the code as clean as I could.

---

### Weakest Part of the Project: 

The weakest part of my project is definitely the Add Recipe view. I did not add a picture picker, so you can only add image URLs instead of uploading a photo, which is not ideal. I also wish I had time to build a way to show newly added recipes with full details like instructions and ingredients, and to actually save those recipes locally so they do not disappear after closing the app. There is no search bar in the main view to see all recipes, which is also the reason for the gap above the main headline on the home screen. I would also like to make the recipe grid cards more detailed because right now they feel a bit empty and could definitely show more information. Accessibility is another area I could improve, since the app mostly relies on SwiftUI’s defaults, but adding more explicit accessibility labels or dynamic type support would make a big difference. Error handling is also pretty basic since most failures just show a simple alert, and I would like to add more user-friendly error views or retry buttons in the future. When it comes to scalability, the current architecture works fine for a small app, but as features grow and more complexity is added, it would make sense to split the HomeViewModel into smaller modules or use a more robust state management approach. Right now, the HomeViewModel handles a lot of responsibilities such as fetching, filtering, and adding recipes, so making it more modular would help as the project expands. Overall, these are the features I would focus on if I had more time.

---

### Additional Information:

One thing I want to mention is that I started this project a little later than planned because of a family emergency that required me to leave the country, all while balancing it with two part-time jobs and other personal responsibilities. This made time management a real challenge for me, but I was committed to building something I could be proud of. Most of my mobile development experience before this was in Flutter and React Native, mostly for Android and a bit for iPhone, so jumping into Swift, SwiftUI, and the Xcode environment was completely new territory. On top of that, I had to figure out how to handle efficient network usage, such as only loading images when needed in the UI and caching them to disk to avoid unnecessary network requests without relying on any third-party solutions or default caching from URLSession & URLCache, which was a a bit of a learning curve. Even though it was tough at times, I genuinely enjoyed the process and found myself getting more and more into iOS development as I went. Even if I do not get this job, having another real project like this on my resume is a huge win for me, so I want to say thank you so much for the opportunity. This project really forced me out of my comfort zone, which was exactly what I needed, and now I know what I am capable of if another one of these projects comes around.

---

#### About Me ☝🏽
- [Alexis Cruz-Aboytes](https://github.com/ChicoQuemador1)
