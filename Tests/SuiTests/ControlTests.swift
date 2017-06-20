import XCTest
@testable import Sui
import Properties

class ControlTests: XCTestCase {

  func testSameGenericWidgetTypeAsModelWidget() {
    XCTAssertEqual(Control<Int>.genericWidgetType,ModelWidget<Int>.genericWidgetType)
    XCTAssertEqual(Control<String>.genericWidgetType, ModelWidget<String>.genericWidgetType)
    XCTAssertEqual(Control<[Int]>.genericWidgetType, ModelWidget<[Int]>.genericWidgetType)
  }

  func testControlWidgetTypesAreDifferentThenGenericWidgetTypes() {
    XCTAssertNotEqual(Control<Int>.controlWidgetType, Control<Int>.genericWidgetType)
    XCTAssertNotEqual(Control<String>.controlWidgetType, Control<String>.genericWidgetType)
    XCTAssertNotEqual(Control<[Int]>.controlWidgetType, Control<[Int]>.genericWidgetType)
  }

  func testGetDefferentControlWidgetTypes() {
    XCTAssertEqual(Control<Int>.controlWidgetType, Control<Int>.controlWidgetType)
    XCTAssertEqual(Control<String>.controlWidgetType, Control<String>.controlWidgetType)
    XCTAssertEqual(Control<[Int]>.controlWidgetType, Control<[Int]>.controlWidgetType)

    XCTAssertNotEqual(Control<Int>.controlWidgetType, Control<String>.controlWidgetType)
    XCTAssertNotEqual(Control<Int>.controlWidgetType, Control<[Int]>.controlWidgetType)
    XCTAssertNotEqual(Control<String>.controlWidgetType, Control<[Int]>.controlWidgetType)
  }
}
