import Quick
import Nimble
@testable import Sui
import Foundation

class MockAppSpec: QuickSpec {
  override func spec() {
    it("will not run the eventloop if no") {
      mockCreateApp()
    }      
    it("runs the eventloop on init and stops when eventLoopStop is called") {
      var called=false
      eventLoopPerform{
        called=true
        eventLoopStop()
      }
      mockCreateApp()
      expect{called}.to(equal(false))
    }
    it("runs the eventloop on init and stops when contents are emptied") {
      var called=false
      let widget=Widget(type:anyWidgetType)
      eventLoopPerform{
        called=true
        widget.container=nil
      }
      mockCreateApp(contents:[widget])
      expect{called}.to(equal(true))
    }
  }
}

