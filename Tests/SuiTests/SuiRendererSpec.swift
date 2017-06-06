import Quick
import Nimble
@testable import Sui
import Foundation
import Properties

class SuiRendererSpec: QuickSpec {
  override func spec() {
    describe("draw") {
      it("will call the style drawForground style property when widget draws") {
        var hasRedrawn=false
        let widget=Widget(type:anyWidgetType)
        widget.style=Style(
          properties:Properties(
            PropertyValue(
              drawForground
            ) {
              (window) in
              hasRedrawn = true
            }
          )
        )
        let canvas = MocCanvas()
        let renderer = Renderer(canvas:canvas)
        widget.draw(renderer: renderer)
        expect(hasRedrawn).to(equal(true))
      }
      it("will call the style drawBackground style property when widget draws") {
        var hasRedrawn=false
        let widget=Widget(type:anyWidgetType)
        widget.style=Style(
          properties:Properties(
            PropertyValue(
              drawBackground
            ) {
              (window) in
              hasRedrawn = true
            }
          )
        )
        let canvas = MocCanvas()
        let renderer = Renderer(canvas:canvas)
        widget.draw(renderer: renderer)
        expect(hasRedrawn).to(equal(true))
      }
      it("will draw contents when widget draws") {
        var hasRedrawn=false
        let container=Widget(type:anyWidgetType)
        let widget=Widget(type:anyWidgetType)
        widget.container = container
        widget.style=Style(
          properties:Properties(
            PropertyValue(
              layoutProperty,
              FixedLayout(RequestedSize(Point(1,1)))
            ),
            PropertyValue(
              drawBackground
            ) {
              (window) in
              hasRedrawn = true
            }
          )
        )
        let canvas = MocCanvas()
        let renderer = Renderer(canvas:canvas)
        container.draw(renderer: renderer)
        expect(hasRedrawn).to(equal(true))
      }
      it("will draw background before contents") {
        var hasRedrawn=false
        let container=Widget(type:anyWidgetType)
        container.style=Style(
          properties:Properties(
            PropertyValue(
              drawBackground
            ) {
              (window) in
              hasRedrawn = true
            }
          )
        )
        let widget=Widget(type:anyWidgetType)
        widget.container = container
        widget.style=Style(
          properties:Properties(
            PropertyValue(
              layoutProperty,
              FixedLayout(RequestedSize(Point(1,1)))
            ),
            PropertyValue(
              drawBackground
            ) {
              (window) in
              expect(hasRedrawn).to(equal(true))
            }
          )
        )
        let canvas = MocCanvas()
        let renderer = Renderer(canvas:canvas)
        container.draw(renderer: renderer)
      }
      it("will draw contents before forground") {
        var hasRedrawn=false
        let container=Widget(type:anyWidgetType)
        container.style=Style(
          properties:Properties(
            PropertyValue(
              drawForground
            ) {
              (window) in
              expect(hasRedrawn).to(equal(true))
            }
          )
        )
        let widget=Widget(type:anyWidgetType)
        widget.container = container
        widget.style=Style(
          properties:Properties(
            PropertyValue(
              layoutProperty,
              FixedLayout(RequestedSize(Point(1,1)))
            ),
            PropertyValue(
              drawBackground
            ) {
              (window) in
              hasRedrawn = true
            }
          )
        )
        let canvas = MocCanvas()
        let renderer = Renderer(canvas:canvas)
        container.draw(renderer: renderer)
      }
    }
  }
}

