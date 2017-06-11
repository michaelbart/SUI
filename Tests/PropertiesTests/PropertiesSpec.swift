import Quick
import Nimble
@testable import Properties
import Foundation

class PropertiesSpec: QuickSpec {
  override func spec() {
    describe("Properties") {
      let test = Property<Int,()>(23)
      let testInt1 = Property<Int,()>(12)
      let testInt2 = Property<Int,()>(15)
      let testString = Property<String,()>("This is a test")
      let testTouple = Property<(Int,Int,Int,Int,Int,Int),()>((12,13,14,15,16,17) as (Int,Int,Int,Int,Int,Int))

      var properties=Properties<()>()
      beforeEach {
        properties=Properties<()>()
      }
      it("will return nil when retrieving an unset property"){
        expect{properties.get(property:test)}.to(beNil())
      }
      it("will store and retrieve a property."){
        properties.set(property:test,to:12, obj: ())
        expect{properties.get(property:test)}.to(equal(12))
      }
      it("will store and retrieve different types of properties."){
        properties.set(property:testInt1,to:12, obj: ())
        properties.set(property:testString,to:"This is a test", obj: ())
        properties.set(property:testTouple,to:(12,13,14,15,16,17), obj: ())
        properties.set(property:testInt2,to:15, obj: ())
        expect{properties.get(property:testInt1)}.to(equal(12))
        expect{properties.get(property:testString)}.to(equal("This is a test"))
        expect{properties.get(property:testTouple)?.0}.to(equal(12))
        expect{properties.get(property:testTouple)?.1}.to(equal(13))
        expect{properties.get(property:testTouple)?.2}.to(equal(14))
        expect{properties.get(property:testTouple)?.3}.to(equal(15))
        expect{properties.get(property:testTouple)?.4}.to(equal(16))
        expect{properties.get(property:testTouple)?.5}.to(equal(17))
        expect{properties.get(property:testInt2)}.to(equal(15))
      }
      it("can be initallized with values") {
        properties=Properties(
          PropertyValue(testInt1,12),
          PropertyValue(testString,"This is a test"),
          PropertyValue(testTouple,(12,13,14,15,16,17)),
          PropertyValue(testInt2,15)
        )
        expect{properties.get(property:testInt1)}.to(equal(12))
        expect{properties.get(property:testString)}.to(equal("This is a test"))
        expect{properties.get(property:testTouple)?.0}.to(equal(12))
        expect{properties.get(property:testTouple)?.1}.to(equal(13))
        expect{properties.get(property:testTouple)?.2}.to(equal(14))
        expect{properties.get(property:testTouple)?.3}.to(equal(15))
        expect{properties.get(property:testTouple)?.4}.to(equal(16))
        expect{properties.get(property:testTouple)?.5}.to(equal(17))
        expect{properties.get(property:testInt2)}.to(equal(15))
      }
      it("PropertyValue can be created by using <- operator") {
        properties=Properties(
          testInt1 <- 12
        )
        expect{properties.get(property:testInt1)}.to(equal(12))
      }
    }
  }
}

