import Quick
import Nimble
@testable import Sui
import Foundation
import LimitOperator

class MockModelWidget<T:Any> : ModelWidget<T> {
  override init(of model:Model<T>) {
    super.init(of:model)
  }
  var hasUpdated=false
  override func update() {
    hasUpdated=true
  }
}

class SuiSpec: QuickSpec {
  override func spec() {

    describe("Type") {
      let parent=WidgetType(parent:anyWidgetType)
      let child=WidgetType(parent:parent)

      it("will compare") {
        expect{child == child}.to(equal(true))
        expect{child == parent}.to(equal(false))
        expect{parent == child}.to(equal(false))
        expect{parent == parent}.to(equal(true))
      }

      it("will hash") {
        expect{child.hashValue == child.hashValue}.to(equal(true))
        expect{parent.hashValue == parent.hashValue}.to(equal(true))
        expect{anyWidgetType.hashValue == anyWidgetType.hashValue}.to(equal(true))
      }

      it("can be used as a key for a dictionary") {
        let dic=[
          child:"child",
          parent:"parent",
          anyWidgetType:"anyWidgetType"
        ]
        expect{dic[child]}.to(equal("child"))
        expect{dic[parent]}.to(equal("parent"))
        expect{dic[anyWidgetType]}.to(equal("anyWidgetType"))
      }

      it("will identify parents") {
        expect{child.isChild(of:parent)}.to(equal(true))
        expect{child.isChild(of:anyWidgetType)}.to(equal(true))
        expect{parent.isChild(of:anyWidgetType)}.to(equal(true))
        expect{parent.isChild(of:child)}.to(equal(false))
      }
    }

    describe("Widget") {
      context("will clear cashe") {
        var widgetType=WidgetType(parent:anyWidgetType)
        var widget=MockWidget(type:widgetType)
        beforeEach{
          widgetType=WidgetType(parent:anyWidgetType)
          widget=MockWidget(type:widgetType)
        }
        context("of style") {
          afterEach{
            expect(widget.cashedStyleCleared).to(equal(true))
          }
          it("when wiget is moved to a container") {
            let parent=MockWidget(type:widgetType)
            widget.container=parent
          }
          it("when style is changed") {
            widget.style=Style()
          }
          it("when container's styleCashe is cleared") {
            let container=MockWidget(type:widgetType)
            widget.container=container
            widget.cashedStyleCleared=false
            container.clearStyleCashe()
          }
        }
        context("of RequestSize") {
          afterEach{
            expect(widget.cashedRequestedSizeCleared).to(equal(true))
          }
          it("when styleCase is cleared") {
            widget.clearStyleCashe()
          }
          it("contents have been added") {
            let contained=MockWidget(type:widgetType)
            contained.container=widget
          }
          it("when contents have been removed") {
            let contained=MockWidget(type:widgetType)
            contained.container=widget
            widget.cashedRequestedSizeCleared=false
            contained.container=nil
          }
          it("when a contained's RequestSize has been cleared") {
            let contained=MockWidget(type:widgetType)
            contained.container=widget
            widget.cashedRequestedSizeCleared=false
            contained.clearRequestedSizeCashe()
          }
        }
        context("of AllocatedSpace") {
          afterEach{
            expect(widget.cashedAllocatedSpaceCleared).to(equal(true))
          }
          it("when requestedSize has been cleared") {
            widget.clearRequestedSizeCashe()
          }
          it("when container's allocatedSpace has been cleared") {
            let container=MockWidget(type:widgetType)
            widget.container=container
            widget.cashedAllocatedSpaceCleared=false
            container.clearAllocatedSpaceCashe()
          }
        }
      }
    }
  }
}

