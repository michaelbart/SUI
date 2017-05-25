import SdlSui
import Sui
import Foundation

let app=sdlCreateApp(
  contents:[
    Widget(
      type:anyWidgetType,
      properties:WidgetProperties(
        WidgetPropertyValue(spriteSize, Point(200,300))
      )
    )
  ]
)

RunLoop.main.run()
