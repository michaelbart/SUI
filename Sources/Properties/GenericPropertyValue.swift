import AbstractionAsserter
import HashableUsingAddress

public class GenericPropertyValue<U:Any>:AbstractionAsserter, HashableUsingAddress {
  /**
    creates a new Generic$PropertyValue
  */
  /*abstract*/ init() {
    abstractInit()
  }

  /**
    Returns the property.
    - Returns: The propery.
  */
  func /*abstract*/ getProperty() -> GenericProperty<U> {
    abstractMethod()
    return GenericProperty<U>()
  }

  /**
    Returns the value.
    - Returns: The value.
  */
  func /*abstract*/ getValue() -> Any {
    abstractMethod()
    return 1
  }
}
