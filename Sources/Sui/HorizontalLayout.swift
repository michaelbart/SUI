import Foundation
import AbstractionAsserter
import LimitOperator

public class HorizontalLayout: Layout {
  /**
    Gets RequestedSize of widget.
    This is called automaticly when getting Widget.requestedSize.
    If the value is not already cashed and is not required to be called directly.
    - Parameter widget: The widget to get the RequestedSize for.
    - Returns: The RequestedSize for the widget.
  */
  override public func getRequestedSize(_ widget:Widget) -> RequestedSize {
    var requestedSize=RequestedSize(Point(0,0),Point(0,Int32.max))

    for child in widget.contents {
      let childRequestedSize=child.requestedSize
      requestedSize=RequestedSize(
        Point(
          requestedSize.min.x^+childRequestedSize.min.x,
          max(requestedSize.min.y,childRequestedSize.min.y)
        ),
        Point(
          requestedSize.max.x^+childRequestedSize.max.x,
          min(requestedSize.max.y,childRequestedSize.max.y)
        )
      )
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
        widget.requestedSize.min
      )
    }

    var miny:Int32=0
    var maxy:Int32=0
    var allocatedSpace:Int32=0
    for contained in container.contents {
      miny = miny ^+ contained.requestedSize.min.x
      maxy = maxy ^+ contained.requestedSize.min.x
      if contained === widget {
        return AllocatedSpace(
          Point(
            allocatedSpace,
            0
          ),
          Point(
            (
              container.allocatedSpace.size.x ^- container.requestedSize.min.x
            ) ^* (
              maxy ^- miny
            ) / (
              container.requestedSize.max.x ^+ container.requestedSize.min.x
            ) ^+ miny ^- allocatedSpace,
            container.allocatedSpace.size.y
          )
        )
      }
      allocatedSpace = allocatedSpace ^+ contained.allocatedSpace.size.x
    }
    /* TODO Swift warn */
    return AllocatedSpace(
      Point(0,0),
      widget.requestedSize.min
    )
  }
}

