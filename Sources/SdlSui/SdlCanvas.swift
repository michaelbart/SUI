import Sui
import CSDL2
import Properties

class SdlCanvas:Canvas {
  let image:OpaquePointer?
  let size:Point
  var color=Color(red: 255, green: 255, blue: 255)

  public func draw(point: Sui.Point, renderer: Sui.Renderer) {
    SDL_SetRenderDrawColor(
       image,
       color.red,
       color.green,
       color.blue,
       color.alpha
    )
    SDL_RenderDrawPoint(image,point.x + renderer.position.x,point.y + renderer.position.y)
  }

  init(for window: Widget){
    size = window.allocatedSpace.size
    image=window.get(property:sdlRenderer)
  }
}

