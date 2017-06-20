import XCTest
@testable import Sui
import Properties

class SpriteLayoutTests: XCTestCase {
  let widgetType=WidgetType(parent:anyWidgetType)
  var widget=Widget(type:anyWidgetType)
  var contained=Widget(type:anyWidgetType)

  override func setUp() {
    super.setUp()

    widget=Widget(type:widgetType)
    contained=Widget(type:widgetType)
    widget.style=Style(
      widgetType <- [
        layoutProperty <- SpriteLayout()
      ],
      (widgetType / widgetType) <- [
        layoutProperty <- FixedLayout(RequestedSize(Point(1,2)))
      ]
    )
    contained.container=widget
  }

  func testGetRequestedSize() {
    XCTAssertEqual(widget.requestedSize, RequestedSize(Point(0,0)))
    XCTAssertEqual(contained.requestedSize, RequestedSize(Point(1,2)))
  }

  func testGetAllocatedSpace() {
    contained.set(property:spritePosition, to:Point(3,4))
    contained.set(property:spriteSize, to:Point(4,5))
    XCTAssertEqual(widget.allocatedSpace, AllocatedSpace(Point(0,0), Point(0,0)))
    XCTAssertEqual(contained.allocatedSpace, AllocatedSpace(Point(3,4), Point(4,5)))
  }

  func testCleareAllocatedSpaceCashewhenSpriteIsMoved() {
    XCTAssertEqual(contained.allocatedSpace, AllocatedSpace(Point(0,0), Point(1,2)))
    contained.set(property:spritePosition, to:Point(3,4))
    XCTAssertEqual(contained.allocatedSpace, AllocatedSpace(Point(3,4), Point(1,2)))
  }

  func testClearAllocatedSpaceCasheWhenSpriteIsResized() {
    XCTAssertEqual(contained.allocatedSpace, AllocatedSpace(Point(0,0), Point(1,2)))
    contained.set(property:spriteSize, to:Point(4,5))
    XCTAssertEqual(contained.allocatedSpace, AllocatedSpace(Point(0,0), Point(4,5)))
  }
}
