public class Property<T:Any,U:Any>: GenericProperty<U> {
  /**
    The default value for property
  */
  public let defaultValue:T

  /**
    An observer that is called when the value of the property changes.
  */
  public let didSetObserver:((U)->())

  /**
    Creates a new GenericProperty.
    - parameter defaultValue: The default value for property.
  */
  public init(_ defaultValue:T) {
    self.defaultValue=defaultValue
    self.didSetObserver={
      _ in
    }
  }

  /**
    creates a new genericProperty.
    - parameter defaultValue: the default value for property.
  */
  public init(_ defaultValue:T, didSetObserver: @escaping ((U)->())) {
    self.defaultValue=defaultValue
    self.didSetObserver=didSetObserver
  }
}
