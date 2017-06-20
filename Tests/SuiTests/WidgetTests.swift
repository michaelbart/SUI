import XCTest
@testable import Sui
import Properties

class WidgetTests: XCTestCase {

  var widgetType=WidgetType(parent:anyWidgetType)
  var widget=MockWidget(type:anyWidgetType)

  override func setUp() {
     super.setUp()
     widgetType=WidgetType(parent:anyWidgetType)
     widget=MockWidget(type:widgetType)
  }

  // MARK: StyleCashe will clear tests
  func testStyleCasheWillClearWhenWidgetIsMovedToADifferentContainer() {
    let parent = Widget(type:widgetType)
    widget.container = parent
    XCTAssert(widget.cashedStyleCleared)
  }

  func testStyleCasheWillClearWhenStyleIsChanged() {
    widget.style = Style()
    XCTAssert(widget.cashedStyleCleared)
  }

  func testStyleCasheWillClearWhenContainersStyleCasheIsCleared() {
    let container = Widget(type: widgetType)
    widget.container = container
    widget.cashedStyleCleared = false
    container.clearStyleCashe()
    XCTAssert(widget.cashedStyleCleared)
  }

  // MARK: RequestSize cashe will clear tests
  func testRequestSizeCasheWillClearWhenStyleCasheIsCleared() {
    widget.clearStyleCashe()
    XCTAssert(widget.cashedRequestedSizeCleared)
  }

  func testRequestSizeCasheWillClearWhenContentsHaveBeenAdded() {
    let contained=Widget(type:widgetType)
    contained.container=widget
    XCTAssert(widget.cashedRequestedSizeCleared)
  }

  func testRequestSizeCasheWillClearWhenContentsHaveBeenRemoved() {
    let contained=Widget(type:widgetType)
    contained.container=widget
    widget.cashedRequestedSizeCleared=false
    contained.container=nil
    XCTAssert(widget.cashedRequestedSizeCleared)
  }

  func testRequestSizeCasheWillClearWhenAContainedsRequestSizeHasBeenCleared() {
    let contained=Widget(type:widgetType)
    contained.container=widget
    widget.cashedRequestedSizeCleared=false
    contained.clearRequestedSizeCashe()
    XCTAssert(widget.cashedRequestedSizeCleared)
  }

  // MARK: AllocatedSpace cashe will clear tests
  func testAllocatedSpaceCasheWillClearWhenRequestSizeHasBeenCleared() {
    widget.clearRequestedSizeCashe()
    XCTAssert(widget.cashedAllocatedSpaceCleared)
  }

  func testAllocatedCasheSpaceWillClearWhen() {
    let container=Widget(type:widgetType)
    widget.container=container
    widget.cashedAllocatedSpaceCleared=false
    container.clearAllocatedSpaceCashe()
    XCTAssert(widget.cashedAllocatedSpaceCleared)
  }
}
