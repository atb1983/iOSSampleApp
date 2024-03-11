#  GitHubRepository Reader - iOS Code Example

This small app is able to fetch git hub repositories and show some information about them, such as authors, characteritics, urls etc.


## Build instructions:

Unzip project, open AlexGitHubReprositories.xcodeproj and build.
Note: No 3rd party libraries are used.

Minimum iOS version: iOS16

## Included Targets:
GitHubRepositoriesDBApi framework with unit tests (MockNetworkRequest conforms to NetworkRequestProtocol to simulate any network response for easier testing)

App is using MVVM architecture. RepositoriesViewModel communicates with GitHubRepositoriesDBApi framework which is reusable. GitHubRepositoriesDBApi framework implements the GitHub Trending Repositories Database API from github.com.

## List of Trending Repositories:
It will show a list of trending repositories. In case of network failure it will show an error message.

The project’s idea is to list trending projects from Github, tap on one of them, and show their details.

## Main features:

Also works in Light/Dark Modes, iPads and Large Texts (Accesibility), Localization, SwiftUI, Protocols, Async Images

