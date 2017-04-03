import Dispatch

import Sui
import CSDL2

let sdlWindow:WidgetProperty<OpaquePointer?> = WidgetProperty(nil)
var openWindows:[UInt32:Widget]=[:]
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
        SDL_WaitEvent(&evt)
        DispatchQueue.main.sync {
          switch SDL_EventType(evt.type) {
          case SDL_WINDOWEVENT:
            switch evt.window.event {
            case SDL_WINDOWEVENT_CLOSE:
              openWindows[evt.window.windowID]!.container=nil
            default:
              break
            }
          default:
            break
          }
        }
      }
    }
  }
  return createApp(
    implementation:Implementation(
      createWindow:{
        widget in
        let window:OpaquePointer=SDL_CreateWindow(
            "Hello World",
            widget.allocatedSpace.position.x,
            widget.allocatedSpace.position.y,
            widget.allocatedSpace.size.x,
            widget.allocatedSpace.size.y,
            SDL_WINDOW_RESIZABLE
          )
        widget.set(
          property:sdlWindow,
          to:window
        )
        openWindows[SDL_GetWindowID(window)]=widget
      },
      destroyWindow:{
        widget in
        openWindows.removeValue(
          forKey:SDL_GetWindowID(widget.get(property:sdlWindow))
        )
        SDL_DestroyWindow(widget.get(property:sdlWindow))
      }
    ),
    properties:properties,
    style:style,
    contents:contents
  )
}

