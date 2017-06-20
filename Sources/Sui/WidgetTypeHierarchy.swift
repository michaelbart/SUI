import Properties

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

