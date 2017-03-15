import Sui
import CSDL2

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
    implementation:Implementation(),
    properties:properties,
    style:style
  )
}

