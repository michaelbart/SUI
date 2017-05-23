import SdlSui
import Sui
import Foundation

let app=sdlCreateApp(
  contents:[
    Widget(
      type:anyWidgetType
    )
  ]
)

RunLoop.main.run()
