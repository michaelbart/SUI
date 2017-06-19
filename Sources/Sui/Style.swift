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

public struct WidgetStyle {
  let hierarchy: WidgetTypeHierarchy
  let properties:Properties<Style>
  init(hierarchy: WidgetTypeHierarchy, properties: [GenericPropertyValue<Style>]) {
    self.hierarchy = hierarchy
    self.properties = Properties(properties)
  }
}

public enum WidgetTypeHierarchy {
  case type(WidgetType)
  indirect case compound(WidgetTypeHierarchy, WidgetTypeHierarchy)

  private func getValidRemains(_ hierarchy: [WidgetType]) -> [[WidgetType]] {
    switch (self) {
    case .type(let type):
      var lastType: WidgetType? = hierarchy.last
      while lastType != nil {
        if lastType == type {
          var hierarchy = hierarchy
          hierarchy.removeLast()
          return [hierarchy]
        }
        lastType = lastType?.parent
      }
      return []
    case .compound(let lhs, let rhs):
      return rhs.getValidRemains(hierarchy).flatMap{
        lhs.getValidRemains($0)
      }
    }
  }

  func matches(_ hierarchy: [Widget]) -> Bool {
    return getValidRemains(hierarchy.map{$0.type}).count != 0
  }
}

public func / (lhs: WidgetType, rhs: WidgetType) -> WidgetTypeHierarchy {
  return .compound(.type(lhs), .type(rhs))
}

public func / (lhs: WidgetType, rhs: WidgetTypeHierarchy) -> WidgetTypeHierarchy {
  return .compound(.type(lhs), rhs)
}

public func / (lhs: WidgetTypeHierarchy, rhs: WidgetType) -> WidgetTypeHierarchy {
  return .compound(lhs, .type(rhs))
}

public func / (lhs: WidgetTypeHierarchy, rhs: WidgetTypeHierarchy) -> WidgetTypeHierarchy {
  return .compound(lhs, rhs)
}

public func <- (hierarchy: WidgetTypeHierarchy, properties: [GenericPropertyValue<Style>]) -> WidgetStyle {
  return WidgetStyle(hierarchy: hierarchy, properties: properties)
}

public func <- (widgetType: WidgetType, properties: [GenericPropertyValue<Style>]) -> WidgetStyle {
  return WidgetStyle(hierarchy: .type(widgetType), properties: properties)
}

