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
    Sets the property in propertyValue to value.
    - Parameter propertyValues: The PropertyValues to set property to value in.
  */
  /*abstract*/ func set(in propertyValues:inout PropertyValues<U>) {
    abstractMethod() 
  }
}
