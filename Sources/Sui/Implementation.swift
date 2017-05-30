public protocol Implementation: class {
  func createWindow(_ widget:Widget)->()
  func destroyWindow(_ widget:Widget)->()
  func changeAllocatedSpace(_ widget:Widget)->()
}

