import Dispatch

import Sui
import CSDL2
import Properties

func startEventLoop() {
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

