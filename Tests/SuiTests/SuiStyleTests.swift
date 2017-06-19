import XCTest
@testable import Sui
import Properties

class SuiStyleTests: XCTestCase {
  let widgetType=WidgetType(parent:anyWidgetType)
  let parentType=WidgetType(parent:anyWidgetType)
  let otherType=WidgetType(parent:anyWidgetType)

  var widget=Widget(type:anyWidgetType)
  var parent=Widget(type:anyWidgetType)

  let property = Property<WidgetType?, Style>(nil)
  let otherProperty = Property<WidgetType?, Style>(nil)

  override func setUp() {
    super.setUp()

    parent=Widget(type:parentType)
    widget=Widget(type:widgetType)
    widget.container=parent

  }

  override func tearDown() {
    super.tearDown()
  }

  func testGetsDefaultProperty() {
    XCTAssertEqual(widget.get(property:property), nil)
  }

  func testGetsPropertyFromWidget() {
    widget.style = Style(
      anyWidgetType <- [
        property <- widgetType
      ]
    )
    XCTAssertEqual(widget.get(property:property), widgetType)
  }

  func testGetsPropertyFromParent() {
    parent.style = Style(
      anyWidgetType <- [
        property <- parentType
      ]
    )
    XCTAssertEqual(widget.get(property:property), parentType)
  }

  func testGetsPropertyFromParentWhenTypeDoesNotMatch() {
    parent.style = Style(
      anyWidgetType <- [
        property <- parentType
      ]
    )
    widget.style = Style(
      otherType <- [
        property <- widgetType
      ]
    )
    XCTAssertEqual(widget.get(property:property), parentType)
  }

  func testGetsPropertyFromParentWhenPropertyDoesNotMatch() {
    parent.style = Style(
      anyWidgetType <- [
        property <- parentType
      ]
    )
    widget.style = Style(
      anyWidgetType <- [
        otherProperty <- widgetType
      ]
    )
    XCTAssertEqual(widget.get(property:property), parentType)
  }
}
