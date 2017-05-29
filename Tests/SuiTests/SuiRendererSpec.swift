import Quick
import Nimble
@testable import Sui
import Foundation
import Properties

class SuiRendererSpec: QuickSpec {
  override func spec() {
    describe("draw") {
      it("will call the style redraw style property when widget redraws") {
        var hasRedrawn=false
        let widget=Widget(type:anyWidgetType)
        widget.style=Style(
          properties:Properties(
            PropertyValue(
              redrawWidget
            ) {
              (window) in
              hasRedrawn = true
            }
          )
        )
        widget.redraw()
        expect(hasRedrawn).to(equal(true))
      }
    }
  }
}

