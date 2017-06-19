import XCTest
@testable import Sui
import Foundation
import Properties

class StylePropertiesTests: XCTestCase {

  var called=true

  let widgetType=WidgetType(parent:anyWidgetType)
  let oldContainerType=WidgetType(parent:anyWidgetType)
  let newContainerType=WidgetType(parent:anyWidgetType)

  var widget=Widget(type:anyWidgetType)
  var otherWidget=Widget(type:anyWidgetType)
  var oldContainer=Widget(type:anyWidgetType)
  var newContainer=Widget(type:anyWidgetType)

  override func setUp() {
    super.setUp()
    oldContainer=Widget(type:oldContainerType)
    newContainer=Widget(type:newContainerType)
    widget=Widget(type:widgetType)
    otherWidget=Widget(type:widgetType)
    widget.container=oldContainer

    called=false

  }

  override func tearDown() {
    XCTAssert(called)
    super.tearDown()
  }

  func testRemovedFromContainerIsCalledWhenChangingParents() {
    widget.style=Style(
      widgetType <- [
        removedFromContainer <- {
          (container, contained) in
          XCTAssertEqual(contained, self.widget)
          XCTAssertEqual(container, self.oldContainer)
          self.called=true
        }
      ]
    )
    widget.container=newContainer
  }

  func testAddedToContainerIsCalledWhenChangingParents() {

    widget.style=Style(
      widgetType <- [
        addedToContainer <- {
          (container, contained) in
          XCTAssertEqual(contained, self.widget)
          XCTAssertEqual(container, self.newContainer)
          self.called=true
        }
      ]
    )
    widget.container=newContainer
  }

  func testAddedContainedIsCalledWhenChangingParents() {

    newContainer.style=Style(
      newContainerType <- [
        addedContained <- {
          (container, contained) in
          XCTAssertEqual(contained, self.widget)
          XCTAssertEqual(container, self.newContainer)
          self.called=true
        }
      ]
    )
    widget.container=newContainer
  }

  func testRemovedContainedIsCalledWhenChangingParents() {
    oldContainer.style=Style(
      oldContainerType <- [
        removedContained <- {
          (container, contained) in
          XCTAssertEqual(contained, self.widget)
          XCTAssertEqual(container, self.oldContainer)
          self.called=true
        }
      ]
    )
    widget.container=newContainer
  }

  func testContentsEmptiedIsCalledWhenContentsAreEmptied() {

    oldContainer.style=Style(
      oldContainerType <- [
        contentsEmptied <- {
          (container) in
          XCTAssertEqual(container, self.oldContainer)
          self.called=true
        }
      ]
    )
    otherWidget.container=oldContainer
    XCTAssert(!called)
    otherWidget.container=newContainer
    XCTAssert(!called)
    widget.container=newContainer
  }
}
