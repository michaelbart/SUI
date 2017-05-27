import AbstractionAsserter
import LimitOperator
import Properties

private let topSide = Property<Int32, Widget>(0)
private let bottomSide = Property<Int32, Widget>(0)
private let topMoldable = Property<Int32, Widget>(0)
private let bottomMoldable = Property<Int32, Widget>(0)

public class VerticalLayout: Layout {
  /**
    Gets RequestedSize of widget.
    This is called automaticly when getting Widget.requestedSize.
    If the value is not already cashed and is not required to be called directly.
    - Parameter widget: The widget to get the RequestedSize for.
    - Returns: The RequestedSize for the widget.
  */
  override public func getRequestedSize(_ widget:Widget) -> RequestedSize {
    var requestedSize=RequestedSize(Point(0,0))

    for child in widget.contents {
      let childRequestedSize=child.requestedSize

      child.set(property:topSide, to: requestedSize.size.y)
      child.set(property:topMoldable, to: requestedSize.moldable.y)

      requestedSize=RequestedSize(
        Point(
          (
            requestedSize.moldable.x
              * requestedSize.size.x
              * requestedSize.size.y
            + childRequestedSize.moldable.x
              * childRequestedSize.size.x
              * childRequestedSize.size.y
          ) / (
            requestedSize.size.y * requestedSize.moldable.x
            + childRequestedSize.size.y * childRequestedSize.moldable.x
          ),
          requestedSize.size.y^+childRequestedSize.size.y
        ),
        moldable:Point(
          (
            requestedSize.moldable.x * requestedSize.size.y
            + childRequestedSize.moldable.x * childRequestedSize.size.y
          ) / (
            requestedSize.size.y + childRequestedSize.size.y
          ),
          childRequestedSize.moldable.y + (
            (requestedSize.size.y == 0) ? 0 : requestedSize.moldable.y
          )
        )
      )
      child.set(property:bottomSide, to: requestedSize.size.y)
      child.set(property:bottomMoldable, to: requestedSize.moldable.y)
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
  override public func allocateSpace(_ widget:Widget) -> AllocatedSpace {
    guard let container=widget.container else {
      /* TODO Swift warn */
      return AllocatedSpace(
        Point(0,0),
        widget.requestedSize.size
      )
    }

    let remainder=container.requestedSize.size.y - container.allocatedSpace.size.y

    let modledTopSide =
       widget.get(property:topSide) + remainder
       * container.requestedSize.moldable.y / widget.get(property:topMoldable)

    let modledBottomSide =
        widget.get(property:bottomSide) + remainder
        * container.requestedSize.moldable.y / widget.get(property:bottomMoldable)
        - modledTopSide

    return AllocatedSpace(
      Point(
        0,
        modledTopSide
      ),
      Point(
        container.allocatedSpace.size.x,
        modledBottomSide
      )
    )
  }
}
