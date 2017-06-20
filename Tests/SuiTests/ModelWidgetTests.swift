import XCTest
@testable import Sui
import Properties

class ModelWidgetTests: XCTestCase {

  func testDifferentGenericWidgetTypes() {
    XCTAssertEqual(ModelWidget<Int>.genericWidgetType,ModelWidget<Int>.genericWidgetType)
    XCTAssertEqual(ModelWidget<String>.genericWidgetType,ModelWidget<String>.genericWidgetType)
    XCTAssertEqual(ModelWidget<[Int]>.genericWidgetType,ModelWidget<[Int]>.genericWidgetType)

    XCTAssertNotEqual(ModelWidget<Int>.genericWidgetType,ModelWidget<String>.genericWidgetType)
    XCTAssertNotEqual(ModelWidget<String>.genericWidgetType,ModelWidget<[Int]>.genericWidgetType)
    XCTAssertNotEqual(ModelWidget<[Int]>.genericWidgetType,ModelWidget<Int>.genericWidgetType)
  }
}
