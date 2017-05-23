import Quick
import Nimble
@testable import AbstractionAsserter
import Foundation

class AbstractionAsserterSpec: QuickSpec {
  override func spec() {
    #if !SWIFT_PACKAGE
      it("will asset when abstract initilizer is called."){
        expect{AbstractParent()}.to(throwAssertion())
      }
      it("will assert when abstract method is called.") {
        expect{Child().AbstractMethod()}.to(throwAssertion())
      }
      it("will not assert when a overridden abstract method is called.") {
        expect{Child().overriddenMethod()}.toNot(throwAssertion())
      }
    #else
       /* TODO remvoe when throwAssetion() is implemented for comand line interface */
      xit("will asset when abstract initilizer is called."){
        _=AbstractParent()
      }
      xit("will assert when abstract method is called.") {
        Child().AbstractMethod()
      }
      it("will not assert when a overridden abstract method is called.") {
        Child().overriddenMethod()
      }
 
    #endif
  }

}
