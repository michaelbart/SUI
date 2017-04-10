import Foundation
import AbstractionAsserter

public let SpriteSpace=WidgetProperty(AllocatedSpace(Point(0,0), Point(0,0)))

public class SpriteLayout: Layout {

  /**
    Gets RequestedSize of widget.
    This is called automaticly when getting Widget.requestedSize.
    If the value is not already cashed and is not required to be called directly.
    - Parameter widget: The widget to get the RequestedSize for.
    - Returns: The RequestedSize for the widget.
  */
  override public func getRequestedSize(_ widget:Widget) -> RequestedSize {
    return RequestedSize(Point(0,0))
}

  /**
    Allocate space for contained widget.
    This is called automaticly when getting Widget.allocateSpace.
    If the value is not already cashed and is not required to be called directly.
    - Parameter widget: The widget to allocate space for.
    - Returns: The AllocatedSpace for the widget.
  */
  override public func allocateSpace(_ widget:Widget) -> AllocatedSpace {
    return AllocatedSpace(
      Point(0,0),
      widget.requestedSize.size
    )
  }

  /**
    Creates a new SpriteLayout.
  */
  public override init()  {
    super.init()
  }
}

