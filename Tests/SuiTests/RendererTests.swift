import XCTest
@testable import Sui
import Foundation
import Properties

class RendererTests: XCTestCase {

  var hasRedrawn = false
  var widget = Widget(type:anyWidgetType)
  var container = Widget(type:anyWidgetType)
  let renderer = Renderer(canvas:MocCanvas())

  override func setUp() {
    super.setUp()
    hasRedrawn = false
    widget = Widget(type:anyWidgetType)
    container = Widget(type:anyWidgetType)
    widget.container = container
  }

  func testDrawForgroundIsCalledWhenWidgetDraws() {
    widget.style=Style(
      anyWidgetType <- [
        drawForground <- {
          (window) in
          self.hasRedrawn = true
        }
      ]
    )
    widget.draw(renderer: renderer)
    XCTAssert(self.hasRedrawn)
  }

  func testDrawBackgroundIsCalledWhenWidgetDraws() {
    widget.style=Style(
      anyWidgetType <- [
        drawBackground <- {
          (window) in
          self.hasRedrawn = true
        }
      ]
    )
    widget.draw(renderer: renderer)
    XCTAssert(self.hasRedrawn)
  }

  func testWillDrawContentsWhenWidgetDraws() {
    widget.style=Style(
      anyWidgetType <- [
        layoutProperty <- FixedLayout(RequestedSize(Point(1,1))),
        drawBackground <- {
          (window) in
          self.hasRedrawn = true
        }
      ]
    )
    container.draw(renderer: renderer)
    XCTAssert(self.hasRedrawn)
  }

  func testWillDrawBackgroundBeforeContents() {
    container.style=Style(
      anyWidgetType <- [
        drawBackground <- {
          (window) in
          self.hasRedrawn = true
        }
      ],
      (anyWidgetType / anyWidgetType) <- [
        layoutProperty <- FixedLayout(RequestedSize(Point(1,1))),
        drawBackground <- {
          (window) in
          XCTAssert(self.hasRedrawn)
        }
      ]
    )
    container.draw(renderer: renderer)
  }

  func testWillDrawContentsBeforeBackground() {
    container.style=Style(
      anyWidgetType <- [
        drawForground <- {
          (window) in
          XCTAssert(self.hasRedrawn)
        }
      ],
      (anyWidgetType / anyWidgetType) <- [
        layoutProperty <- FixedLayout(RequestedSize(Point(1,1))),
        drawForground <- {
          (window) in
          self.hasRedrawn = true
        }
      ]
    )
    container.draw(renderer: renderer)
  }
}
