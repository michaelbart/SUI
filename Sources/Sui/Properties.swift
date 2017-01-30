public struct Properties {
  /**
    Dictionary of all properties of properties.
  */
  private var properties:[GenericProperty:Any]=[:]

  /**
    Gets the property.
    - Prameter property: The property to get the value for.
    - Returns: nil if property is not set, else returns the property.
  */
  public func get<T:Any>(property:Property<T>) -> T? {
    return properties[property] as? T
  }

  /**
    Sets the property.
    - Prameter property: The property to set the value for.
    - Prameter to value: The value of the propety to set.
  */
  public mutating func set<T:Any>(property:Property<T>, to value:T) {
    properties[property]=value
  }

  /**
    Creates a new Propeties
    - values: The inital values to set for properties.
  */
  public init(_ values:GenericPropertyValue...) {
    for value in values {
      value.set(&self.properties)
    }
  }
}
