import AbstractionAsserter
import HashableUsingAddress

public struct PropertyValues<U:Any> {
  /**
    Dictionary of all properties of properties.
  */
  private var properties:[GenericProperty<U>:Any] = [:]

  /**
    Gets the property.
    - Prameter property: The property to get the value for.
    - Returns: nil if property is not set, else returns the property.
  */
  public func get<T:Any>(property:Property<T,U>) -> T? {
    return properties[property] as? T
  }

  /**
    Sets the Property.
    - Prameter property: The property to set the value for.
    - Prameter to value: The value of the propety to set.
  */
  public mutating func set<T:Any>(property:Property<T,U>, to value:T?) {
    properties[property]=value
  }

  /**
    Sets the PropertyValue.property to propertyValue.value.
    - Prameter propertyValue: The propertyValue to set.
  */
  public mutating func set(propertyValue:GenericPropertyValue<U>) {
    propertyValue.set(in:&self)
  }

  public init(propertyValues:[GenericPropertyValue<U>]) {
    for propertyValue in propertyValues {
      set(propertyValue:propertyValue)
    }
  }

  public init(propertyValues:GenericPropertyValue<U>...) {
    for propertyValue in propertyValues {
      set(propertyValue:propertyValue)
    }
  }
}

