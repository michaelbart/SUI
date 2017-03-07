import Quick
import Nimble
@testable import Sui
import Foundation
import LimitOperator

class SuiModelViewControlSpec: QuickSpec {
  override func spec() {

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
  }
}

