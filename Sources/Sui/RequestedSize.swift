public struct RequestedSize {
  var min:Point
  var max:Point

  /**
    Creates a new RequestedSize.
    - Paramiter min: The minimum requested size for x and y.
    - Parameter max: The maximum requested size for x and y.
  */
  init(_ min:Point, _ max:Point) {
    assert(min.x<=max.x, "create requestSize with invalid min.x(\(min.x))/max.x(\(max.x))")
    assert(min.y<=max.y, "create requestSize with invalid min.y(\(min.y))/max.y(\(max.y))")
    self.min=min
    self.max=max
  }
}

extension RequestedSize:Equatable {

  public static func ==(lhs: RequestedSize, rhs: RequestedSize) -> Bool {
      return lhs.min == rhs.min && lhs.max == rhs.max
  }
}

