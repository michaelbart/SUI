import Foundation
import AbstractionAsserter

open class App : WidgetType, AbstractionAsserter {
  static fileprivate var app:Widget?
  static public func getApp() -> Widget {
    return app!
  }
  public init(){
    super.init(parent:anyWidgetType)
    abstractInit()
  }
}

public func initSui(app:WidgetType) {
    App.app=Widget(type:app)
}

