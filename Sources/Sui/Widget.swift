import HashableUsingAddress
import GeneratedValue

public class Widget: HashableUsingAddress {
  let type:WidgetType

  // MARK: property contents
  private static func onWillSetContainerEvent1(widget:Widget, oldContainer:Widget) {
    if let index = oldContainer.contents.index(where: {$0 === widget}) {
      oldContainer.contents.remove(at: index)
    }
  }

  private static func onDidSetContainerEvent1(widget:Widget, newContainer:Widget) {
      newContainer.contents.append(widget)
  }

  private(set) var contents:[Widget] {
    didSet {
      if oldValue != contents {
        Widget.didSetContentsEvent(widget:self)
      }
    }
  }

  private static func didSetContentsEvent(widget:Widget) {
    onDidSetContentsEvent1(widget:widget)
  }

  // MARK: property container
  public weak var container:Widget? {
    willSet {
      if newValue !== container {
        if let oldContainer=container {
          Widget.willSetContainerEvent(widget:self, oldContainer:oldContainer)
        }
      }
    }
    didSet {
      if oldValue !== container {
        Widget.containerChangedEvent(widget:self)
        if let newContainer=container {
          Widget.didSetContainerEvent(widget:self, newContainer:newContainer)
        }
      }
    }
  }

  private static func willSetContainerEvent(widget:Widget, oldContainer:Widget) {
      onWillSetContainerEvent1(widget:widget, oldContainer:oldContainer)
      onWillSetContainerEvent2(widget:widget, oldContainer:oldContainer)
      onWillSetContainerEvent3(widget:widget, oldContainer:oldContainer)
      onWillSetContainerEvent4(widget:widget, oldContainer:oldContainer)
  }

  private static func containerChangedEvent(widget:Widget) {
    onContainerChangedEvent1(widget:widget)
  }

  private static func didSetContainerEvent(widget:Widget, newContainer:Widget) {
      onDidSetContainerEvent1(widget:widget, newContainer:newContainer)
      onDidSetContainerEvent2(widget:widget, newContainer:newContainer)
      onDidSetContainerEvent3(widget:widget, newContainer:newContainer)
      onDidSetContainerEvent4(widget:widget, newContainer:newContainer)
  }

  // MARK: property requestedSize
  private static func onStyleCasheClearedEvent2(widget:Widget) {
    widget.clearRequestedSizeCashe()
  }

  private static func onWillSetContainerEvent4(widget:Widget, oldContainer:Widget) {
      oldContainer.clearRequestedSizeCashe()
  }

  private static func onDidSetContainerEvent2(widget:Widget, newContainer:Widget) {
      newContainer.clearRequestedSizeCashe()
  }

  private static func onRequestedSizeCasheClearedEvent1(widget:Widget) {
    widget.container?.clearRequestedSizeCashe()
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
    Widget.requestedSizeCasheClearedEvent(widget:self)
  }

  static func requestedSizeCasheClearedEvent(widget:Widget) {
    onRequestedSizeCasheClearedEvent1(widget:widget)
    onRequestedSizeCasheClearedEvent2(widget:widget)
  }

  // MARK: property allocatedSpace
  private static func onAllocatedSpaceClearedEvent1(widget:Widget) {
    for child in widget.contents {
      child.clearAllocatedSpaceCashe()
    }
  }

  private static func onRequestedSizeCasheClearedEvent2(widget:Widget) {
      widget.clearAllocatedSpaceCashe()
  }

  private var allocatedSpaceCashe=GeneratedValue<Widget,AllocatedSpace> {
    $0.container?.get(property:layoutProperty).allocateSpace($0)
    ?? AllocatedSpace(Point(0,0), $0.requestedSize.size)
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

  static func allocatedSpaceCasheClearedEvent(widget:Widget) {
    onAllocatedSpaceClearedEvent1(widget:widget)
  }

  // MARK: styleCashe
  private static func onContainerChangedEvent1(widget:Widget) {
    widget.clearStyleCashe()
  }

  private static func onStyleCasheClearedEvent1(widget:Widget) {
    for child in widget.contents {
      child.clearStyleCashe()
    }
  }

  private static func didSetStyle1Event(widget:Widget) {
      widget.clearStyleCashe()
  }

  private var styleCashe=StyleProperties()

  func clearStyleCashe() {
    styleCashe=StyleProperties()
    Widget.styleCasheClearedEvent(widget:self)
  }

  private static func styleCasheClearedEvent(widget:Widget) {
    onStyleCasheClearedEvent1(widget:widget)
    onStyleCasheClearedEvent2(widget:widget)
  }

  // MARK: property style
  var style:Style? {
    didSet {
      Widget.didSetStyleEvent(widget:self)
    }
  }

  private static func didSetStyleEvent(widget:Widget) {
    didSetStyle1Event(widget:widget)
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

  // MARK: WidgetProperties
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

  // MARK: init
  public init (type:WidgetType, properties:WidgetProperties?=nil, style:Style?=nil, contents:[Widget]=[]) {
    self.type=type
    self.properties=properties ?? WidgetProperties()
    self.style=style
    self.contents=[]
    defer{
      for contained in contents {
        contained.container=self
      }
    }
  }
}

