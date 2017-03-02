@testable import AbstractionAsserterTests
@testable import SuiTests
@testable import LimitOperatorTests
@testable import GeneratedValueTests
@testable import PropertiesTests

import Quick

QCKMain([
  AbstractionAsserterSpec.self,
  SuiSpec.self,
  LimitOperatorSpec.self,
  GeneratedValueSpec.self,
  PropertiesSpec.self,
])
