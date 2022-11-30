# Movie Randommendation
A movie recommendation app that presents you with 3 random words (Noun, Verb, Adjective) that you can use as a prompt to search for the movie title.

# Features
- Choose 3 random words to autofill the search bar (from 3 different endpoints)
- New words every new app open
- Auto submit search with rate limiting (throttle)
- Movie list pagination (search result is fetched incrementally when the user reached the end of previous page content)

# Project Specification
- XCode 13.1
- Swift 5
- iOS 12.1

# Dependencies
- SnapKit for more straight forward auto layout API
- RxSwift to support reactive programming
- Kingfisher for displaying image from remote url

# API
1. OMDB API (https://www.omdbapi.com/)
2. Random Words API (https://github.com/mcnaveen/Random-Words-API)

# Architecture
VIPER
- View & Viewcontroller handles the ui creation and lifecycle
- Presenter prepare the data to be presented in View, communicate to Interactor and Router according to user interaction
- Interactor is where the business logic and communication with network calls happening
- Entity as the representation of the data model
- Router connects with outside module/feature and handles the navigation.
