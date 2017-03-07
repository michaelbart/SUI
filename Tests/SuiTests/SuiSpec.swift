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

    describe("Model") {
      it("can create a View") {
        let modelInt=Model(of:0)
        let view=modelInt.createView()
        expect{view.model}.to(beIdenticalTo(modelInt))
      }
      it("can create a Control") {
        let modelInt=Model(of:0)
        let control=modelInt.createControl()
        expect{control.model}.to(beIdenticalTo(modelInt))
      }
      it("will update MockModelWidget if value is changed.") {
        let modelInt=Model(of:0)
        let modelWidget=MockModelWidget(of:modelInt)
        modelInt.value=2
        expect{modelWidget.hasUpdated}.to(equal(true))
      }
      it("will change value (and not crash) after a Control has been deinit.") {
        let modelInt=Model(of:0)
        do {
          _=MockModelWidget(of:modelInt)
        }
        modelInt.value=2
      }
    }

    describe("ModelWidget") {
      it("can get different genericWidgetTypes") {
        expect{ModelWidget<Int>.genericWidgetType}.to(equal(ModelWidget<Int>.genericWidgetType))
        expect{ModelWidget<String>.genericWidgetType}.to(equal(ModelWidget<String>.genericWidgetType))
        expect{ModelWidget<[Int]>.genericWidgetType}.to(equal(ModelWidget<[Int]>.genericWidgetType))

        expect{ModelWidget<Int>.genericWidgetType}.notTo(equal(ModelWidget<String>.genericWidgetType))
        expect{ModelWidget<Int>.genericWidgetType}.notTo(equal(ModelWidget<[Int]>.genericWidgetType))
        expect{ModelWidget<String>.genericWidgetType}.notTo(equal(ModelWidget<[Int]>.genericWidgetType))
      }
    }

    describe("View") {
      it("has the same genericWidgetTypes as ModelWidget") {
        expect{View<Int>.genericWidgetType}.to(equal(ModelWidget<Int>.genericWidgetType))
        expect{View<String>.genericWidgetType}.to(equal(ModelWidget<String>.genericWidgetType))
        expect{View<[Int]>.genericWidgetType}.to(equal(ModelWidget<[Int]>.genericWidgetType))
      }
      it("'s viewWidgetTypes are different then genericWidgetTypes") {
        expect{View<Int>.viewWidgetType}.notTo(equal(View<Int>.genericWidgetType))
        expect{View<String>.viewWidgetType}.notTo(equal(View<String>.genericWidgetType))
        expect{View<[Int]>.viewWidgetType}.notTo(equal(View<[Int]>.genericWidgetType))
      }
      it("can get different viewWidgetTypes") {
        expect{View<Int>.viewWidgetType}.to(equal(View<Int>.viewWidgetType))
        expect{View<String>.viewWidgetType}.to(equal(View<String>.viewWidgetType))
        expect{View<[Int]>.viewWidgetType}.to(equal(View<[Int]>.viewWidgetType))

        expect{View<Int>.viewWidgetType}.notTo(equal(View<String>.viewWidgetType))
        expect{View<Int>.viewWidgetType}.notTo(equal(View<[Int]>.viewWidgetType))
        expect{View<String>.viewWidgetType}.notTo(equal(View<[Int]>.viewWidgetType))
      }
    }

    describe("Control") {
      it("has the same genericWidgetTypes as ModelWidget") {
        expect{Control<Int>.genericWidgetType}.to(equal(ModelWidget<Int>.genericWidgetType))
        expect{Control<String>.genericWidgetType}.to(equal(ModelWidget<String>.genericWidgetType))
        expect{Control<[Int]>.genericWidgetType}.to(equal(ModelWidget<[Int]>.genericWidgetType))
      }
      it("'s ControlWidgetTypes are different then genericWidgetTypes") {
        expect{Control<Int>.controlWidgetType}.notTo(equal(Control<Int>.genericWidgetType))
        expect{Control<String>.controlWidgetType}.notTo(equal(Control<String>.genericWidgetType))
        expect{Control<[Int]>.controlWidgetType}.notTo(equal(Control<[Int]>.genericWidgetType))
      }
      it("can get different ControlWidgetTypes") {
        expect{Control<Int>.controlWidgetType}.to(equal(Control<Int>.controlWidgetType))
        expect{Control<String>.controlWidgetType}.to(equal(Control<String>.controlWidgetType))
        expect{Control<[Int]>.controlWidgetType}.to(equal(Control<[Int]>.controlWidgetType))

        expect{Control<Int>.controlWidgetType}.notTo(equal(Control<String>.controlWidgetType))
        expect{Control<Int>.controlWidgetType}.notTo(equal(Control<[Int]>.controlWidgetType))
        expect{Control<String>.controlWidgetType}.notTo(equal(Control<[Int]>.controlWidgetType))
      }
    }

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
        expect{RequestedSize(Point(7,1),Point(8,2))==RequestedSize(Point(7,1),Point(8,2))}.to(equal(true))
        expect{RequestedSize(Point(8,1),Point(8,2))==RequestedSize(Point(7,1),Point(8,2))}.to(equal(false))
        expect{RequestedSize(Point(7,2),Point(8,2))==RequestedSize(Point(7,1),Point(8,2))}.to(equal(false))
        expect{RequestedSize(Point(7,1),Point(9,2))==RequestedSize(Point(7,1),Point(8,2))}.to(equal(false))
        expect{RequestedSize(Point(7,1),Point(8,3))==RequestedSize(Point(7,1),Point(8,2))}.to(equal(false))
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
          properties:StyleProperties(
            StylePropertyValue(
              layoutProperty,
              FixedLayout(min:Point(1,2), max:Point(3,4))
            )
          )
        )
        expect{widget.requestedSize}.to(equal(RequestedSize(Point(1,2),Point(3,4))))
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
          properties:StyleProperties(StylePropertyValue(layoutProperty, VerticalLayout())),
          children:[
            widgetType:Style(
              properties:StyleProperties(
                StylePropertyValue(
                  layoutProperty,
                  FixedLayout(min:Point(1,2), max:Point(3,4))
                )
              )
            )
          ]
        )
      }
      it("will getRequestedSize") {
        expect{widget.requestedSize}.to(equal(RequestedSize(Point(1,4),Point(3,8))))
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
          properties:StyleProperties(StylePropertyValue(layoutProperty, HorizontalLayout())),
          children:[
            widgetType:Style(
              properties:StyleProperties(
                StylePropertyValue(
                  layoutProperty,
                  FixedLayout(min:Point(1,2), max:Point(3,4))
                )
              )
            )
          ]
        )
      }
      it("will getRequestedSize") {
        expect{widget.requestedSize}.to(equal(RequestedSize(Point(2,2),Point(6,4))))
      }
      it("will allocateSpace for contents") {
        expect(child1.allocatedSpace).to(equal(AllocatedSpace(Point(0,0), Point(1,2))))
        expect(child2.allocatedSpace).to(equal(AllocatedSpace(Point(1,0), Point(1,2))))
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
          var widgetType=WidgetType(parent:anyWidgetType)
          var widget=MockWidget(type:widgetType)
          beforeEach{
            widgetType=WidgetType(parent:anyWidgetType)
            widget=MockWidget(type:widgetType)
          }
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
          var widgetType=WidgetType(parent:anyWidgetType)
          var widget=MockWidget(type:widgetType)
          beforeEach{
            widgetType=WidgetType(parent:anyWidgetType)
            widget=MockWidget(type:widgetType)
          }
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

