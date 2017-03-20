import Sui
import CSDL2

let sdlWindow:WidgetProperty<OpaquePointer?> = WidgetProperty(nil)

public func sdlCreateApp(
  properties:WidgetProperties?=nil,
  style:Style?=nil,
  contents:[Widget]=[]
  ) -> Widget {
  if SDL_Init(Uint32(SDL_INIT_VIDEO)) < 0 {
    assert(false, "error initialising SDL")
  }
  TTF_Init()
  SDL_StartTextInput()
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

