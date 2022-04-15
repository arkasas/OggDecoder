# OggDecoder
## Convert ogg and oga files in Swifty way
[![swift-version](https://img.shields.io/badge/Swift-5%2B-green)](https://github.com/apple/swift)
[![License](https://img.shields.io/badge/License-MIT-green.svg)]()
[![Platform](https://img.shields.io/badge/Platform-iOS%20macOS-lightgrey)]()
[![SwiftPM compatible](https://img.shields.io/badge/SwiftPM-compatible-brightgreen?style=flat)](https://swift.org/package-manager)


## Introduction
OggDecoder was created in order to convert a audio filed(ogg and oga) that are not playable by iOS AVFoundation into .wav file. It contant a two XCFramework based on liibogg(https://github.com/gcp/libogg) and vorbis(https://github.com/xiph/vorbis) framework. 

## Requirements
OggDecoder works on the following platforms:

- **iOS 13+**
- **Mac OSX 10.14+**

## Installation
To use OggDecoder with Apple's Swift package manager, add the following as a dependency to your Package.swift:

```swift
.package(url: "https://github.com/arkasas/OggDecoder.git")
```


## Usage
Ogg decoder is designed to made a ogg/oga files converting into wav as simple as possible. To do so you have to:
1. Import OggDecoder
```swift
import OggDecoder
```

2. Decode file
```swift
let decoder = OGGDecoder()
let oggFile = oggFileURL()
decoder.decode(oggFile) { (savedWavUrl: URL?) in
  // Do whatever you want with URL
  // If convert was fail, returned url is nil
}
```

Available methods: 
```swift
decoder.decode(URL) -> URL?
decoder.decode(URL, completion: (URL?) -> Void)
decoder.decode(URL, into: URL) -> bool
decoder.decode(URL, into: URL, completion: (Bool) -> Void)

```

## License
OggDecoder is available under the [MIT License](LICENSE).
