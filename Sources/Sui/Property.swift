import AbstractionAsserter
import HashableUsingAddress 

public /*abstract*/ class GenericProperty:AbstractionAsserter, HashableUsingAddress {
  /**
    Creates a new GenericProperty.
  */
  /*abstract*/ fileprivate init() {
    abstractInit()
  }
} 

public class Property<T:Any>: GenericProperty{
  /**
    The default value for property
  */
  public let defaultValue:T

  /**
    Creates a new GenericProperty.
    - parameter defaultValue: The default value for property.
  */
  public init(_ defaultValue:T) {
    self.defaultValue=defaultValue
  }
}

