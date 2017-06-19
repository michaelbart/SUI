import XCTest
@testable import Properties
import Foundation

class PropertyTests: XCTestCase {
  let test = Property<Int,()>(23)
  let testInt1 = Property<Int,()>(12)
  let testInt2 = Property<Int,()>(15)
  let testString = Property<String,()>("This is a test")
  let testTouple = Property<(Int,Int,Int,Int,Int,Int),()>((12,13,14,15,16,17) as (Int,Int,Int,Int,Int,Int))

  var properties=Properties<()>()

  override func setUp() {
    super.setUp()
    properties=Properties<()>()
  }

  func testWillReturnNilWhenRetrievingAnUnsetProperty() {
    XCTAssertNil(properties.get(property:test))
  }

  func testWillStoreAndRetrieveAProperty() {
    properties.set(property:test,to:12, obj: ())
    XCTAssertEqual(properties.get(property:test), 12)
  }

  func testWillStoreAndRetrieveDifferentTypesOfProperties() {
    properties.set(property:testInt1,to:12, obj: ())
    properties.set(property:testString,to:"This is a test", obj: ())
    properties.set(property:testTouple,to:(12,13,14,15,16,17), obj: ())
    properties.set(property:testInt2,to:15, obj: ())

    XCTAssertEqual(properties.get(property:testInt1), 12)
    XCTAssertEqual(properties.get(property:testString), "This is a test")
    XCTAssertEqual(properties.get(property:testTouple)?.0,12)
    XCTAssertEqual(properties.get(property:testTouple)?.1,13)
    XCTAssertEqual(properties.get(property:testTouple)?.2,14)
    XCTAssertEqual(properties.get(property:testTouple)?.3,15)
    XCTAssertEqual(properties.get(property:testTouple)?.4,16)
    XCTAssertEqual(properties.get(property:testTouple)?.5,17)
    XCTAssertEqual(properties.get(property:testInt2),15)
  }
  func testCanBeInitallizedWithDefaultValues() {
    properties=Properties(
      PropertyValue(testInt1,12),
      PropertyValue(testString,"This is a test"),
      PropertyValue(testTouple,(12,13,14,15,16,17)),
      PropertyValue(testInt2,15)
    )
    XCTAssertEqual(properties.get(property:testInt1), 12)
    XCTAssertEqual(properties.get(property:testString), "This is a test")
    XCTAssertEqual(properties.get(property:testTouple)?.0,12)
    XCTAssertEqual(properties.get(property:testTouple)?.1,13)
    XCTAssertEqual(properties.get(property:testTouple)?.2,14)
    XCTAssertEqual(properties.get(property:testTouple)?.3,15)
    XCTAssertEqual(properties.get(property:testTouple)?.4,16)
    XCTAssertEqual(properties.get(property:testTouple)?.5,17)
    XCTAssertEqual(properties.get(property:testInt2),15)
  }
  func testPropertyValuecanBeCreatedByUsingPutIntoOperator() {
    properties=Properties(
      testInt1 <- 12
    )
    XCTAssertEqual(properties.get(property:testInt1), 12)
  }
}
