private let rootWidgetType=WidgetType(parent:anyWidgetType)

let rootWidget=Widget(
  type:rootWidgetType,
  style:Style(
    children:[
      appWidgetType:Style(
        properties:StyleProperties(
          StylePropertyValue(
            layoutProperty,
            SpriteLayout()
          ),
          StylePropertyValue(
            addedContained
          ) {
            (container, contained) in
            container.get(
              property:impementationProperty
            ).createWindow(contained)
          },
          StylePropertyValue(
            removedContained
          ) {
            (container, contained) in
            container.get(
              property:impementationProperty
            ).destroyWindow(contained)
          },
          StylePropertyValue(
            contentsEmptied
          ) {
            (widget) in
            eventLoopStop()
          }
        )
      ),
      anyWidgetType:Style(
        properties:StyleProperties(
         StylePropertyValue(
            addedContained
          ) {
            (container, contained) in
          },
          StylePropertyValue(
            removedContained
          ) {
            (container, contained) in
          },
          StylePropertyValue(
            contentsEmptied
          ) {
            (widget) in
          }
        )
      )
    ]
  )
)

