import XCTest
@testable import Sui
import Properties

class WidgetTypeTests: XCTestCase {

  let parent = WidgetType(parent:anyWidgetType)
  var child = WidgetType(parent:anyWidgetType)

  override func setUp() {
    super.setUp()

    child=WidgetType(parent:parent)
  }

  func testCompare() {
    XCTAssert(child == child)
    XCTAssert(child != parent)
    XCTAssert(parent != child)
    XCTAssert(parent == parent)
  }

  func testHash() {
    XCTAssertEqual(child.hashValue,child.hashValue)
    XCTAssertNotEqual(child.hashValue,parent.hashValue)
    XCTAssertNotEqual(parent.hashValue,child.hashValue)
    XCTAssertEqual(parent.hashValue,parent.hashValue)
  }

  func testCanBeUsedAsAKeyForADictionary() {
    let dic=[
      child:"child",
      parent:"parent",
      anyWidgetType:"anyWidgetType"
    ]
    XCTAssertEqual(dic[child],"child")
    XCTAssertEqual(dic[parent],"parent")
    XCTAssertEqual(dic[anyWidgetType],"anyWidgetType")
  }

  func testidentifyParents() {
    XCTAssert(child.isChild(of:parent))
    XCTAssert(child.isChild(of:anyWidgetType))
    XCTAssert(parent.isChild(of:anyWidgetType))
    XCTAssert(parent.isChild(of:parent))
    XCTAssert(!parent.isChild(of:child))
  }
}
