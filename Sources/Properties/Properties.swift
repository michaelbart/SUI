import AbstractionAsserter
import HashableUsingAddress

public struct Properties<U:Any> {
  /**
    The contains the values for each property.
  */
  private var propertyValues:[GenericProperty<U>:Any] = [:]

  /**
    Gets the property.
    - Prameter property: The property to get the value for.
    - Returns: nil if property is not set, else returns the property.
  */
  public func get<T:Any>(property:Property<T,U>) -> T? {
    return propertyValues[property] as? T
  }

  /**
    Sets the Property.
    - Prameter property: The property to set the value for.
    - Prameter to value: The value of the propety to set.
  */
  public mutating func set<T:Any>(property:Property<T,U>, to value:T?, obj:U) {
    propertyValues[property] = value
    property.didSetObserver(obj)
  }


  /**
    creates a new Properties
    - prameter propertyValues: The propery values to initalize
      propertyValues to.
  */
  public init(_ propertyValues:GenericPropertyValue<U>...) {
    for propertyValue in propertyValues {
      self.propertyValues[propertyValue.getProperty()] = propertyValue.getValue()
    }
  }

  /**
    creates a new Properties
    - prameter propertyValues: The propery values to initalize
      propertyValues to.
  */
  public init(_ propertyValues:[GenericPropertyValue<U>]) {
    for propertyValue in propertyValues {
      self.propertyValues[propertyValue.getProperty()] = propertyValue.getValue()
    }
  }
}
