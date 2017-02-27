import Quick
import Nimble
@testable import GeneratedValue
import Foundation

class GeneratedValueSpec: QuickSpec {
  override func spec() {
    describe("GeneratedValue") {
      var generatedValue:GeneratedValue=GeneratedValue{0}
      var valueToSetTo=2
      beforeEach {
        valueToSetTo=2
        generatedValue=GeneratedValue{valueToSetTo}
      }
      it("can get value") {
        expect(generatedValue.get()).to(equal(valueToSetTo))
      }
      it("will wait until get is called before setting cashe") {
        valueToSetTo=4
        expect(generatedValue.get()).to(equal(4))
      }
      it("will not update automaticly") {
        expect(generatedValue.get()).to(equal(valueToSetTo))
        valueToSetTo=4
        expect(generatedValue.get()).to(equal(2))
      }
      it("will update after clearCashe is called") {
        expect(generatedValue.get()).to(equal(valueToSetTo))
        valueToSetTo=4
        generatedValue.clearCashe()
        expect(generatedValue.get()).to(equal(4))
      }
    }
  }
}

