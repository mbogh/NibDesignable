// swift-tools-version:4.2
import PackageDescription

let package = Package(
    name: "NibDesignable",
    products: [
        .library(name: "NibDesignable", targets: ["NibDesignable"])
    ],
    targets: [
        .target(
            name: "NibDesignable",
            path: ".",
            exclude: ["NibDesignable", "NibDesignableDemo"]
        )
    ]
)
