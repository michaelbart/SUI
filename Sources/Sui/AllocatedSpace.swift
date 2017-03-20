public struct AllocatedSpace {
  public var position:Point
  public var size:Point

  /**
    Creates a new AllocatedSpace.
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

