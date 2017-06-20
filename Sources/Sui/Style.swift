import Properties

public struct Style {
  private let widgetStyles:[WidgetStyle]

  public static func get<T:Any>(property:Property<T, Style>, of widget:Widget) -> T {
    for container in widget.hierarchy {
      if let style = container.style {
        for widgetStyle in style.widgetStyles.reversed() {
          if widgetStyle.hierarchy.matches(widget.hierarchy) {
            if let value = widgetStyle.properties.get(property:property) {
              return value
            }
          }
        }
      }
    }
    return property.defaultValue
  }

  /**
    creates a new Style.
  */
  public init(_ widgetStyles: WidgetStyle ...) {
    self.widgetStyles = widgetStyles
  }
}

