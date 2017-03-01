import PackageDescription
 
let package = Package(
  name: "Sui",
  targets: [
    Target(
      name: "Sui",
      dependencies: [
        .Target(name: "HashableUsingAddress"),
        .Target(name: "AbstractionAsserter"),
        .Target(name: "Weak"),
        .Target(name: "GeneratedValue"),
        .Target(name: "Properties"),
      ]
    ),
    Target(name: "HashableUsingAddress"),
    Target(name: "AbstractionAsserter"),
    Target(name: "Weak"),
    Target(name: "GeneratedValue"),
    Target(name: "LimitOperator"),
    Target(name: "Properties"),
  ],
  dependencies: [
    .Package(url: "https://github.com/Quick/Nimble.git", majorVersion: 5, minor: 1),
    .Package(url: "https://github.com/Quick/Quick.git", majorVersion: 1, minor: 0),
  ]
)
