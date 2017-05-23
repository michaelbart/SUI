import PackageDescription
 
let package = Package(
  name: "Sui",
  targets: [
    Target(
      name: "SdlSuiDemo",
      dependencies: [
        .Target(name: "SdlSui"),
      ]
    ),
    Target(
      name: "SdlSui",
      dependencies: [
        .Target(name: "Sui"),
      ]
    ),
    Target(
      name: "Sui",
      dependencies: [
        .Target(name: "HashableUsingAddress"),
        .Target(name: "AbstractionAsserter"),
        .Target(name: "Weak"),
        .Target(name: "GeneratedValue"),
        .Target(name: "Properties"),
        .Target(name: "LimitOperator"),
      ]
    ),
    Target(name: "HashableUsingAddress"),
    Target(name: "AbstractionAsserter"),
    Target(name: "Weak"),
    Target(name: "GeneratedValue"),
    Target(name: "LimitOperator"),
    Target(
      name: "Properties",
      dependencies: [
        .Target(name: "HashableUsingAddress"),
        .Target(name: "AbstractionAsserter"),
      ]
    ),
  ],
  dependencies: [
// TODO: use Quick and Nimble for only test targets.
//    .Package(url: "https://github.com/Quick/Nimble.git", majorVersion: 5, minor: 1),
//    .Package(url: "https://github.com/Quick/Quick.git", majorVersion: 1, minor: 0),
    .Package(url: "https://github.com/jaz303/CSDL2.swift.git", majorVersion: 2, minor: 0),
  ]
)

