import Dispatch

import Sui
import CSDL2
import Properties

let sdlWindow:Property = Property<OpaquePointer?, Widget>(nil)
var openWindows:[UInt32:Widget]=[:]
private var sdlHasInit=false

public func sdlCreateApp(
  properties:[GenericPropertyValue<Widget>],
  style:Style?=nil,
  contents:[Widget]=[]
  ) -> Widget {
  if SDL_Init(Uint32(SDL_INIT_VIDEO)) < 0 {
    assert(false, "error initialising SDL")
  }
  if sdlHasInit==false {
    sdlHasInit=true
    TTF_Init()
    SDL_StartTextInput()

    var block={}
    block={
      var evt:SDL_Event = SDL_Event()
      while( SDL_PollEvent(&evt) != 0) {
        switch SDL_EventType(evt.type) {
        case SDL_WINDOWEVENT:
          guard let window = openWindows[evt.window.windowID] else {
            break;
          }
          switch evt.window.event {
          case SDL_WINDOWEVENT_MOVED:
            window.set(property:spritePosition, to: Point(evt.window.data1,evt.window.data2))
          case SDL_WINDOWEVENT_RESIZED:
            window.set(property:spriteSize, to: Point(evt.window.data1,evt.window.data2))
          case SDL_WINDOWEVENT_CLOSE:
            window.container=nil
          case SDL_WINDOWEVENT_EXPOSED:
            window.get(property:redrawWidget)(window)
          default:
            break
          }
        default:
          break
        }
      }
      DispatchQueue.main.asyncAfter(deadline: DispatchTime.init(uptimeNanoseconds: 2000), execute: block)
    }
    DispatchQueue.main.async(execute:block)
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
        widget.set(property:sdlWindow, to:window)
        openWindows[SDL_GetWindowID(window)]=widget
      },
      destroyWindow:{
        widget in
        openWindows.removeValue(
          forKey:SDL_GetWindowID(widget.get(property:sdlWindow))
        )
        SDL_DestroyWindow(widget.get(property:sdlWindow))
      },
      changeAllocatedSpace: {
        widget in
        guard let _ = widget.get(property:sdlWindow) else {
          return
        }
        SDL_SetWindowPosition(
          widget.get(property:sdlWindow),
          widget.allocatedSpace.position.x,
          widget.allocatedSpace.position.y
        )
        SDL_SetWindowSize(
          widget.get(property:sdlWindow),
          widget.allocatedSpace.size.x,
          widget.allocatedSpace.size.y
        )
      }
    ),
    properties:properties,
    style:style,
    contents:contents
  )
}

