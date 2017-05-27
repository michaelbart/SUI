import AbstractionAsserter
import HashableUsingAddress

public class PropertyValue<T:Any,U:Any>:GenericPropertyValue<U> {
  /**
    The property of the PropertyValue
  */
  let property:Property<T,U>

  /**
    The value of the PropertyValue
  */
  var value:T

  /**
    Sets the property in propertyValue to value.
    - Parameter propertyValues: The PropertyValues to set property to value in.
  */
  override func set(in propertyValues:inout PropertyValues<U>) {
    propertyValues.set(property:property, to: value)
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

