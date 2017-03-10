import Sui
import CSDL2

public class SdlSuiApp:App {
  /**
    Creates a SdlSuiApp. This App creates windows and widgets using the SDL library.
  */
  override public init() {
    if SDL_Init(Uint32(SDL_INIT_VIDEO)) < 0 {
      assert(false, "error initialising SDL")
    }
    TTF_Init()
    super.init()
    SDL_StartTextInput()
  }

  deinit {
    SDL_Quit()
  }

}
