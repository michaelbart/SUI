import Quick
import Nimble
@testable import Sui
import Foundation
import LimitOperator
import Properties

class SuiLayoutSpec: QuickSpec {
  override func spec() {

    describe("Point") {
      it("can check for equality") {
        expect{Point(2,3)==Point(2,3)}.to(equal(true))
        expect{Point(3,3)==Point(2,3)}.to(equal(false))
        expect{Point(2,4)==Point(2,3)}.to(equal(false))
      }
      it("can add to another Point") {
        expect{Point(2,3)+Point(7,4)}.to(equal(Point(9,7)))
      }
      it("can limit add to another Point") {
        expect{Point(Int32.max,3)^+Point(7,4)}.to(equal(Point(Int32.max,7)))
        expect{Point(3,Int32.max)^+Point(7,4)}.to(equal(Point(10,Int32.max)))
      }
      it("can subtract from another Point") {
        expect{Point(9,7)-Point(2,3)}.to(equal(Point(7,4)))
      }
      it("can be devided by an int") {
        expect{Point(4,6)/2}.to(equal(Point(2,3)))
        expect{Point(5,6)/2}.to(equal(Point(2,3)))
      }
      it("can be divided by another Point") {
        expect{Point(2,6)/Point(2,3)}.to(equal(Point(1,2)))
      }
      it("can be multiplied by another Point") {
        expect{Point(2,6)*Point(2,3)}.to(equal(Point(4,18)))
      }
      it("can get the max value for each dimension") {
        expect{max(Point(2,6),Point(4,3))}.to(equal(Point(4,6)))
      }
      it("can get the min value for each dimension") {
        expect{min(Point(2,6),Point(4,3))}.to(equal(Point(2,3)))
      }
    }

    describe("RequestedSize") {
      it("can check for equality") {
        expect{RequestedSize(Point(7,1))==RequestedSize(Point(7,1))}.to(equal(true))
        expect{RequestedSize(Point(8,1))==RequestedSize(Point(7,1))}.to(equal(false))
        expect{RequestedSize(Point(7,2))==RequestedSize(Point(7,1))}.to(equal(false))
      }
    }

    describe("AllocatedSpace") {
      it("can check for equality") {
        expect{AllocatedSpace(Point(7,1),Point(8,2))==AllocatedSpace(Point(7,1),Point(8,2))}.to(equal(true))
        expect{AllocatedSpace(Point(8,1),Point(8,2))==AllocatedSpace(Point(7,1),Point(8,2))}.to(equal(false))
        expect{AllocatedSpace(Point(7,2),Point(8,2))==AllocatedSpace(Point(7,1),Point(8,2))}.to(equal(false))
        expect{AllocatedSpace(Point(7,1),Point(9,2))==AllocatedSpace(Point(7,1),Point(8,2))}.to(equal(false))
        expect{AllocatedSpace(Point(7,1),Point(8,3))==AllocatedSpace(Point(7,1),Point(8,2))}.to(equal(false))
      }
    }

    describe("LayoutProperty") {
      it("'s default behavior is VerticalLayout") {
        let widgetType=WidgetType(parent:anyWidgetType)
        let widget=Widget(type:widgetType)
        expect{String(describing:type(of:widget.get(property:layoutProperty)))}
          .to(equal(String(describing:VerticalLayout.self)))
      }
    }

    describe("FixedLayout") {
      it("will getRequestedSize") {
        let widgetType=WidgetType(parent:anyWidgetType)
        let widget=Widget(type:widgetType)
        widget.style=Style(
          widgetType <- [
            layoutProperty <- FixedLayout(RequestedSize(Point(1,2)))
          ]
        )
        expect{widget.requestedSize}.to(equal(RequestedSize(Point(1,2))))
      }
    }

    describe("SpriteLayout") {
      let widgetType=WidgetType(parent:anyWidgetType)
      let widget=Widget(type:widgetType)
      var contained=Widget(type:widgetType)
      beforeEach{
        contained=Widget(type:widgetType)
        widget.style=Style(
          widgetType <- [
            layoutProperty <- SpriteLayout()
          ],
          WidgetHierarchy.compound(WidgetHierarchy.type(widgetType), WidgetHierarchy.type(widgetType)) <- [
            layoutProperty <- FixedLayout(RequestedSize(Point(1,2)))
          ]
        )
        contained.container=widget
      }
      it("will getRequestedSize") {
        expect{widget.requestedSize}.to(equal(RequestedSize(Point(0,0))))
        expect{contained.requestedSize}.to(equal(RequestedSize(Point(1,2))))
      }
      it("will AllocateSpace") {
        contained.set(property:spritePosition, to:Point(3,4))
        contained.set(property:spriteSize, to:Point(4,5))
        expect{widget.allocatedSpace}.to(equal(AllocatedSpace(Point(0,0),Point(0,0))))
        expect{contained.allocatedSpace}.to(equal(AllocatedSpace(Point(3,4),Point(4,5))))
      }
      it("will clear AllocatedSpace when spritePosition is modified") {
        expect{contained.allocatedSpace}.to(equal(AllocatedSpace(Point(0,0),Point(1,2))))
        contained.set(property:spritePosition, to:Point(3,4))
        expect{contained.allocatedSpace}.to(equal(AllocatedSpace(Point(3,4),Point(1,2))))
      }
      it("will clear allocatedSpace Cashe when spriteSize is modified") {
        expect{contained.allocatedSpace}.to(equal(AllocatedSpace(Point(0,0),Point(1,2))))
        contained.set(property:spriteSize, to:Point(4,5))
        expect{contained.allocatedSpace}.to(equal(AllocatedSpace(Point(0,0),Point(4,5))))
      }
    }

    describe("VerticalLayout") {
      let widgetType=WidgetType(parent:anyWidgetType)
      var widget=Widget(type:widgetType)
      var child1=Widget(type:widgetType)
      var child2=Widget(type:widgetType)
      beforeEach{
        widget=Widget(type:widgetType)
        child1=Widget(type:widgetType)
        child2=Widget(type:widgetType)
        child1.container=widget
        child2.container=widget

        widget.style=Style(
          widgetType <- [
            layoutProperty <- VerticalLayout()
          ],

          WidgetHierarchy.compound(WidgetHierarchy.type(widgetType), WidgetHierarchy.type(widgetType)) <- [
             layoutProperty <- FixedLayout(RequestedSize(Point(1,2)))
          ]
        )
      }
      it("will getRequestedSize") {
        expect{widget.requestedSize}.to(equal(RequestedSize(Point(1,4), moldable:Point(1,2))))
      }
      it("will allocateSpace for contents") {
        expect(child1.allocatedSpace).to(equal(AllocatedSpace(Point(0,0), Point(1,2))))
        expect(child2.allocatedSpace).to(equal(AllocatedSpace(Point(0,2), Point(1,2))))
      }
    }

    describe("HorizontalLayout") {
      let widgetType=WidgetType(parent:anyWidgetType)
      var widget=Widget(type:widgetType)
      var child1=Widget(type:widgetType)
      var child2=Widget(type:widgetType)
      beforeEach{
        widget=Widget(type:widgetType)
        child1=Widget(type:widgetType)
        child2=Widget(type:widgetType)
        child1.container=widget
        child2.container=widget

        widget.style=Style(
            widgetType <- [
                layoutProperty <- HorizontalLayout()
            ],

            WidgetHierarchy.compound(WidgetHierarchy.type(widgetType), WidgetHierarchy.type(widgetType)) <- [
                layoutProperty <- FixedLayout(RequestedSize(Point(1,2)))
            ]
        )
      }
      it("will getRequestedSize") {
        expect{widget.requestedSize}.to(equal(RequestedSize(Point(2,2), moldable:Point(2,1))))
      }
      it("will allocateSpace for contents") {
        expect(child1.allocatedSpace).to(equal(AllocatedSpace(Point(0,0), Point(1,2))))
        expect(child2.allocatedSpace).to(equal(AllocatedSpace(Point(1,0), Point(1,2))))
      }
    }
  }
}

