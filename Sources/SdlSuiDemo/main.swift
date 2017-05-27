import SdlSui
import Sui
import Foundation
import Properties

let app=sdlCreateApp(
  properties: PropertyValues<Widget>(), contents:[
    Widget(
      type:anyWidgetType,
      properties: PropertyValues(propertyValues: PropertyValue(spriteSize, Point(200,300)))
    )
  ]
)

RunLoop.main.run()
