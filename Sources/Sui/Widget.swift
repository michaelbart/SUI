public class Widget {
  var type:WidgetType
  private(set) var children:[Widget]=[]
  weak var container:Widget? {
    didSet {
      if oldValue !== container {
        if let index = oldValue?.children.index(where: {$0 === self}) {
          oldValue?.children.remove(at: index)
        }
        container?.children.append(self)
        clearCashedProperties()
      }
    }
  }
  var style:Style? {
    didSet {
     clearCashedProperties()
    }
  }
  private var cashedProperties=Properties()
  func clearCashedProperties() {
    for child in children {
      child.clearCashedProperties()
    }
    cashedProperties=Properties()
  }

  /**
     Get style property for widget.
     - Parameter property: The property to get.
    - Returns: The property.
  */
  func get<T:Any>(property:Property<T>) -> T? {
    if let value = cashedProperties.get(property:property) {
      return value;
    }

    if let value = style?.get(property:property) {
      cashedProperties.set(property:property, to:value)
      return value;
    }

    var hierarchy:[Widget]=[]
    var container:Widget=self
    while(true) {
      hierarchy.append(container)
      guard let nextContainer=container.container else {
        break;
      }
      container = nextContainer
    }
  
    let typeHierarchy=Array(hierarchy.map{$0.type}.reversed())

    /* for each container */
    for container in hierarchy {
      if let value = container.style?.get(property:property, of:typeHierarchy) {
        cashedProperties.set(property:property, to:value)
        return value
      }
    }

    let value = property.defaultValue
    cashedProperties.set(property:property, to:value)
    return value
  }
  init (type:WidgetType) {
    self.type=type
  }
}
