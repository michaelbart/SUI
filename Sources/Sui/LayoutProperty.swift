import Foundation
import AbstractionAsserter

open /*abstract*/ class Layout: AbstractionAsserter {
  /**
    Gets RequestedSize of widget.
    This is called automaticly when getting Widget.requestedSize.
    If the value is not already cashed and is not required to be called directly.
    - Parameter widget: The widget to get the RequestedSize for.
    - Returns: The RequestedSize for the widget.
  */
  public func getRequestedSize(_ widget:Widget) -> RequestedSize {
    abstractMethod()
    return RequestedSize(Point(0,0),Point(0,0))
  }

  /**
    Allocate space for contained widget.
    This is called automaticly when getting Widget.allocateSpace.
    If the value is not already cashed and is not required to be called directly.
    - Parameter widget: The widget to allocate space for.
    - Returns: The AllocatedSpace for the widget.
  */
  public func allocateSpace(_ widget:Widget) -> AllocatedSpace {
    abstractMethod()
    return AllocatedSpace(Point(0,0),Point(0,0))
  }

  /**
    Creates a new Layout.
    This class is abstract and this should only be called by child classes.
  */
  public init() {
    abstractInit()
  }
}

let layoutProperty=Property(VerticalLayout() as Layout)

