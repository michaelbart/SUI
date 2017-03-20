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
  override public func getRequestedSize(_ widget:Widget) -> RequestedSize {
    return requestedSize
  }

  /**
    Creates a new FixedLayout.
    - Parameter min: The minimum requested size for x and y.
    - Parameter max: The maximum requested size for x and y.
  */
  public init(min:Point, max:Point)  {
    requestedSize=RequestedSize(min,max)
    super.init()
  }
}

