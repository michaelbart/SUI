import Quick
import Nimble
@testable import Sui
import Foundation
import Properties

class SuiStylePropertiesSpec: QuickSpec {
  override func spec() {
    describe("StyleMethods") {
      context("calls") {
        var called=true

        let widgetType=WidgetType(parent:anyWidgetType)
        let oldContainerType=WidgetType(parent:anyWidgetType)
        let newContainerType=WidgetType(parent:anyWidgetType)

        var widget=Widget(type:anyWidgetType)
        var otherWidget=Widget(type:anyWidgetType)
        var oldContainer=Widget(type:anyWidgetType)
        var newContainer=Widget(type:anyWidgetType)

        beforeEach {
          oldContainer=Widget(type:oldContainerType)
          newContainer=Widget(type:newContainerType)
          widget=Widget(type:widgetType)
          otherWidget=Widget(type:widgetType)
          widget.container=oldContainer

          called=false
        }
        afterEach {
          expect{called}.to(equal(true))
        }

        it("removedFromContainer when changing parents") {
          widget.style=Style(
            widgetType <- [
              removedFromContainer <- {
                (container, contained) in
                expect{contained}.to(equal(widget))
                expect{container}.to(equal(oldContainer))
                called=true
              }
            ]
          )
          widget.container=newContainer
        }

        it("addedToContainer when changing parents") {
            widget.style=Style(
              widgetType <- [
              addedToContainer <- {
                (container, contained) in
                expect{contained}.to(equal(widget))
                expect{container}.to(equal(newContainer))
                called=true
              }
            ]
          )
          widget.container=newContainer
        }

        it("addedContained when changing parents") {
          newContainer.style=Style(
            newContainerType <- [
              addedContained <- {
                (container, contained) in
                expect{contained}.to(equal(widget))
                expect{container}.to(equal(newContainer))
                called=true
              }
            ]
          )
          widget.container=newContainer
        }

        it("RemovedContained when changing parents") {
          oldContainer.style=Style(
            oldContainerType <- [
              removedContained <- {
                (container, contained) in
                expect{contained}.to(equal(widget))
                expect{container}.to(equal(oldContainer))
                called=true
              }
            ]
          )
          widget.container=newContainer
        }

        it("contentsEmptied when contents are emptied") {
          oldContainer.style=Style(
            oldContainerType <- [
              contentsEmptied <- {
                (container) in
                expect{container}.to(equal(oldContainer))
                called=true
              }
            ]
          )
          otherWidget.container=oldContainer
          expect{called}.to(equal(false))
          otherWidget.container=newContainer
          expect{called}.to(equal(false))
          widget.container=newContainer
        }
      }
    }
  }
}

