@testable import AbstractionAsserterTests
@testable import SuiTests
@testable import LimitOperatorTests
@testable import GeneratedValueTests

import Quick

QCKMain([
  AbstractionAsserterSpec.self,
  SuiSpec.self,
  LimitOperatorSpec.self,
  GeneratedValueSpec.self,
])
