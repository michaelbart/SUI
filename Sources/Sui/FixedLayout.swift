import Foundation
import AbstractionAsserter

public class FixedLayout: Layout {
  let requestedSize:RequestedSize

  /**
    Gets RequestedSize of widget.
    This is called automaticly when getting Widget.requestedSize.
    If the value is not already cashed and is not required to be called directly.
    - Parameter widget: The widget to get the RequestedSize for.
    - Returns: The RequestedSize for the widget.
  */
  public func getRequestedSize(_ widget:Widget) -> RequestedSize {
    return requestedSize
  }

  /**
    Allocate space for contained widget.
    This is called automaticly when getting Widget.allocateSpace.
    If the value is not already cashed and is not required to be called directly.
    - Parameter widget: The widget to allocate space for.
    - Returns: The AllocatedSpace for the widget.
  */
  public func allocateSpace(_ widget:Widget) -> AllocatedSpace {
    return AllocatedSpace(Point(0,0),Point(0,0))
  }

  /**
    Creates a new FixedLayout.
    - Parameter min: The minimum requested size for x and y.
    - Parameter max: The maximum requested size for x and y.
  */
  public init(_ requestedSize:RequestedSize)  {
    self.requestedSize=requestedSize
  }
}

