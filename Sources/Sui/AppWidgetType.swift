import Foundation

let appWidgetType=WidgetType(parent:anyWidgetType)

let impementationProperty:WidgetProperty<Implementation> = WidgetProperty(Implementation())

public func createApp(
  implementation:Implementation,
  properties:WidgetProperties?=nil,
  style:Style?=nil, contents:[Widget]=[]
) -> Widget {
  var widgetProperties=properties ?? WidgetProperties()
  widgetProperties.set(property:impementationProperty, to:implementation)
  let widget=Widget(
    type:appWidgetType,
    properties:widgetProperties,
    style:style,
    contents:contents
  )

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

