import XCTest
@testable import GeneratedValue

class GeneratedValueTests: XCTestCase {
  var generatedValue:GeneratedValue=GeneratedValue{0}
  var valueToSetTo=2

  override func setUp() {
    super.setUp()
    valueToSetTo=2
    generatedValue=GeneratedValue{self.valueToSetTo}
  }

  func testCanGetValue() {
    XCTAssertEqual(generatedValue.get(), valueToSetTo)
  }

  func testWillWaitUntilGetIsCalledBefreSettingCashe() {
    valueToSetTo=4
    XCTAssertEqual(generatedValue.get(), valueToSetTo)
  }

  func testWillNotUpdateAutomaticly() {
    XCTAssertEqual(generatedValue.get(), valueToSetTo)
    valueToSetTo=4
    XCTAssertEqual(generatedValue.get(), 2)
  }

  func testWillUpdateAfterClearCasheIsCalled() {
    XCTAssertEqual(generatedValue.get(), valueToSetTo)
    valueToSetTo=4
    generatedValue.clearCashe()
    XCTAssertEqual(generatedValue.get(), valueToSetTo)
  }
}
