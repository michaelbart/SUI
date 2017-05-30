import Sui
import CSDL2
import Properties

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

    startEventLoop()
  }

  return createApp(
    implementation:SdlImplementation(),
    properties:properties,
    style:style,
    contents:contents
  )
}

