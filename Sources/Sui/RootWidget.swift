private let rootWidgetType=WidgetType(parent:anyWidgetType)
import Darwin
import Properties

let rootWidget=Widget(
  type:rootWidgetType,
  style:Style(
    rootWidgetType <- [
      addedContained <- {
        (container, contained) in
        for window in contained.contents {
          contained.get(
            property:impementationProperty
          )?.createWindow(window)
        }
      },
      removedContained <- {
        (container, contained) in
        for window in contained.contents {
          contained.get(
            property:impementationProperty
          )?.destroyWindow(contained)
        }
      }
    ],

    appWidgetType <- [
      layoutProperty <- SpriteLayout(),
      addedContained <- {
        (container, contained) in
        container.get(
        property:impementationProperty
        )?.createWindow(contained)
      },
      removedContained <- {
         (container, contained) in
         container.get(
           property:impementationProperty
         )?.destroyWindow(contained)
       },
       contentsEmptied <- {
         (widget) in
         exit(0)
       }
    ],

    WidgetHierarchy.compound(.type(appWidgetType), .type(anyWidgetType)) <- [
      allocatedSpaceChanged <- {
        (widget) in
        widget.container?.get(
          property:impementationProperty
        )?.changeAllocatedSpace(widget)
      }
    ]
  )
)

