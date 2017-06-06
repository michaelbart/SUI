import Sui
import CSDL2
import Properties

let sdlWindow:Property = Property<OpaquePointer?, Widget>(nil)
let sdlRenderer:Property = Property<OpaquePointer?, Widget>(nil)

var openWindows:[UInt32:Widget]=[:]

class SdlImplementation: Implementation {
  func createWindow(_ widget:Widget)->() {
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

    let renderer = SDL_CreateRenderer(window, -1, 0)
    widget.set(property:sdlRenderer, to:renderer)
  }

  func destroyWindow(_ widget:Widget)->() {
    let window = widget.get(property:sdlWindow)
    openWindows.removeValue(
      forKey:SDL_GetWindowID(window)
    )
    SDL_DestroyWindow(window)
  }

  func changeAllocatedSpace(_ widget:Widget)->() {
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

  init() {
  }
}

