public struct Style {
  /**
    The properties for the style.
    Treat this a let exsept for init.
  */
  private var properties:Properties?

  /**
    The children Styles. 
    Treat this a let exsept for init.
  */
  private var children:[WidgetType:Style]

  /**
    Adds a child to the Style.
    This should only be used to construct styles.
    - Parameter type: The widgetType style is for.
    - Parameter child style: The style to add.
  */
  private mutating func addChild(type:WidgetType, child style:Style) {
    if style.properties != nil {
      if children[type] != nil {
        children[type]?.properties=style.properties
      } else {
        children[type]=Style(properties:style.properties);
      }
    }
    for (childType, child) in style.children {
      if children[childType] == nil {
        children[childType]=Style();
      }
      children[childType]!.addChild(type:type, child:child)
    }
  }

  /**
   Gets the the property from the style with the closest matching typeHierarchy.
   - Parameter property: The property to get
   - Parameter of: The typeHierarchy of the type to get the paramiter for.
  */
  public func get<T>(property:Property<T>, of:[WidgetType]=[]) -> T? {
    var typeHierarchy=of
    if typeHierarchy.count != 0 {
      var type=typeHierarchy.removeLast()
      while(true) {
        if let value = children[type]?.get(property:property, of:typeHierarchy){
          return value
        }
        guard let nextType=type.parent else {
          break;
        }
        type=nextType
      }
      if let value = get(property:property, of:typeHierarchy) {
        return value
      }
    }
    return properties?.get(property:property)
  }

  /**
    creates a new Style.
    - Parameter properties: The properties for the style.
    - Parameter children: The children Styles. 
  */
  public init(properties:Properties?=nil, children:[WidgetType:Style]=[:]) {
    self.properties=properties
    self.children=[:]
    for (childType, child) in children {
      addChild(type:childType, child:child)
    }
  }
}
