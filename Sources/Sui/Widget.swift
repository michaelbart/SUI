import HashableUsingAddress
import GeneratedValue

public class Widget: HashableUsingAddress {
  var type:WidgetType
  private(set) var contents:[Widget]

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

    let value = Style.get(property: property, of: self)
    styleCashe.set(property:property, to:value)
    return value;
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
    $0.container?.get(property:layoutProperty).allocateSpace($0)
    ?? AllocatedSpace(Point(0,0), $0.requestedSize.min)
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

  private var properties=WidgetProperties()

  /**
     Get widget property for widget.
     - Parameter property: The property to get.
     - Returns: The property.
  */
  func get<T:Any>(property:WidgetProperty<T>) -> T {
    return properties.get(property:property) ?? property.defaultValue
  }

  /**
     Set widget property for widget.
     - Parameter property: The property to set.
     - Parameter to value: The value to set the property to.
  */
  func set<T:Any>(property:WidgetProperty<T>, to value:T) {
    properties.set(property:property, to:value)
  }

  init (type:WidgetType, properties:WidgetProperties?=nil, style:Style?=nil, contents:[Widget]=[]) {
    self.type=type
    self.properties=properties ?? WidgetProperties()
    self.style=style
    self.contents=contents
  }
}
