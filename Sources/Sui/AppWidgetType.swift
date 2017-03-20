import Foundation

let appWidgetType=WidgetType(parent:anyWidgetType)

let impementationProperty:WidgetProperty<Implementation> = WidgetProperty(Implementation())

public func createApp(
  implementation:Implementation,
  properties:WidgetProperties?=nil,
  style:Style?=nil, contents:[Widget]=[]
) -> Widget {
  let widget=Widget(type:appWidgetType, properties:properties, style:style)
  widget.set(property:impementationProperty, to:implementation)
  widget.container=rootWidget
  return widget
}

public func mockCreateApp(
  properties:WidgetProperties?=nil,
  style:Style?=nil,
  contents:[Widget]=[]
) -> Widget {
  return createApp(
    implementation:Implementation(),
    properties:properties,
    style:style
  )
}

