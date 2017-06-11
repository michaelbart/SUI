import AbstractionAsserter
import HashableUsingAddress


infix operator <-

public func <- <T,U>(property:Property<T,U>, value:T) -> GenericPropertyValue<U> {
  return PropertyValue(property, value)
}

public class PropertyValue<T:Any,U:Any>:GenericPropertyValue<U> {
  /**
    The property of the PropertyValue
  */
  let property:Property<T,U>

  /**
    The value of the PropertyValue
  */
  var value:T

  override func getProperty() -> GenericProperty<U> {
    return property
  }

  override func getValue() -> Any {
    return value
  }

  /**
    Creates a new PropertyValue
    - Parameter property: The property of the PropertyValue.
    - Parameter value: The value of the PropertyValue.
  */
  public init(_ property:Property<T,U>, _ value:T) {
    self.property=property
    self.value=value
  }
}

