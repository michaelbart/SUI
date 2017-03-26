import Quick
import Nimble
@testable import Sui
import Foundation

class SuiEventLoopSpec: QuickSpec {
  override func spec() {

    it("can start and stop an event loop") {
      var eventRan=false
      eventLoopPerform{
        eventRan=true
        eventLoopStop()
      }
      eventLoopRun()
      expect(eventRan).to(equal(true))
    }

    it("can start and stop an event loop recursively") {
      var event1Ran=false
      var event2Ran=false

      eventLoopPerform{
        eventLoopPerform{
          event1Ran=true
          eventLoopStop()
        }

        eventLoopRun()

        eventLoopPerform{
          event2Ran=true
          eventLoopStop()
        }
      }

      eventLoopRun()

      expect(event1Ran).to(equal(true))
      expect(event2Ran).to(equal(true))
    }
  }
}

