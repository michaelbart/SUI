import Sui
import CSDL2


private struct SdlSuiImplementaion:Implementation {
  func initialize() {
    if SDL_Init(Uint32(SDL_INIT_VIDEO)) < 0 {
      assert(false, "error initialising SDL")
    }
    TTF_Init()
    SDL_StartTextInput()
  }
}

