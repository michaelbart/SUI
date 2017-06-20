@testable import Sui

class MockModelWidget<T:Any> : ModelWidget<T> {
  override init(of model:Model<T>) {
    super.init(of:model)
  }
  var hasUpdated=false
  override func update() {
    hasUpdated=true
  }
}

