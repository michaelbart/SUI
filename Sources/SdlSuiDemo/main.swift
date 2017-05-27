import SdlSui
import Sui
import Foundation
import Properties

let app=sdlCreateApp(
  properties: [],
  contents:[
    Widget(
      type:anyWidgetType,
      properties: [PropertyValue(spriteSize, Point(200,300))]
    )
  ]
)

RunLoop.main.run()
