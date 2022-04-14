// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "OggDecoder",
    products: [
        .library(
            name: "OggDecoder",
            targets: ["OggDecoder"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "OggDecoder",
            dependencies: ["ogg", "vorbis"],
            path: "Sources/OggDecoderObjC"),
        .testTarget(
            name: "OggDecoderTests",
            dependencies: ["OggDecoder"],
            resources: [
                .copy("TestResources/")
            ]),
        .binaryTarget(name: "ogg",
                      path: "ogg.xcframework"),
        .binaryTarget(name: "vorbis",
                      path: "vorbis.xcframework"),
    ]
)
