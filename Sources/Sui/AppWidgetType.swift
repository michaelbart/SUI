import Foundation
import Properties

let appWidgetType=WidgetType(parent:anyWidgetType)

let impementationProperty = Property<Implementation, Widget>(Implementation())

public func createApp(
  implementation:Implementation,
  properties:[GenericPropertyValue<Widget>]=[],
  style:Style?=nil, contents:[Widget]=[]
) -> Widget {
  var properties=properties
  properties.append(PropertyValue(impementationProperty, implementation)) // TODO: only write if unset
  let widget=Widget(
    type:appWidgetType,
    properties:properties,
    style:style,
    contents:contents
  )

  widget.container=rootWidget
  return widget
}

@discardableResult public func mockCreateApp(
  properties:[GenericPropertyValue<Widget>]=[],
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

