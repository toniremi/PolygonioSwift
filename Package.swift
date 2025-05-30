// swift-tools-version:5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PolygonioSwift",
    platforms: [
        .macOS(.v10_15), // Or your desired minimum deployment target
        .iOS(.v13),
        .tvOS(.v13),
        .watchOS(.v6),
    ],
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(name: "PolygonioSwift", targets: ["PolygonioSwift"]),
        .library(name: "PolygonioReferenceClient", targets: ["PolygonioReferenceClient"]),
        .library(name: "PolygonioCryptoClient", targets: ["PolygonioCryptoClient"]),
        .library(name: "PolygonioStocksClient", targets: ["PolygonioStocksClient"]),
        .library(name: "PolygonioForexClient", targets: ["PolygonioForexClient"]),
        .library(name: "PolygonioIndicesClient", targets: ["PolygonioIndicesClient"]),
        .library(name: "PolygonioOptionsClient", targets: ["PolygonioOptionsClient"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/apple/swift-openapi-generator", from: "1.6.0"),
        .package(url: "https://github.com/apple/swift-openapi-runtime", from: "1.7.0"),
        .package(url: "https://github.com/apple/swift-openapi-urlsession", from: "1.0.0"), // For URLSession-based client
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "PolygonioSwift",
            dependencies: [
                .product(name: "OpenAPIRuntime", package: "swift-openapi-runtime"),
                .product(name: "OpenAPIURLSession", package: "swift-openapi-urlsession"),
                // Generated client modules as dependency so we can import them with their Generated Client
                .target(name: "PolygonioReferenceClient"),
                .target(name: "PolygonioCryptoClient"),
                .target(name: "PolygonioStocksClient"),
                .target(name: "PolygonioForexClient"),
                .target(name: "PolygonioIndicesClient"),
                .target(name: "PolygonioOptionsClient"),
                
            ],
            path: "Sources/PolygonioSwift"
        ),
        // Reference Client
        .target(
            name: "PolygonioReferenceClient", // This will be your "CryptoClient" module
            dependencies: [
                .product(name: "OpenAPIRuntime", package: "swift-openapi-runtime"),
                .product(name: "OpenAPIURLSession", package: "swift-openapi-urlsession"),
            ],
            path: "Sources/PolygonioReferenceClient",
            plugins: [
                .plugin(name: "OpenAPIGenerator", package: "swift-openapi-generator")
            ]
        ),
        // Crypto Client
        .target(
            name: "PolygonioCryptoClient", // This will be your "CryptoClient" module
            dependencies: [
                .product(name: "OpenAPIRuntime", package: "swift-openapi-runtime"),
                .product(name: "OpenAPIURLSession", package: "swift-openapi-urlsession"),
            ],
            path: "Sources/PolygonioCryptoClient",
            plugins: [
                .plugin(name: "OpenAPIGenerator", package: "swift-openapi-generator")
            ]
        ),
        // Stock Client
        .target(
            name: "PolygonioStocksClient", // This will be your "CryptoClient" module
            dependencies: [
                .product(name: "OpenAPIRuntime", package: "swift-openapi-runtime"),
                .product(name: "OpenAPIURLSession", package: "swift-openapi-urlsession"),
            ],
            path: "Sources/PolygonioStocksClient",
            plugins: [
                .plugin(name: "OpenAPIGenerator", package: "swift-openapi-generator")
            ]
        ),
        // Forex Client
        .target(
            name: "PolygonioForexClient", // This will be your "CryptoClient" module
            dependencies: [
                .product(name: "OpenAPIRuntime", package: "swift-openapi-runtime"),
                .product(name: "OpenAPIURLSession", package: "swift-openapi-urlsession"),
            ],
            path: "Sources/PolygonioForexClient",
            plugins: [
                .plugin(name: "OpenAPIGenerator", package: "swift-openapi-generator")
            ]
        ),
        // Indices Client
        .target(
            name: "PolygonioIndicesClient", // This will be your "CryptoClient" module
            dependencies: [
                .product(name: "OpenAPIRuntime", package: "swift-openapi-runtime"),
                .product(name: "OpenAPIURLSession", package: "swift-openapi-urlsession"),
            ],
            path: "Sources/PolygonioIndicesClient",
            plugins: [
                .plugin(name: "OpenAPIGenerator", package: "swift-openapi-generator")
            ]
        ),
        // Options Client
        .target(
            name: "PolygonioOptionsClient", // This will be your "CryptoClient" module
            dependencies: [
                .product(name: "OpenAPIRuntime", package: "swift-openapi-runtime"),
                .product(name: "OpenAPIURLSession", package: "swift-openapi-urlsession"),
            ],
            path: "Sources/PolygonioOptionsClient",
            plugins: [
                .plugin(name: "OpenAPIGenerator", package: "swift-openapi-generator")
            ]
        ),
        .target(
            name: "TestResources",
            dependencies: []
        ),
        .testTarget(
            name: "PolygonioSwiftTests",
            dependencies: ["PolygonioSwift", "TestResources"]),
    ]
)
