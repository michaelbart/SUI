import Foundation
import AbstractionAsserter
import LimitOperator

public class VerticalLayout: Layout {
  /**
    Gets RequestedSize of widget.
    This is called automaticly when getting Widget.requestedSize.
    If the value is not already cashed and is not required to be called directly.
    - Parameter widget: The widget to get the RequestedSize for.
    - Returns: The RequestedSize for the widget.
  */
  override public func getRequestedSize(_ widget:Widget) -> RequestedSize {
    var requestedSize=RequestedSize(Point(0,0),Point(Int32.max,0))

    for child in widget.contents {
      let childRequestedSize=child.requestedSize
      requestedSize=RequestedSize(
        Point(
          max(requestedSize.min.x,childRequestedSize.min.x),
          requestedSize.min.y^+childRequestedSize.min.y
        ),
        Point(
          min(requestedSize.max.x,childRequestedSize.max.x),
          requestedSize.max.y^+childRequestedSize.max.y 
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
      miny = miny ^+ contained.requestedSize.min.y
      maxy = maxy ^+ contained.requestedSize.min.y
      if contained === widget {
        return AllocatedSpace(
          Point(
            0,
            allocatedSpace
          ),
          Point(
            container.allocatedSpace.size.x,
            (
              container.allocatedSpace.size.y ^- container.requestedSize.min.y
            ) ^* (
              maxy ^- miny
            ) / (
              container.requestedSize.max.y ^+ container.requestedSize.min.y
            ) ^+ miny ^- allocatedSpace
          )
        )
      }
      allocatedSpace = allocatedSpace ^+ contained.allocatedSpace.size.y
    }
    /* TODO Swift warn */
    return AllocatedSpace(
      Point(0,0),
      widget.requestedSize.min
    )
  }
}

