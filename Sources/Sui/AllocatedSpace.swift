public struct AllocatedSpace {
  var position:Point
  var size:Point

  /**
    Creates a newAllocatedSpace.
    - Parameter position: The position of the allocated space.
    - Parameter size: The size of the allocated space.
  */
  init(_ position:Point, _ size:Point) {
    self.position=position
    self.size=size
  }
}

extension AllocatedSpace:Equatable {}

public func ==(lhs: AllocatedSpace , rhs: AllocatedSpace ) -> Bool {
    return lhs.position == rhs.position && lhs.size == rhs.size
}
