# Reach

A modern Reachability network library. 

## Table of Contents
* [Overview](#overview)
* [Features](#features)
* [Getting Started](#getting-started)
* [Installation](#installation)
* [Author](#author)
* [Contribution](#contribution)
* [License](#license)
* [Changelog](#changelog)

## Overview
Reach is a lightweight reachability framework. 
We designed Reach to be simple to use and also very flexible. Written on Swift 3.1 and compatible with:
  - iOS 8.0
  - macOS 10.10
  - tvOS 9.0
  - watchOS 2.0

## Features
- Super friendly API
- Singleton free
- No external dependencies
- Minimal implementation
- Support for `iOS/macOS/tvOS/watchOS/Linux`
- Support for CocoaPods/Carthage/Swift Package Manager

## Getting Started

Reach contains a status property to check the reachability from network. If you want to receive notifications from network changes, you can subscribe to `ReachDelegate` protocol. 

```swift
let reach = Reach()

reach.start()

print(reach.status)
```

You can check the `Reach.playground` to experimental with more examples. If need to see deeply information you can check our [Documentation](https://github.com/therapychat/Reach/docs)

## Installation

### CocoaPods

Reach is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
platform :ios, '10.0'
use_frameworks!
swift_version = '3.0'

target 'MyApp' do
  pod 'Reach'
end
```
### Carthage

You can also install it via [Carthage](https://github.com/Carthage/Carthage). To do so, add the following to your Cartfile:

```swift
github 'therapychat/Reach'
```

### Swift Package Manager

You can use [Swift Package Manager](https://swift.org/package-manager/) and specify dependency in `Package.swift` by adding this:
```
.Package(url: "https://github.com/therapychat/Reach.git", majorVersion: 0)
```

## Author

Sergio Fernández, fdz.sergio@gmail.com

## Contribution

For the latest version, please check [develop](https://github.com/therapychat/Reach/tree/develop) branch. Changes from this branch will be merged into the [master](https://github.com/therapychat/Reach/tree/master) branch at some point.

- If you want to contribute, submit a [pull request](https://github.com/therapychat/Reach/pulls) against a development `develop` branch.
- If you found a bug, [open an issue](https://github.com/therapychat/Reach/issues).
- If you have a feature request, [open an issue](https://github.com/therapychat/Reach/issues).

## License

Reach is available under the `Apache License 2.0`. See the [LICENSE](./LICENSE) file for more info.


## Changelog

See [CHANGELOG](./CHANGELOG) file.