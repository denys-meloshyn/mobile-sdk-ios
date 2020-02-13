// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.
import PackageDescription

let package = Package(
    name: "CrowdinSDK",
    platforms: [
        .iOS(SupportedPlatform.IOSVersion.v9)
    ],
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(name: "CrowdinSDK", targets: ["CrowdinSDK"]),
        
        .library(name: "CrowdinScreenshots", targets: ["CrowdinScreenshots"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(url: "https://github.com/daltoniam/Starscream.git", from: "3.1.1"),
        .package(url: "https://github.com/serhii-londar/BaseAPI.git", from: "0.1.7")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(name: "CrowdinSDK", dependencies: ["BaseAPI", "Starscream"], path: "CrowdinSDK/Classes/", exclude: ["Features", "Settings", "Providers/Firebase"]),
        .testTarget(name: "CrowdinSDKTests", dependencies: ["CrowdinSDK"], path: "CrowdinSDK/Tests"),
        
        .target(name: "CrowdinScreenshots", dependencies: ["CrowdinSDK"], path: "CrowdinSDK/Classes/Features/Screenshots/"),
        .target(name: "CrowdinRealtimeUpdates", dependencies: ["CrowdinSDK"], path: "CrowdinSDK/Classes/Features/RealtimeUpdates/"),
        .target(name: "CrowdinIntervalUpdates", dependencies: ["CrowdinSDK"], path: "CrowdinSDK/Classes/Features/IntervalUpdates/"),
    ]
)
