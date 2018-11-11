# AudiomackSwiftLibrary

[![CI Status](https://img.shields.io/travis/Fitzafful/AudiomackSwiftLibrary.svg?style=flat)](https://travis-ci.org/Fitzafful/AudiomackSwiftLibrary)
[![Version](https://img.shields.io/cocoapods/v/AudiomackSwiftLibrary.svg?style=flat)](https://cocoapods.org/pods/AudiomackSwiftLibrary)
[![License](https://img.shields.io/cocoapods/l/AudiomackSwiftLibrary.svg?style=flat)](https://cocoapods.org/pods/AudiomackSwiftLibrary)
[![Platform](https://img.shields.io/cocoapods/p/AudiomackSwiftLibrary.svg?style=flat)](https://cocoapods.org/pods/AudiomackSwiftLibrary)

## Documentation

Access the full [API documentation](https://www.audiomack.com/data-api/docs/) here.

## Getting Started as on [Getting Started](https://www.audiomack.com/data-api/docs#getting-started)

- Getting started with the Audiomack API
- Request an API key on our Contact Us page
- The API key and associated secret will be used to identify your application when making requests to the API
- All requests must be signed using the oAuth standard
- Create your application
- Send any API support questions to support@audiomack.com

## Features

- [] Chainable Request / Response Methods
- [] URL / JSON / plist Parameter Encoding
- [] Upload File / Data / Stream / MultipartFormData
- [] Download File using Request or Resume Data
- [] Authentication with URLCredential
- [] HTTP Response Validation
- [] Upload and Download Progress Closures with Progress
- [] cURL Command Output

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

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

## Author

Fitzafful, fitzafful@gmail.com

## License

AudiomackSwiftLibrary is available under the MIT license. See the LICENSE file for more info.
