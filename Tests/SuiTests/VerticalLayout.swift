import XCTest
@testable import Sui
import Properties

class VerticalLayoutTests: XCTestCase {
  let widgetType=WidgetType(parent:anyWidgetType)
  var widget=Widget(type:anyWidgetType)
  var child1=Widget(type:anyWidgetType)
  var child2=Widget(type:anyWidgetType)

  override func setUp() {
    super.setUp()

    widget=Widget(type:widgetType)
    child1=Widget(type:widgetType)
    child2=Widget(type:widgetType)
    child1.container=widget
    child2.container=widget

    widget.style=Style(
      widgetType <- [
        layoutProperty <- VerticalLayout()
      ],

      (widgetType / widgetType) <- [
         layoutProperty <- FixedLayout(RequestedSize(Point(1,2)))
      ]
    )
  }

  func testGetRequestedSize() {
    XCTAssertEqual(widget.requestedSize, RequestedSize(Point(1,4), moldable:Point(1,2)))
  }

  func testGetAllocatedSpace() {
    XCTAssertEqual(child1.allocatedSpace, AllocatedSpace(Point(0,0), Point(1,2)))
    XCTAssertEqual(child2.allocatedSpace, AllocatedSpace(Point(0,2), Point(1,2)))
  }
}
