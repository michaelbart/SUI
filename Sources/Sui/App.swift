import Foundation
import AbstractionAsserter

open class App : AbstractionAsserter {
  static private var app:App?
  static public func getApp() -> App {
    return app!
  }
  public init(){
    abstractInit()
    App.app=self
  }
}
