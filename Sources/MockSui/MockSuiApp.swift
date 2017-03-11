import Sui

class MockSuiApp:App {
  /**
    Creates a MockSuiApp. This App does not create physical windows and widgets, 
    Instead it only creates them in memory. This should be used for testing.
  */
  override public init() {
    super.init()
  }
}

public func initMockSuiApp() {
  initSui(app:MockSuiApp())
}

