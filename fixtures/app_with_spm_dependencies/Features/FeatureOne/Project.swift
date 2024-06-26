import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "FeatureOne",
    settings: .projectSettings,
    targets: [
        .target(
            name: "FeatureOneFramework_iOS",
            destinations: .iOS,
            product: .framework,
            bundleId: "io.tuist.featureOne",
            sources: ["Sources/**"],
            dependencies: [
                .external(name: "Alamofire"),
            ],
            settings: .targetSettings
        ),
        .target(
            name: "FeatureOneFramework_watchOS",
            destinations: [.appleWatch],
            product: .framework,
            bundleId: "io.tuist.featureOne",
            sources: ["Sources/**"],
            dependencies: [
                .external(name: "Alamofire"),
            ],
            settings: .targetSettings
        ),
    ],
    schemes: Scheme.allSchemes(for: ["FeatureOneFramework"])
)
