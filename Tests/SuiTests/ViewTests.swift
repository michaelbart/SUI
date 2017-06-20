import XCTest
@testable import Sui
import Properties

class ViewTests: XCTestCase {

  func testSameGenericWidgetTypeAsModelWidget() {
    XCTAssertEqual(View<Int>.genericWidgetType,ModelWidget<Int>.genericWidgetType)
    XCTAssertEqual(View<String>.genericWidgetType, ModelWidget<String>.genericWidgetType)
    XCTAssertEqual(View<[Int]>.genericWidgetType, ModelWidget<[Int]>.genericWidgetType)
  }

  func testViewWidgetTypesAreDifferentThenGenericWidgetTypes() {
    XCTAssertNotEqual(View<Int>.viewWidgetType, View<Int>.genericWidgetType)
    XCTAssertNotEqual(View<String>.viewWidgetType, View<String>.genericWidgetType)
    XCTAssertNotEqual(View<[Int]>.viewWidgetType, View<[Int]>.genericWidgetType)
  }

  func testGetDefferentViewWidgetTypes() {
    XCTAssertEqual(View<Int>.viewWidgetType, View<Int>.viewWidgetType)
    XCTAssertEqual(View<String>.viewWidgetType, View<String>.viewWidgetType)
    XCTAssertEqual(View<[Int]>.viewWidgetType, View<[Int]>.viewWidgetType)

    XCTAssertNotEqual(View<Int>.viewWidgetType, View<String>.viewWidgetType)
    XCTAssertNotEqual(View<Int>.viewWidgetType, View<[Int]>.viewWidgetType)
    XCTAssertNotEqual(View<String>.viewWidgetType, View<[Int]>.viewWidgetType)
  }
}
