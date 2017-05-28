import SdlSui
import Sui
import Foundation
import Properties

let widget =
  Widget(
    type:anyWidgetType,
    properties: [
      PropertyValue(spriteSize, Point(200,300)),
      PropertyValue(spritePosition, Point(200,300)),
    ]
)

let app=sdlCreateApp(
  properties: [],
  contents:[
     widget,
  ]
)

widget.set(property: spritePosition, to: Point(600,300))
widget.set(property: spriteSize, to: Point(300,600))

RunLoop.main.run()
