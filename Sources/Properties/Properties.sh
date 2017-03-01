#!/bin/bash

cat >${TYPE}Properties.swift <<END

import AbstractionAsserter
import HashableUsingAddress 

public /*abstract*/ class Generic${TYPE}Property:AbstractionAsserter, HashableUsingAddress {
  /**
    Creates a new Generic${TYPE}Property.
  */
  /*abstract*/ fileprivate init() {
    abstractInit()
  }
} 

public class ${TYPE}Property<T:Any>: Generic${TYPE}Property{
  /**
    The default value for property
  */
  public let defaultValue:T

  /**
    Creates a new Generic${TYPE}Property.
    - parameter defaultValue: The default value for property.
  */
  public init(_ defaultValue:T) {
    self.defaultValue=defaultValue
  }
}

public /*abstract*/ class Generic${TYPE}PropertyValue : AbstractionAsserter {
  /**
    creates a new Generic${TYPE}PropertyValue
  */
  fileprivate /*abstract*/ init() {
    abstractInit()
  }

  /**
    Sets the property of ${TYPE}Property to value.
    - Parameter properties: The ${TYPE}Properties to set.
  */
  /*abstract*/ func set(_ properties:inout [Generic${TYPE}Property:Any]) {
    abstractMethod() 
  }
}

public class ${TYPE}PropertyValue<T:Any>:Generic${TYPE}PropertyValue  {
  /**
    The value of the ${TYPE}PropertyValue
  */
  private let value:T

  /**
    The property of the ${TYPE}PropertyValue
  */
  private let property:Generic${TYPE}Property

  /**
    Creates a new ${TYPE}PropertyValue
    - Parameter property: The property of the ${TYPE}PropertyValue.
    - Parameter value: The value of the ${TYPE}PropertyValue.
  */
  public init(_ property:${TYPE}Property<T>, _ value:T) {
    self.value=value
    self.property=property
  }

  /**
    Sets the property of properties to value.
    - Parameter properties: The ${TYPE}Properties to set.
  */
  override func set(_ properties: inout [Generic${TYPE}Property:Any]) {
    properties[property] = value
  }
}

public struct ${TYPE}Properties {
  /**
    Dictionary of all properties of properties.
  */
  private var properties:[Generic${TYPE}Property:Any]=[:]

  /**
    Gets the property.
    - Prameter property: The property to get the value for.
    - Returns: nil if property is not set, else returns the property.
  */
  public func get<T:Any>(property:${TYPE}Property<T>) -> T? {
    return properties[property] as? T
  }

  /**
    Sets the ${TYPE}Property.
    - Prameter property: The property to set the value for.
    - Prameter to value: The value of the propety to set.
  */
  public mutating func set<T:Any>(property:${TYPE}Property<T>, to value:T) {
    properties[property]=value
  }

  /**
    Creates a new ${TYPE}Propeties
    - values: The inital values to set for properties.
  */
  public init(_ values:Generic${TYPE}PropertyValue...) {
    for value in values {
      value.set(&self.properties)
    }
  }
}
END
