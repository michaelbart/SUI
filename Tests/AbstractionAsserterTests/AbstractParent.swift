import AbstractionAsserter

public class AbstractParent:AbstractionAsserter {
  init() {
    abstractInit(className:"AbstractParent")
  }
  public func AbstractMethod() {
    abstractMethod()
  }
  public func overriddenMethod() {
    abstractMethod()
  }
}
