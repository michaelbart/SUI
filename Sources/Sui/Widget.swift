import HashableUsingAddress
import GeneratedValue

public class Widget: HashableUsingAddress {
  var type:WidgetType
  private(set) var contents:[Widget]=[]
  weak var container:Widget? {
    didSet {
      if oldValue !== container {
        if let index = oldValue?.contents.index(where: {$0 === self}) {
          oldValue?.contents.remove(at: index)
        }
        oldValue?.clearRequestedSizeCashe()
        container?.contents.append(self)
        clearStyleCashe()
        container?.clearRequestedSizeCashe()
      }
    }
  }
  var style:Style? {
    didSet {
      clearStyleCashe()
    }
  }
  private var styleCashe=StyleProperties()
  func clearStyleCashe() {
    for child in contents {
      child.clearStyleCashe()
    }
    styleCashe=StyleProperties()
    clearRequestedSizeCashe()
  }

  /**
     Get style property for widget.
     - Parameter property: The property to get.
     - Returns: The property.
  */
  func get<T:Any>(property:StyleProperty<T>) -> T {
    if let value = styleCashe.get(property:property) {
      return value;
    }

    if let value = style?.get(property:property) {
      styleCashe.set(property:property, to:value)
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
        styleCashe.set(property:property, to:value)
        return value
      }
    }

    let value = property.defaultValue
    styleCashe.set(property:property, to:value)
    return value
  }

  private var requestedSizeCashe=GeneratedValue {
    (widget:Widget) in
    widget.get(property:layoutProperty).getRequestedSize(widget)
  }

  public var requestedSize: RequestedSize {
    get {
      return requestedSizeCashe.get(self)
    }
  }

  func clearRequestedSizeCashe() {
    requestedSizeCashe.clearCashe()
    container?.clearRequestedSizeCashe()
    clearAllocatedSpaceCashe()
  }

  private var allocatedSpaceCashe=GeneratedValue<Widget,AllocatedSpace> {
    (widget:Widget) in
    if let container=widget.container {
      return container.get(property:layoutProperty).allocateSpace(widget)
    }
    return AllocatedSpace(Point(0,0), widget.requestedSize.min)
  }

  public var allocatedSpace:AllocatedSpace {
    get {
      return allocatedSpaceCashe.get(self)
    }
  }

  func clearAllocatedSpaceCashe() {
    allocatedSpaceCashe.clearCashe()
    for child in contents {
      child.clearAllocatedSpaceCashe()
    }
  }

  private var widgetProperties=WidgetProperties()

  /**
     Get style property for widget.
     - Parameter property: The property to get.
     - Returns: The property.
  */
  func get<T:Any>(property:WidgetProperty<T>) -> T {
    return widgetProperties.get(property:property) ?? property.defaultValue
  }

  /**
     Set style property for widget.
     - Parameter property: The property to set.
     - Parameter to value: The value to set the property to.
  */
  func set<T:Any>(property:WidgetProperty<T>, to value:T) {
    widgetProperties.set(property:property, to:value)
  }

  init (type:WidgetType) {
    self.type=type
  }
}
