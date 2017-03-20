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
          }
        )
      )
    ]
  )
)

