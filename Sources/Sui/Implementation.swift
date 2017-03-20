public struct Implementation {
  var createWindow:(Widget)->()
  var destroyWindow:(Widget)->()

  public init(
    createWindow: @escaping (Widget)->() = {
      widget in
    },
    destroyWindow: @escaping (Widget)->() = {
      widget in
    }
  ) {
   self.createWindow=createWindow
   self.destroyWindow=destroyWindow
  }
}

