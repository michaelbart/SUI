import Foundation
import AbstractionAsserter
import Properties

private let leftSide = Property<Int32, Widget>(0)
private let rightSide = Property<Int32, Widget>(0)
private let leftMoldable = Property<Int32, Widget>(0)
private let rightMoldable = Property<Int32, Widget>(0)

public class HorizontalLayout: Layout {
  /**
    Gets RequestedSize of widget.
    This is called automaticly when getting Widget.requestedSize.
    If the value is not already cashed and is not required to be called directly.
    - Parameter widget: The widget to get the RequestedSize for.
    - Returns: The RequestedSize for the widget.
  */
  public func getRequestedSize(_ widget:Widget) -> RequestedSize {
    var requestedSize=RequestedSize(Point(0,0), moldable: Point(0,0))

    for child in widget.contents {
      let childRequestedSize=child.requestedSize

      child.set(property:leftSide, to: requestedSize.size.x)
      child.set(property:leftMoldable, to: requestedSize.moldable.x)

      requestedSize=RequestedSize(
        Point(
          requestedSize.size.x+childRequestedSize.size.x,
          (
            requestedSize.moldable.y
              * requestedSize.size.x
              * requestedSize.size.y
            + childRequestedSize.moldable.y
              * childRequestedSize.size.x
              * childRequestedSize.size.y
          ) / (
            requestedSize.size.x * requestedSize.moldable.y
            + childRequestedSize.size.x * childRequestedSize.moldable.y
          )
        ),
        moldable:Point(
          childRequestedSize.moldable.x + (
            (requestedSize.size.x == 0) ? 0 : requestedSize.moldable.x
          ),
          (
            requestedSize.moldable.y * requestedSize.size.x
            + childRequestedSize.moldable.y * childRequestedSize.size.x
          ) / (
            requestedSize.size.x + childRequestedSize.size.x
          )
        )
      )
      child.set(property:rightSide, to: requestedSize.size.x)
      child.set(property:rightMoldable, to: requestedSize.moldable.x)
    }

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
    guard let container=widget.container else {
      /* TODO Swift warn */
      return AllocatedSpace(
        Point(0,0),
        widget.requestedSize.size
      )
    }

    let remainder = container.allocatedSpace.size.x - container.requestedSize.size.x

    let modledLeftSide =
       widget.get(property:leftSide) + remainder
       * widget.get(property:leftMoldable) / container.requestedSize.moldable.x

    let modledRightSide =
        widget.get(property:rightSide) + remainder
        *  widget.get(property:rightMoldable) / container.requestedSize.moldable.x
        - modledLeftSide

    return AllocatedSpace(
      Point(
        modledLeftSide,
        0
      ),
      Point(
        modledRightSide,
        container.allocatedSpace.size.y
      )
    )
  }

  public init() {
  }
}

