import HashableUsingAddress
import GeneratedValue

public class Widget: HashableUsingAddress {
  let type:WidgetType
  private(set) var contents:[Widget]

  public weak var container:Widget? {
    didSet {
      if oldValue !== container {
        if let oldContainer=oldValue {
          if let index = oldContainer.contents.index(where: {$0 === self}) {
            oldContainer.contents.remove(at: index)
          }
          oldContainer.get(property:removedContained)(oldContainer, self)
          get(property:removedFromContainer)(oldContainer, self)
          if oldContainer.contents.count == 0 {
            oldContainer.get(property:contentsEmptied)(oldContainer)
          }
          oldContainer.clearRequestedSizeCashe()
        }

        clearStyleCashe()

        if let newContainer=container {
          newContainer.contents.append(self)
          newContainer.clearRequestedSizeCashe()

          newContainer.get(property:addedContained)(newContainer, self)
          get(property:addedToContainer)(newContainer, self)
        }
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
  public func get<T:Any>(property:StyleProperty<T>) -> T {
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
  public func get<T:Any>(property:WidgetProperty<T>) -> T {
    return properties.get(property:property) ?? property.defaultValue
  }

  /**
     Set widget property for widget.
     - Parameter property: The property to set.
     - Parameter to value: The value to set the property to.
  */
  public func set<T:Any>(property:WidgetProperty<T>, to value:T) {
    properties.set(property:property, to:value)
  }

  public init (type:WidgetType, properties:WidgetProperties?=nil, style:Style?=nil, contents:[Widget]=[]) {
    self.type=type
    self.properties=properties ?? WidgetProperties()
    self.style=style
    self.contents=[]
    for contained in contents {
      contained.container=self
    }
  }
}
