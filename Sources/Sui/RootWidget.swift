private let rootWidgetType=WidgetType(parent:anyWidgetType)
import Darwin
import Properties

let rootWidget=Widget(
  type:rootWidgetType,
  style:Style(
    properties:Properties<Style>(
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
    ),
    children:[
      appWidgetType:Style(
        properties:Properties(
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
        ),
        children:[
          anyWidgetType:Style(
            properties:Properties(
              layoutProperty <- VerticalLayout(),
              allocatedSpaceChanged <- {
                (widget) in
                widget.container?.get(
                  property:impementationProperty
                )?.changeAllocatedSpace(widget)
              }
            ),
            children:[
              anyWidgetType:Style(
                properties:Properties(
                  allocatedSpaceChanged <- {
                    (widget) in
                  }
                )
              ),
            ]
          ),
        ]
      ),
      anyWidgetType:Style(
        properties:Properties(
          addedContained <- {
            (container, contained) in
          },
          removedContained <- {
            (container, contained) in
          },
          contentsEmptied <- {
            (widget) in
          }
        )
      )
    ]
  )
)

