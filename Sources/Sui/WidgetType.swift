import HashableUsingAddress

open class WidgetType: HashableUsingAddress {
  /**
    The parent Widget Type.
    This is only Nil for the root WidgetType(anyWidgetType)
  */
  let parent:WidgetType?

  /**
    checks if WidgetType is a child of type.
    - Prameter of type: The parent WidgetType.
    - Returns: true if WidgetType is a child of type
  */
  public func isChild(of type:WidgetType) -> Bool {
    if self === type {
       return true
    }
    if let parent = parent {
      return parent.isChild(of:type)
    }
    return false
  }

  /**
    Create a new root Widget Type.
    This should only be used to create anyWidgetType.
  */
  fileprivate init () {
    parent=nil
  }

  /**
    Create a new Widget Type.
    - Parameter parent: The parent of the new Widget type
  */
  public init (parent:WidgetType) {
    self.parent=parent
  }
}

/**
  anyWidgetType is the Root WidgetType that all other Widget types are chlidren of.
*/
public let anyWidgetType=WidgetType()

