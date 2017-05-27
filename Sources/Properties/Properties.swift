import AbstractionAsserter
import HashableUsingAddress

public struct Properties<U:Any> {
  /**
    The PropertyValues contained in the properties.
  */
  private var propertyValues:PropertyValues<U>

  /**
    Gets the property.
    - Prameter property: The property to get the value for.
    - Returns: nil if property is not set, else returns the property.
  */
  public func get<T:Any>(property:Property<T,U>) -> T? {
    return propertyValues.get(property:property)
  }

  /**
    Sets the Property.
    - Prameter property: The property to set the value for.
    - Prameter to value: The value of the propety to set.
  */
  public mutating func set<T:Any>(property:Property<T,U>, to value:T?, obj:U) {
    propertyValues.set(property:property,to:value)
    property.didSetObserver(obj)
  }

  public init(_ propertyValues:GenericPropertyValue<U>...) {
    self.propertyValues=PropertyValues(propertyValues:propertyValues)
  }

  public init(_ propertyValues:PropertyValues<U>) {
    self.propertyValues=propertyValues
  }
}
