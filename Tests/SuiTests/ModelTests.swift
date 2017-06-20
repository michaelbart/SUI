import XCTest
@testable import Sui
import Properties

class ModelTests: XCTestCase {
  func testCreateAView() {
    let modelInt=Model(of:0)
    let view=modelInt.createView()
    XCTAssert(view.model === modelInt) 
  }

  func testCreateAControl() {
    let modelInt=Model(of:0)
    let control=modelInt.createControl()
    XCTAssert(control.model === modelInt) 
  }

  func testUpdateWidgetIfValueIsChanged() {
    let modelInt=Model(of:0)
    let modelWidget=MockModelWidget(of:modelInt)
    modelInt.value=2
    XCTAssert(modelWidget.hasUpdated)
  }

  func testChangeValueAfterControlHasBeenDeinit() {
    let modelInt=Model(of:0)
    do {
      _=MockModelWidget(of:modelInt)
    }
    modelInt.value=2
  }
}
