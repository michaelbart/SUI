import XCTest
@testable import Sui

class WidgetTypeHierarchyTests: XCTestCase {
  let widgetType=WidgetType(parent:anyWidgetType)
  let parentType=WidgetType(parent:anyWidgetType)
  let grandParentType=WidgetType(parent:anyWidgetType)
  let otherType=WidgetType(parent:anyWidgetType)

  var widget=Widget(type:anyWidgetType)
  var parent=Widget(type:anyWidgetType)
  var grandParent=Widget(type:anyWidgetType)

  override func setUp() {
    super.setUp()
    grandParent=Widget(type:grandParentType)
    parent=Widget(type:parentType)
    parent.container=grandParent
    widget=Widget(type:widgetType)
    widget.container=parent
  }

  override func tearDown() {
    super.tearDown()
  }

  func testTypeMatches() {
    XCTAssert(
      WidgetTypeHierarchy.type(widgetType).matches(widget.hierarchy),
      "widgetType should match widget.hierarchy"
    )

    XCTAssert(
      WidgetTypeHierarchy.type(anyWidgetType).matches(widget.hierarchy),
      "anyWidgetType should match widget.hierarchy"
    )

    XCTAssert(
      !WidgetTypeHierarchy.type(otherType).matches(widget.hierarchy),
      "otherType should not match widget.hierarchy"
    )
  }

  func testCompoundMatches() {
    XCTAssert(
      (parentType / widgetType).matches(widget.hierarchy),
      "parentType / widgetType should match widget.hierarchy"
    )

    XCTAssert(
      !(otherType / widgetType).matches(widget.hierarchy),
      "otherType / widgetType should not match widget.hierarchy"
    )

    XCTAssert(
      !(parentType / otherType).matches(widget.hierarchy),
      "parentType / otherType should not match widget.hierarchy"
    )

    XCTAssert(
      (grandParentType / parentType as WidgetTypeHierarchy / widgetType).matches(widget.hierarchy),
      "grandParentType / parentType / widgetType should match widget.hierarchy"
    )
  }
}
