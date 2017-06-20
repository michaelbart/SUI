import Properties

public struct WidgetStyle {
  let hierarchy: WidgetTypeHierarchy
  let properties:Properties<Style>
  init(hierarchy: WidgetTypeHierarchy, properties: [GenericPropertyValue<Style>]) {
    self.hierarchy = hierarchy
    self.properties = Properties(properties)
  }
}

