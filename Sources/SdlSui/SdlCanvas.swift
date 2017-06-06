import Sui
import CSDL2
import Properties

class SdlCanvas:Canvas {
  let image:OpaquePointer?
  let size:Point

  public func draw(point: Sui.Point, renderer: Sui.Renderer) {
    SDL_RenderDrawPoint(image,point.x,point.y)
  }

  init(for window: Widget){
    size = window.allocatedSpace.size
    image=window.get(property:sdlRenderer)
  }
}
