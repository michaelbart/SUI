import Foundation

let appWidgetType=WidgetType(parent:anyWidgetType)

let impementationProperty:WidgetProperty<Implementation> = WidgetProperty(Implementation())

public func createApp(
  implementation:Implementation,
  properties:WidgetProperties?=nil,
  style:Style?=nil, contents:[Widget]=[]
) -> Widget {
  let widget=Widget(type:appWidgetType, properties:properties, style:style, contents:contents)
  widget.set(property:impementationProperty, to:implementation)
  widget.container=rootWidget
  if widget.contents.count != 0 {
    eventLoopRun()
  }
  return widget
}

@discardableResult public func mockCreateApp(
  properties:WidgetProperties?=nil,
  style:Style?=nil,
  contents:[Widget]=[]
) -> Widget {
  return createApp(
    implementation:Implementation(),
    properties:properties,
    style:style,
    contents:contents
  )
}

