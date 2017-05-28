public struct Implementation {
  var createWindow:(Widget)->()
  var destroyWindow:(Widget)->()
  var changeAllocatedSpace:(Widget)->()

  public init(
    createWindow: @escaping (Widget)->() = {
      widget in
    },
    destroyWindow: @escaping (Widget)->() = {
      widget in
    },
    changeAllocatedSpace: @escaping (Widget)->() = {
      widget in
    }
  ) {
   self.createWindow=createWindow
   self.destroyWindow=destroyWindow
   self.changeAllocatedSpace=changeAllocatedSpace
  }
}

