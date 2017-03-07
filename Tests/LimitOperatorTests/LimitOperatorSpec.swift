import Quick
import Nimble
@testable import LimitOperator
import Foundation

class LimitOperatorSpec: QuickSpec {
  override func spec() {
    describe("limit operators") {
      it("can add") {
        expect{1 as Int ^+ 3}.to(equal(4))
        expect{1 ^+ Int.max}.to(equal(Int.max))
        expect{Int.max ^+ 1}.to(equal(Int.max))
      }
      it("can subtract") {
        expect{3 as Int ^- 1}.to(equal(2))
        expect{1 as Int ^- 3}.to(equal(-2))
        expect{-5 ^- Int.max}.to(equal(Int.min))
        expect{Int.min ^- 1}.to(equal(Int.min))
        /* TODO: expect{0 ^- Int.min}.to(equal(Int.max)) */
      }
      it("can multiply") {
        expect{2 as Int ^* 3}.to(equal(6))
        expect{2 ^* Int.max}.to(equal(Int.max))
        expect{Int.max ^* 2}.to(equal(Int.max))
        /* TODO: add negative values */
      }
    }
  }
}

