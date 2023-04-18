// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "testspm",
    platforms: [.iOS(.v13)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "testspm",
            targets: ["testspm"]),
    ],
    dependencies: [
        .package(url: "https://github.com/fastlane/fastlane", from: "2.179.0")
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "testspm",
            dependencies: []),
        .testTarget(
            name: "testspmTests",
            dependencies: ["testspm"]),
    ],
    swiftLanguageVersions: [.v5],
    version:"1.0.0"
)
