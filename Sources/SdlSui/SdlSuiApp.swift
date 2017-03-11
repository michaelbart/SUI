import Sui
import CSDL2

class SdlSuiApp:App {
  /**
    Creates a SdlSuiApp. This App creates windows and widgets using the SDL library.
  */
  override public init() {
    if SDL_Init(Uint32(SDL_INIT_VIDEO)) < 0 {
      assert(false, "error initialising SDL")
    }
    super.init()
  }

  deinit {
    SDL_Quit()
  }

}

public func initSdlSuiApp() {
  TTF_Init()
  SDL_StartTextInput()
  initSui(app:SdlSuiApp())
}

