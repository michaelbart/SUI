import Dispatch

import Sui
import CSDL2

let sdlWindow:WidgetProperty<OpaquePointer?> = WidgetProperty(nil)
private var sdlHasInit=false

public func sdlCreateApp(
  properties:WidgetProperties?=nil,
  style:Style?=nil,
  contents:[Widget]=[]
  ) -> Widget {
  if SDL_Init(Uint32(SDL_INIT_VIDEO)) < 0 {
    assert(false, "error initialising SDL")
  }
  if sdlHasInit==false {
    sdlHasInit=true
    DispatchQueue(label: "com.amnykon.sui.sdlEventLoop").async {
      TTF_Init()
      SDL_StartTextInput()
      while true {
        var evt:SDL_Event = SDL_Event()
        SDL_PollEvent(&evt)
      }
    }
  }
  return createApp(
    implementation:Implementation(
      createWindow:{
        widget in
        widget.set(
          property:sdlWindow,
          to:SDL_CreateWindow(
            "Hello World",
            widget.allocatedSpace.position.x,
            widget.allocatedSpace.position.y,
            widget.allocatedSpace.size.x,
            widget.allocatedSpace.size.y,
            SDL_WINDOW_RESIZABLE
          )
        )
      },
      destroyWindow:{
        widget in
        SDL_DestroyWindow(widget.get(property:sdlWindow))
      }
    ),
    properties:properties,
    style:style
  )
}

