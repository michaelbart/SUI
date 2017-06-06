import SdlSui
import Sui
import Foundation
import Properties



let app=sdlCreateApp(
  properties: [],
  contents:[
    Widget(
      type:anyWidgetType,
      properties: [
        PropertyValue(spriteSize, Point(200,300)),
        PropertyValue(spritePosition, Point(200,300)),
      ],
      contents: [
        Widget(
          type:anyWidgetType,
          style:Style (
            properties: [
              PropertyValue(
                layoutProperty,
                FixedLayout(RequestedSize(Point(1,1)))
              ),
            ]
          )
        ),
        Widget(
          type:anyWidgetType,
          style:Style (
            properties: [
                PropertyValue(
                layoutProperty,
                FixedLayout(RequestedSize(Point(1,1)))
              ),
              PropertyValue(drawBackground) {
                (widget, renderer) in
                renderer.fill()
              },
            ]
          )
        )
      ]
    )
  ]
)

RunLoop.main.run()

