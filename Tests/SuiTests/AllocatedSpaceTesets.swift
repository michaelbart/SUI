import XCTest
@testable import Sui
import Properties

class AllocatedSpaceTests: XCTestCase {
  func testEquals() {
    XCTAssert(AllocatedSpace(Point(2,3),Point(4,5)) == AllocatedSpace(Point(2,3),Point(4,5)))
    XCTAssert(AllocatedSpace(Point(3,3),Point(4,5)) != AllocatedSpace(Point(2,3),Point(4,5)))
    XCTAssert(AllocatedSpace(Point(2,4),Point(4,5)) != AllocatedSpace(Point(2,3),Point(4,5)))
    XCTAssert(AllocatedSpace(Point(2,3),Point(5,5)) != AllocatedSpace(Point(2,3),Point(4,5)))
    XCTAssert(AllocatedSpace(Point(2,3),Point(4,6)) != AllocatedSpace(Point(2,3),Point(4,5)))
  }
}
