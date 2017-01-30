import AbstractionAsserter 

public /*abstract*/ class GenericPropertyValue : AbstractionAsserter {
  /**
    creates a new GenericPropertyValue
  */
  fileprivate /*abstract*/ init() {
    abstractInit()
  }

  /**
    Sets the property of properties to value.
    - Parameter properties: The Properties to set.
  */
  /*abstract*/ func set(_ properties:inout [GenericProperty:Any]) {
    abstractMethod() 
  }
}

public class PropertyValue<T:Any>:GenericPropertyValue  {
  /**
    The value of the PropertyValue
  */
  private let value:T

  /**
    The property of the PropertyValue
  */
  private let property:GenericProperty

  /**
    Creates a new propertyValue
    - Parameter property: The property of the PropertyValue.
    - Parameter value: The value of the PropertyValue.
  */
  public init(_ property:Property<T>, _ value:T) {
    self.value=value
    self.property=property
  }

  /**
    Sets the property of properties to value.
    - Parameter properties: The Properties to set.
  */
  override func set(_ properties: inout [GenericProperty:Any]) {
    properties[property] = value
  }
}
