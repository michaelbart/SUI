private let rootWidgetType=WidgetType(parent:anyWidgetType)
import Darwin
import Properties

let rootWidget=Widget(
  type:rootWidgetType,
  style:Style(
    properties:Properties<Style>(
        PropertyValue(
        addedContained) {
        (container, contained) in
        for window in contained.contents {
          contained.get(
            property:impementationProperty
          )?.createWindow(window)
        }
      },
      PropertyValue(
        removedContained
      ) {
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
          PropertyValue(
            layoutProperty,
            SpriteLayout()
          ),
          PropertyValue(
            addedContained
          ) {
            (container, contained) in
            container.get(
              property:impementationProperty
            )?.createWindow(contained)
          },
          PropertyValue(
            removedContained
          ) {
            (container, contained) in
            container.get(
              property:impementationProperty
            )?.destroyWindow(contained)
          },
          PropertyValue(
            contentsEmptied
          ) {
            (widget) in
            exit(0)
          }
        ),
        children:[
          anyWidgetType:Style(
            properties:Properties(
              PropertyValue(
                allocatedSpaceChanged
              ) {
                (widget) in
                widget.container?.get(
                  property:impementationProperty
                )?.changeAllocatedSpace(widget)
              }
            ),
            children:[
              anyWidgetType:Style(
                properties:Properties(
                  PropertyValue(
                    allocatedSpaceChanged
                  ) {
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
          PropertyValue(
            addedContained
          ) {
            (container, contained) in
          },
          PropertyValue(
            removedContained
          ) {
            (container, contained) in
          },
          PropertyValue(
            contentsEmptied
          ) {
            (widget) in
          }
        )
      )
    ]
  )
)

