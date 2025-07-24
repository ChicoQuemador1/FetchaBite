<h1 align="center"> Fetch a Bite </h1>
 
<p align="center">
  <img src="https://github.com/ChicoQuemador1/FetchaBite/blob/main/Other/logo.png?raw=true" width="600" alt="Fetch-a-Bite Logo" />
</p>

<p align="center">
  <a href="https://github.com/ChicoQuemador1/FetchaBite/stargazers">
    <img src="https://img.shields.io/github/stars/ChicoQuemador1/FetchaBite?color=yellow" alt="Stars Badge"/>
  </a>
  <a href="https://github.com/ChicoQuemador1/FetchaBite">
    <img src="https://img.shields.io/github/repo-size/ChicoQuemador1/FetchaBite?color=ff69b4" alt="Repo Size Badge"/>
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
  <img src="https://github.com/ChicoQuemador1/FetchaBite/blob/main/Other/AppScreens/01.png" width="240"/>
  <img src="https://github.com/ChicoQuemador1/FetchaBite/blob/main/Other/AppScreens/02.png" width="240"/>
  <img src="https://github.com/ChicoQuemador1/FetchaBite/blob/main/Other/AppScreens/03.png" width="240"/>
</p>
<p align="center">
  <img src="https://github.com/ChicoQuemador1/FetchaBite/blob/main/Other/AppScreens/04.png" width="240"/>
  <img src="https://github.com/ChicoQuemador1/FetchaBite/blob/main/Other/AppScreens/05.png" width="240"/>
  <img src="https://github.com/ChicoQuemador1/FetchaBite/blob/main/Other/AppScreens/06.png" width="240"/>
</p>
<p align="center">
  <img src="https://github.com/ChicoQuemador1/FetchaBite/blob/main/Other/AppScreens/07.png" width="240"/>
  <img src="https://github.com/ChicoQuemador1/FetchaBite/blob/main/Other/AppScreens/08.png" width="240"/>
  <img src="https://github.com/ChicoQuemador1/FetchaBite/blob/main/Other/AppScreens/09.png" width="240"/>
</p>
<p align="center">
  <img src="https://github.com/ChicoQuemador1/FetchaBite/blob/main/Other/AppScreens/10.png" width="240"/>
  <img src="https://github.com/ChicoQuemador1/FetchaBite/blob/main/Other/AppScreens/11.png" width="240"/>
  <img src="https://github.com/ChicoQuemador1/FetchaBite/blob/main/Other/AppScreens/12.png" width="240"/>
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

#### About Me ☝🏽
- [Alexis Cruz-Aboytes](https://github.com/ChicoQuemador1)
