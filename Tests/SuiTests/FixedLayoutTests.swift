import XCTest
@testable import Sui
import Properties

class FixedLayoutTests: XCTestCase {
  func testGetrequestedSize() {
    let widgetType=WidgetType(parent:anyWidgetType)
    let widget=Widget(type:widgetType)
    widget.style=Style(
      widgetType <- [
        layoutProperty <- FixedLayout(RequestedSize(Point(1,2)))
      ]
    )
    XCTAssertEqual(widget.requestedSize, RequestedSize(Point(1,2)))
  }
}
