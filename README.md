# AudiomackSwiftLibrary

[![CI Status](https://img.shields.io/travis/Fitzafful/AudiomackSwiftLibrary.svg?style=flat)](https://travis-ci.org/Fitzafful/AudiomackSwiftLibrary)
[![Version](https://img.shields.io/cocoapods/v/AudiomackSwiftLibrary.svg?style=flat)](https://cocoapods.org/pods/AudiomackSwiftLibrary)
[![License](https://img.shields.io/cocoapods/l/AudiomackSwiftLibrary.svg?style=flat)](https://cocoapods.org/pods/AudiomackSwiftLibrary)
[![Platform](https://img.shields.io/cocoapods/p/AudiomackSwiftLibrary.svg?style=flat)](https://cocoapods.org/pods/AudiomackSwiftLibrary)

## Documentation

Access the full [API documentation](https://www.audiomack.com/data-api/docs/) here.

## Getting Started as on [Getting Started](https://www.audiomack.com/data-api/docs#getting-started)

- Request an API key on the Contact Us page
- The API key and associated secret will be used to identify your application when making requests to the API
- All requests must be signed using the oAuth standard
- Send any API support questions to support@audiomack.com
- Check out ##Usage

## Features

### Initialization / Authorization
- [ ] Initializing / Authorizing Requests
- [ ] Error Handling
### Unauthenticated Requests
#### Music
- [X] Get Music Details
- [X] Get Most Recent Music
- [X] Get Genre-specific Most Recent Music
- [X] Get Trending Music
- [X] Get Genre-specific Trending Music
- [X] Flag Unplayable Track
- [X] Play Track
#### Artists
- [X] Get Artist Details
- [X] Get Artist Uploads
- [X] Get Artist Favorites
- [X] Search Artist Favorites
- [X] Get Artist Playlists
- [X] Get Artist Following / Followers
- [X] Get Artist Feed
#### Playlists
- [X] Get Playlist Details
- [X] Get Trending Playlists
- [X] Get Genre-specific Trending Playlists
#### Charts
- [X] Get Chart Tracks
- [X] Get Gender Specific Chart Tracks
#### Search
- [X] Search Song / Artist / Playlist / Album
- [X] Search Autosuggest


### Authenticated Requests
#### Music
- [ ] Favorite / Unfavorite a song / album
- [ ] Repost / Unrepost a song / album
#### Artists
- [ ] Follow / Unfollow an artist
#### Playlists
- [ ] Create playlist
- [ ] Edit playlist
- [ ] Delete playlist
- [ ] Add song(s) to playlist
- [ ] Remove song from playlist
- [ ] Favorite / Unfavorite playlist
#### User
- [ ] Register user
- [ ] Get User Details
- [ ] Forgot Password
- [ ] Get User Playlists
- [ ] Get User Uploads
- [ ] Get User Favorites
- [ ] Get User Notifications

## Requirements

- iOS 8.0+ 
- Xcode 10+
- Swift 4.0+

## Installation

AudiomackSwiftLibrary is available through [CocoaPods](https://cocoapods.org). To integrate AudiomackSwiftLibrary into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '10.0'
use_frameworks!

target '<Your Target Name>' do
pod 'AudiomackSwiftLibrary', '~> 4.7'
end
```

Then, run the following command:

```bash
$ pod install
```
## Usage

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

### Not Supported calls in AudiomackSwiftLibrary
- Getting Artist Pinned Content
- Marking User Notifications as Seen
- Getting Aggregations Lists for Notifications
- Getting list of activities for an Aggregation

## Author

Fitzafful, fitzafful@gmail.com

## License

AudiomackSwiftLibrary is available under the MIT license. See the LICENSE file for more info.
