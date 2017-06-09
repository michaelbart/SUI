import SdlSui
import Sui
import Foundation
import Properties


let colorWidgetType = WidgetType(parent:anyWidgetType)

let redWidgetType=WidgetType(parent:colorWidgetType)
let greenWidgetType=WidgetType(parent:colorWidgetType)
let blueWidgetType=WidgetType(parent:colorWidgetType)

let hBoxWidgetType=WidgetType(parent:anyWidgetType)

let colorProperty = Property<Color, Style>(Color(red:255, green:255, blue:255))

let style = Style (
  children: [
    hBoxWidgetType: Style(
      properties: [
        PropertyValue(
          layoutProperty,
          HorizontalLayout()
        )
      ]
    ),
    colorWidgetType:Style(
      properties: [
        PropertyValue(
          layoutProperty,
          FixedLayout(RequestedSize(Point(1,1)))
        ),
        PropertyValue(drawBackground) {
          (widget, renderer) in
          var renderer = renderer
          renderer.color = widget.get(property:colorProperty)
          renderer.fill()
        },
      ]
    ),
    redWidgetType:Style(
      properties: [
        PropertyValue(
          colorProperty,
          Color(red: 255, green: 0, blue: 0)
        ),
      ]
    ),
    greenWidgetType:Style(
      properties: [
        PropertyValue(
          colorProperty,
          Color(red: 0, green: 255, blue: 0)
        ),
      ]
    ),
    blueWidgetType:Style(
      properties: [
        PropertyValue(
          colorProperty,
          Color(red: 0, green: 0, blue: 255)
        ),
      ]
    ),
  ]
)

let app=sdlCreateApp(
  properties: [],
  contents:[
    Widget(
      type:anyWidgetType,
      properties: [
        PropertyValue(spriteSize, Point(200,300)),
        PropertyValue(spritePosition, Point(200,300)),
      ],
      style:style,
      contents: [
        Widget(
          type:redWidgetType
        ),
        Widget(
          type:hBoxWidgetType,
          contents: [
            Widget(
              type:blueWidgetType
            ),
            Widget(
              type:greenWidgetType
            ),
          ]
        ),
        Widget(
          type:blueWidgetType
        )
      ]
    )
  ]
)

RunLoop.main.run()

