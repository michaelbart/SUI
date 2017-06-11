import Quick
import Nimble
@testable import Sui
import Foundation
import LimitOperator
import Properties

class SuiStyleSpec: QuickSpec {
  override func spec() {

    describe("Widget") {
      let test=Property<Int, Style>(23)

      let widgetType=WidgetType(parent:anyWidgetType)
      let parentType=WidgetType(parent:anyWidgetType)
      let grandParentType=WidgetType(parent:anyWidgetType)

      var widget=Widget(type:anyWidgetType)
      var parent=Widget(type:anyWidgetType)
      var grandParent=Widget(type:anyWidgetType)

      beforeEach {
        grandParent=Widget(type:grandParentType)
        parent=Widget(type:parentType)
        parent.container=grandParent
        widget=Widget(type:widgetType)
        widget.container=parent
      }

      context("with style") {
        beforeEach {
          widget.style=Style(properties:Properties(PropertyValue(test, 12)))
        }
        it("can get property"){
          expect{widget.get(property:test)}.to(equal(12))
        }
        it("can change styles"){
          expect{widget.get(property:test)}.to(equal(12))
          widget.style=Style(properties:Properties(PropertyValue(test, 13)))
          expect{widget.get(property:test)}.to(equal(13))
        }
      }
      it("can change styles when parent changes style"){
        expect{widget.get(property:test)}.to(equal(23))
        parent.style=Style(properties:Properties(PropertyValue(test, 13)))
        expect{widget.get(property:test)}.to(equal(13))
      }
      it("can change styles when moved to a new parent"){
        parent.style=Style(properties:Properties(PropertyValue(test, 13)))
        grandParent.style=Style(properties:Properties(PropertyValue(test, 14)))
        expect{widget.get(property:test)}.to(equal(13))
        widget.container=grandParent
        expect{widget.get(property:test)}.to(equal(14))
      }
    }

    describe("style") {

      let property = Property<String, Style>("default value")
      let otherProperty = Property<String, Style>("other property")

      let widgetType=WidgetType(parent:anyWidgetType)
      let parentType=WidgetType(parent:anyWidgetType)
      let grandParentType=WidgetType(parent:anyWidgetType)
      let otherWidgetType=WidgetType(parent:anyWidgetType)

      var widget=Widget(type:anyWidgetType)
      var parent=Widget(type:anyWidgetType)
      var grandParent=Widget(type:anyWidgetType)

      beforeEach {
        grandParent=Widget(type:grandParentType)
        parent=Widget(type:parentType)
        parent.container=grandParent
        widget=Widget(type:widgetType)
        widget.container=parent
      }

      func toString(_ styleDescription:[WidgetType]) -> String {
        let widgetTypeNames=styleDescription.map{
          type -> String in
          switch(type) {
          case widgetType:
            return "widget"
          case parentType:
            return "parent"
          case grandParentType:
            return "grandParent"
          case anyWidgetType:
            return "any"
          case otherWidgetType:
            return "other"
          default:
            fatalError("styleWidget() must be \"self\", \"parent\", or \"grandParent\"")
          }
        }
        if styleDescription.count == 0 {
          return "self"
        }
        return  widgetTypeNames.joined(separator: "->")
      }

      func toStyle<T:Any>(
        _ styleDescription:[WidgetType],
        _ propertyValue:PropertyValue<T,Style>
      ) -> Style {
        var style=Style(
          properties:Properties(propertyValue)
        )
        for type in styleDescription.reversed() {
          style=Style(children:[type:style])
        }
        return style
      }

      context("gets properties") {
        for styleWidget in [
          (widget:{widget}, name:"self"),
          (widget:{parent}, name:"parent"),
          (widget:{grandParent}, name:"grandParent"),
        ] { 
          context("of \(styleWidget.name)") {
            let value="set"
            let styleDescriptions=[
             [],
             [grandParentType, parentType, widgetType],
             [anyWidgetType, parentType, widgetType],
             [parentType, widgetType],
             [grandParentType, anyWidgetType, widgetType],
             [anyWidgetType, anyWidgetType, widgetType],
             [anyWidgetType, widgetType],
             [grandParentType, widgetType],
             [widgetType],
             [grandParentType, parentType, anyWidgetType],
             [anyWidgetType, parentType, anyWidgetType],
             [parentType, anyWidgetType],
             [grandParentType, anyWidgetType, anyWidgetType],
             [anyWidgetType, anyWidgetType, anyWidgetType],
             [anyWidgetType, anyWidgetType],
             [grandParentType, anyWidgetType],
             [anyWidgetType],
             [grandParentType, parentType],
             [anyWidgetType, parentType],
             [parentType],
             [grandParentType],
            ]

            for styleDescription in styleDescriptions{
              it("matching \(toString(styleDescription))"){
                styleWidget.widget().style=toStyle(
                  styleDescription,
                  PropertyValue(property,value)
                )
                expect{widget.get(property:property)}.to(equal(value))
              }
            }
          }
        }
      }

      it("does not get properties when no style is set"){
        expect{widget.get(property:property)}.to(equal(property.defaultValue))
      }
      it("does not get properties when type does not match"){
        let style=Style(
          children: [
            otherWidgetType:Style(
              properties:Properties(PropertyValue(property,"self"))
            ),
            widgetType:Style(
              children: [
                otherWidgetType:Style(
                  properties:Properties(PropertyValue(property,"widget"))
                )
              ]
            ),
            anyWidgetType:Style(
              children: [
                otherWidgetType:Style(
                  properties:Properties(PropertyValue(property,"any"))
                ),
                anyWidgetType:Style(
                  children: [
                    otherWidgetType:Style(
                      properties:Properties(PropertyValue(property,"any->any"))
                    ),
                  ]
                ),
                widgetType:Style(
                  children: [
                    otherWidgetType:Style(
                      properties:Properties(PropertyValue(property,"any->widget"))
                    ),
                  ]
                ),
              ]
            ),
            parentType:Style(
              children: [
                otherWidgetType:Style(
                  properties:Properties(PropertyValue(property,"parent"))
                ),
                anyWidgetType:Style(
                  children: [
                    otherWidgetType:Style(
                      properties:Properties(PropertyValue(property,"parent->any"))
                    ),
                  ]
                ),
                widgetType:Style(
                  children: [
                    otherWidgetType:Style(
                      properties:Properties(PropertyValue(property,"parent->widget"))
                    ),
                  ]
                ),
              ]
            ),
          ]
        )
        widget.style=style
        parent.style=style
        grandParent.style=style
        expect{widget.get(property:property)}.to(equal(property.defaultValue))
      }
      it("does not get properties when property does not match"){
        let style=Style(
          properties:Properties(
            PropertyValue(otherProperty,"self")
          ),
          children:[
            widgetType:Style(
              properties:Properties(
                PropertyValue(otherProperty,"widget")
              )
            ),
            parentType:Style(
              properties:Properties(
                PropertyValue(otherProperty,"parent")
              ),
              children:[
                widgetType:Style(
                  properties:Properties(
                    PropertyValue(otherProperty,"parent->widget")
                  )
                ),
                anyWidgetType:Style(
                  properties:Properties(
                    PropertyValue(otherProperty,"parent->any")
                  )
                )
              ]
            ),
            grandParentType:Style(
              properties:Properties(
                PropertyValue(otherProperty,"grandParent")
              ),
              children:[
                widgetType:Style(
                  properties:Properties(
                    PropertyValue(otherProperty,"grandParent->widget")
                  )
                ),
                anyWidgetType:Style(
                  properties:Properties(
                    PropertyValue(otherProperty,"grandParent->any")
                  ),
                  children:[
                    widgetType:Style(
                      properties:Properties(
                        PropertyValue(otherProperty,"grandParent->any->widget")
                      )
                    ),
                    anyWidgetType:Style(
                      properties:Properties(
                        PropertyValue(otherProperty,"grandParent->any->any")
                      )
                    )
                  ]
                ),
                parentType:Style(
                  properties:Properties(
                    PropertyValue(otherProperty,"grandParent->parent")
                  ),
                  children:[
                    widgetType:Style(
                      properties:Properties(
                        PropertyValue(otherProperty,"grandParent->parent->widget")
                      )
                    ),
                    anyWidgetType:Style(
                      properties:Properties(
                        PropertyValue(otherProperty,"grandParent->parent->any")
                      )
                    )
                  ]
                )
              ]
            ),
            anyWidgetType:Style(
              properties:Properties(
                PropertyValue(otherProperty,"any")
              ),
              children:[
                widgetType:Style(
                  properties:Properties(
                    PropertyValue(otherProperty,"any->widget")
                  )
                ),
                anyWidgetType:Style(
                  properties:Properties(
                    PropertyValue(otherProperty,"any->any")
                  ),
                  children:[
                    widgetType:Style(
                      properties:Properties(
                        PropertyValue(otherProperty,"any->any->widget")
                      )
                    ),
                    anyWidgetType:Style(
                      properties:Properties(
                        PropertyValue(otherProperty,"any->any->any")
                      )
                    )
                  ]
                ),
                parentType:Style(
                  properties:Properties(
                    PropertyValue(otherProperty,"any->parent")
                  ),
                  children:[
                    widgetType:Style(
                      properties:Properties(
                        PropertyValue(otherProperty,"any->parent->widget")
                      )
                    ),
                    anyWidgetType:Style(
                      properties:Properties(
                        PropertyValue(otherProperty,"any->parent->any")
                      )
                    )
                  ]
                )
              ]
            )
          ]
        )
        widget.style=style
        parent.style=style
        grandParent.style=style
        expect{widget.get(property:property)}.to(equal(property.defaultValue))
      }
      it("gets properties matching self over grandParent->parent->widget"){
        widget.style=Style(
          properties:Properties(PropertyValue(property,"self")),
          children:[
            grandParentType:Style(
              children:[
                parentType:Style(
                  children:[
                    widgetType:Style(
                      properties:Properties(PropertyValue(property,"grandParent->parent->widget"))
                    )
                  ]
                )
              ]
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal("self"))
      }
      it("gets properties matching grandParent->parent->widget over any->parent->widget"){
        widget.style=Style(
          children:[
            anyWidgetType:Style(
              children:[
                parentType:Style(
                  children:[
                    widgetType:Style(
                      properties:Properties(PropertyValue(property,"any->parent->widget"))
                    )
                  ]
                )
              ]
            ),
            grandParentType:Style(
              children:[
                parentType:Style(
                  children:[
                    widgetType:Style(
                      properties:Properties(PropertyValue(property,"grandParent->parent->widget"))
                    )
                  ]
                )
              ]
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal("grandParent->parent->widget"))
      }
      it("gets properties matching any->parent->widget over parent->widget"){
        widget.style=Style(
          children:[
            parentType:Style(
              children:[
                widgetType:Style(
                  properties:Properties(PropertyValue(property,"parent->widget"))
                )
              ]
            ),
            anyWidgetType:Style(
              children:[
                parentType:Style(
                  children:[
                    widgetType:Style(
                      properties:Properties(PropertyValue(property,"grandParent->parent->widget"))
                    )
                  ]
                )
              ]
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal("grandParent->parent->widget"))
      }
      it("gets properties matching parent->widget over grandParent->any->widget"){
        widget.style=Style(
          children:[
            grandParentType:Style(
              children:[
                anyWidgetType:Style(
                  children:[
                    widgetType:Style(
                      properties:Properties(PropertyValue(property,"grandParent->any->widget"))
                    )
                  ]
                )
              ]
            ),
            parentType:Style(
              children:[
                widgetType:Style(
                  properties:Properties(PropertyValue(property,"parent->widget"))
                )
              ]
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal("parent->widget"))
      }
      it("gets properties matching grandParent->any->widget over any->any->widget"){
        widget.style=Style(
          children:[
            anyWidgetType:Style(
              children:[
                anyWidgetType:Style(
                  children:[
                    widgetType:Style(
                      properties:Properties(PropertyValue(property,"any->any->widget"))
                    )
                  ]
                )
              ]
            ),
            grandParentType:Style(
              children:[
                anyWidgetType:Style(
                  children:[
                    widgetType:Style(
                      properties:Properties(PropertyValue(property,"grandParent->any->widget"))
                    )
                  ]
                )
              ]
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal("grandParent->any->widget"))
      }

      it("gets properties matching any->any->widget over any->widget"){
        widget.style=Style(
          children:[
            anyWidgetType:Style(
              children:[
                widgetType:Style(
                  properties:Properties(PropertyValue(property,"any->widget"))
                ),
                anyWidgetType:Style(
                  children:[
                    widgetType:Style(
                      properties:Properties(PropertyValue(property,"any->any->widget"))
                    )
                  ]
                )
              ]
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal("any->any->widget"))
      }
      it("gets properties matching any->widget over grandParent->widget"){
        widget.style=Style(
          children:[
            grandParentType:Style(
              children:[
                widgetType:Style(
                  properties:Properties(PropertyValue(property,"grandParent->widget"))
                )
              ]
            ),
            anyWidgetType:Style(
              children:[
                widgetType:Style(
                  properties:Properties(PropertyValue(property,"any->widget"))
                )
              ]
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal("any->widget"))
      }
      it("gets properties matching grandParent->widget over widget"){
        widget.style=Style(
          children:[
            widgetType:Style(
              properties:Properties(PropertyValue(property,"widget"))
            ),
            grandParentType:Style(
              children:[
                widgetType:Style(
                  properties:Properties(PropertyValue(property,"grandParent->widget"))
                )
              ]
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal("grandParent->widget"))
      }
      it("gets properties matching widget over grandParent->parent->any"){
        widget.style=Style(
          children:[
            grandParentType:Style(
              children:[
                parentType:Style(
                  children:[
                    anyWidgetType:Style(
                      properties:Properties(PropertyValue(property,"grandParent->parent->any"))
                    )
                  ]
                )
              ]
            ),
            widgetType:Style(
              properties:Properties(PropertyValue(property,"widget"))
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal("widget"))
      }
      it("gets properties matching grandParent->parent->any over any->parent->any"){
        widget.style=Style(
          children:[
            anyWidgetType:Style(
              children:[
                parentType:Style(
                  children:[
                    anyWidgetType:Style(
                      properties:Properties(PropertyValue(property,"any->parent->any"))
                    )
                  ]
                )
              ]
            ),
            grandParentType:Style(
              children:[
                parentType:Style(
                  children:[
                    anyWidgetType:Style(
                      properties:Properties(PropertyValue(property,"grandParent->parent->any"))
                    )
                  ]
                )
              ]
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal("grandParent->parent->any"))
      }
      it("gets properties matching any->parent->any over parent->any"){
        widget.style=Style(
          children:[
            parentType:Style(
              children:[
                anyWidgetType:Style(
                  properties:Properties(PropertyValue(property,"parent->any"))
                )
              ]
            ),
            anyWidgetType:Style(
              children:[
                parentType:Style(
                  children:[
                    anyWidgetType:Style(
                      properties:Properties(PropertyValue(property,"any->parent->any"))
                    )
                  ]
                )
              ]
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal("any->parent->any"))
      }
      it("gets properties matching parent->any over grandParent->any->any"){
        widget.style=Style(
          children:[
            grandParentType:Style(
              children:[
                anyWidgetType:Style(
                  children:[
                    anyWidgetType:Style(
                      properties:Properties(PropertyValue(property,"grandParent->any->any"))
                    )
                  ]
                )
              ]
            ),
            parentType:Style(
              children:[
                anyWidgetType:Style(
                  properties:Properties(PropertyValue(property,"parent->any"))
                )
              ]
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal("parent->any"))
      }
      it("gets properties matching grandParent->any->any over any->any->any"){
        widget.style=Style(
          children:[
            anyWidgetType:Style(
              children:[
                anyWidgetType:Style(
                  children:[
                    anyWidgetType:Style(
                      properties:Properties(PropertyValue(property,"any->any->any"))
                    )
                  ]
                )
              ]
            ),
            grandParentType:Style(
              children:[
                anyWidgetType:Style(
                  children:[
                    anyWidgetType:Style(
                      properties:Properties(PropertyValue(property,"grandParent->any->any"))
                    )
                  ]
                )
              ]
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal("grandParent->any->any"))
      }
      it("gets properties matching any->any->any over any->any"){
        widget.style=Style(
          children:[
            anyWidgetType:Style(
              children:[
                anyWidgetType:Style(
                  properties:Properties(PropertyValue(property,"any->any")),
                  children:[
                    anyWidgetType:Style(
                      properties:Properties(PropertyValue(property,"any->any->any"))
                    )
                  ]
                )
              ]
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal("any->any->any"))
      }
      it("gets properties matching any->any"){
        widget.style=Style(
          children:[
            anyWidgetType:Style(
              children:[
                anyWidgetType:Style(
                  properties:Properties(PropertyValue(property,"any->any"))
                )
              ]
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal("any->any"))
      }
      it("gets properties matching grandParent->any over any"){
        widget.style=Style(
          children:[
            grandParentType:Style(
              properties:Properties(PropertyValue(property,"any")),
              children:[
                widgetType:Style(
                  properties:Properties(PropertyValue(property,"grandParent->any"))
                )
              ]
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal("grandParent->any"))
      }
      it("gets properties matching anyWidgetType over grandParent->parent"){
        widget.style=Style(
          children:[
            grandParentType:Style(
              children:[
                parentType:Style(
                  properties:Properties(PropertyValue(property,"grandParent->parent"))
                )
              ]
            ),
            anyWidgetType:Style(
              properties:Properties(PropertyValue(property,"any"))
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal("any"))
      }
      it("gets properties matching grandParent->parent over any->parent"){
        widget.style=Style(
          children:[
            anyWidgetType:Style(
              children:[
                parentType:Style(
                  properties:Properties(PropertyValue(property,"any->parent"))
                )
              ]
            ),
            grandParentType:Style(
              children:[
                parentType:Style(
                  properties:Properties(PropertyValue(property,"grandParent->parent"))
                )
              ]
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal("grandParent->parent"))
      }
      it("gets properties matching any->parent over parent"){
        widget.style=Style(
          children:[
            parentType:Style(
              properties:Properties(PropertyValue(property,"parent"))
            ),
            anyWidgetType:Style(
              children:[
                parentType:Style(
                  properties:Properties(PropertyValue(property,"any->parent"))
                )
              ]
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal("any->parent"))
      }
      it("gets properties matching parent over grandParent"){
        widget.style=Style(
          children:[
            grandParentType:Style(
              properties:Properties(PropertyValue(property,"grandParent"))
            ),
            parentType:Style(
              properties:Properties(PropertyValue(property,"parent"))
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal("parent"))
      }

      it("gets properties of widget over properties of parent"){
        widget.style=Style(
          children:[
            grandParentType:Style(
              properties:Properties(PropertyValue(property,"grandParent"))
            ),
          ]
        )
        parent.style=Style(
          children:[
            grandParentType:Style(
              children:[
                parentType:Style(
                  children:[
                    widgetType:Style(
                      properties:Properties(PropertyValue(property,"grandParent->parent->widget"))
                    )
                  ]
                )
              ]
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal("grandParent"))
      }
      it("gets properties of parent matching grandParent->parent->widget over any->parent->widget"){
        parent.style=Style(
          children:[
            anyWidgetType:Style(
              children:[
                parentType:Style(
                  children:[
                    widgetType:Style(
                      properties:Properties(PropertyValue(property,"any->parent->widget"))
                    )
                  ]
                )
              ]
            ),
            grandParentType:Style(
              children:[
                parentType:Style(
                  children:[
                    widgetType:Style(
                      properties:Properties(PropertyValue(property,"grandParent->parent->widget"))
                    )
                  ]
                )
              ]
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal("grandParent->parent->widget"))
      }
      it("gets properties of parent matching any->parent->widget over parent->widget"){
        parent.style=Style(
          children:[
            parentType:Style(
              children:[
                widgetType:Style(
                  properties:Properties(PropertyValue(property,"parent->widget"))
                )
              ]
            ),
            anyWidgetType:Style(
              children:[
                parentType:Style(
                  children:[
                    widgetType:Style(
                      properties:Properties(PropertyValue(property,"grandParent->parent->widget"))
                    )
                  ]
                )
              ]
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal("grandParent->parent->widget"))
      }
      it("gets properties of parent matching parent->widget over grandParent->any->widget"){
        parent.style=Style(
          children:[
            grandParentType:Style(
              children:[
                anyWidgetType:Style(
                  children:[
                    widgetType:Style(
                      properties:Properties(PropertyValue(property,"grandParent->any->widget"))
                    )
                  ]
                )
              ]
            ),
            parentType:Style(
              children:[
                widgetType:Style(
                  properties:Properties(PropertyValue(property,"parent->widget"))
                )
              ]
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal("parent->widget"))
      }
      it("gets properties of parent matching grandParent->any->widget over any->any->widget"){
        parent.style=Style(
          children:[
            anyWidgetType:Style(
              children:[
                anyWidgetType:Style(
                  children:[
                    widgetType:Style(
                      properties:Properties(PropertyValue(property,"any->any->widget"))
                    )
                  ]
                )
              ]
            ),
            grandParentType:Style(
              children:[
                anyWidgetType:Style(
                  children:[
                    widgetType:Style(
                      properties:Properties(PropertyValue(property,"grandParent->any->widget"))
                    )
                  ]
                )
              ]
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal("grandParent->any->widget"))
      }

      it("gets properties of parent matching any->any->widget over any->widget"){
        parent.style=Style(
          children:[
            anyWidgetType:Style(
              children:[
                widgetType:Style(
                  properties:Properties(PropertyValue(property,"any->widget"))
                ),
                anyWidgetType:Style(
                  children:[
                    widgetType:Style(
                      properties:Properties(PropertyValue(property,"any->any->widget"))
                    )
                  ]
                )
              ]
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal("any->any->widget"))
      }
      it("gets properties of parent matching any->widget over grandParent->widget"){
        parent.style=Style(
          children:[
            grandParentType:Style(
              children:[
                widgetType:Style(
                  properties:Properties(PropertyValue(property,"grandParent->widget"))
                )
              ]
            ),
            anyWidgetType:Style(
              children:[
                widgetType:Style(
                  properties:Properties(PropertyValue(property,"any->widget"))
                )
              ]
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal("any->widget"))
      }
      it("gets properties of parent matching grandParent->widget over widget"){
        parent.style=Style(
          children:[
            widgetType:Style(
              properties:Properties(PropertyValue(property,"widget"))
            ),
            grandParentType:Style(
              children:[
                widgetType:Style(
                  properties:Properties(PropertyValue(property,"grandParent->widget"))
                )
              ]
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal("grandParent->widget"))
      }
      it("gets properties of parent matching widget over grandParent->parent->any"){
        parent.style=Style(
          children:[
            grandParentType:Style(
              children:[
                parentType:Style(
                  children:[
                    anyWidgetType:Style(
                      properties:Properties(PropertyValue(property,"grandParent->parent->any"))
                    )
                  ]
                )
              ]
            ),
            widgetType:Style(
              properties:Properties(PropertyValue(property,"widget"))
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal("widget"))
      }
      it("gets properties of parent matching grandParent->parent->any over any->parent->any"){
        parent.style=Style(
          children:[
            anyWidgetType:Style(
              children:[
                parentType:Style(
                  children:[
                    anyWidgetType:Style(
                      properties:Properties(PropertyValue(property,"any->parent->any"))
                    )
                  ]
                )
              ]
            ),
            grandParentType:Style(
              children:[
                parentType:Style(
                  children:[
                    anyWidgetType:Style(
                      properties:Properties(PropertyValue(property,"grandParent->parent->any"))
                    )
                  ]
                )
              ]
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal("grandParent->parent->any"))
      }
      it("gets properties of parent matching any->parent->any over parent->any"){
        parent.style=Style(
          children:[
            parentType:Style(
              children:[
                anyWidgetType:Style(
                  properties:Properties(PropertyValue(property,"parent->any"))
                )
              ]
            ),
            anyWidgetType:Style(
              children:[
                parentType:Style(
                  children:[
                    anyWidgetType:Style(
                      properties:Properties(PropertyValue(property,"any->parent->any"))
                    )
                  ]
                )
              ]
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal("any->parent->any"))
      }
      it("gets properties of parent matching parent->any over grandParent->any->any"){
        parent.style=Style(
          children:[
            grandParentType:Style(
              children:[
                anyWidgetType:Style(
                  children:[
                    anyWidgetType:Style(
                      properties:Properties(PropertyValue(property,"grandParent->any->any"))
                    )
                  ]
                )
              ]
            ),
            parentType:Style(
              children:[
                anyWidgetType:Style(
                  properties:Properties(PropertyValue(property,"parent->any"))
                )
              ]
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal("parent->any"))
      }
      it("gets properties of parent matching grandParent->any->any over any->any->any"){
        parent.style=Style(
          children:[
            anyWidgetType:Style(
              children:[
                anyWidgetType:Style(
                  children:[
                    anyWidgetType:Style(
                      properties:Properties(PropertyValue(property,"any->any->any"))
                    )
                  ]
                )
              ]
            ),
            grandParentType:Style(
              children:[
                anyWidgetType:Style(
                  children:[
                    anyWidgetType:Style(
                      properties:Properties(PropertyValue(property,"grandParent->any->any"))
                    )
                  ]
                )
              ]
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal("grandParent->any->any"))
      }
      it("gets properties of parent matching any->any->any over any->any"){
        parent.style=Style(
          children:[
            anyWidgetType:Style(
              children:[
                anyWidgetType:Style(
                  properties:Properties(PropertyValue(property,"any->any")),
                  children:[
                    anyWidgetType:Style(
                      properties:Properties(PropertyValue(property,"any->any->any"))
                    )
                  ]
                )
              ]
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal("any->any->any"))
      }
      it("gets properties of parent matching any->any"){
        parent.style=Style(
          children:[
            anyWidgetType:Style(
              children:[
                anyWidgetType:Style(
                  properties:Properties(PropertyValue(property,"any->any"))
                )
              ]
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal("any->any"))
      }
      it("gets properties of parent matching grandParent->any over any"){
        parent.style=Style(
          children:[
            grandParentType:Style(
              properties:Properties(PropertyValue(property,"any")),
              children:[
                widgetType:Style(
                  properties:Properties(PropertyValue(property,"grandParent->any"))
                )
              ]
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal("grandParent->any"))
      }
      it("gets properties of parent matching anyWidgetType over grandParent->parent"){
        parent.style=Style(
          children:[
            grandParentType:Style(
              children:[
                parentType:Style(
                  properties:Properties(PropertyValue(property,"grandParent->parent"))
                )
              ]
            ),
            anyWidgetType:Style(
              properties:Properties(PropertyValue(property,"any"))
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal("any"))
      }
      it("gets properties of parent matching grandParent->parent over any->parent"){
        parent.style=Style(
          children:[
            anyWidgetType:Style(
              children:[
                parentType:Style(
                  properties:Properties(PropertyValue(property,"any->parent"))
                )
              ]
            ),
            grandParentType:Style(
              children:[
                parentType:Style(
                  properties:Properties(PropertyValue(property,"grandParent->parent"))
                )
              ]
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal("grandParent->parent"))
      }
      it("gets properties of parent matching any->parent over parent"){
        parent.style=Style(
          children:[
            parentType:Style(
              properties:Properties(PropertyValue(property,"parent"))
            ),
            anyWidgetType:Style(
              children:[
                parentType:Style(
                  properties:Properties(PropertyValue(property,"any->parent"))
                )
              ]
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal("any->parent"))
      }
      it("gets properties of parent matching parent over grandParent"){
        parent.style=Style(
          children:[
            grandParentType:Style(
              properties:Properties(PropertyValue(property,"grandParent"))
            ),
            parentType:Style(
              properties:Properties(PropertyValue(property,"parent"))
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal("parent"))
      }
      it("gets properties of parent matching grandParent over self"){
        parent.style=Style(
          properties:Properties(PropertyValue(property,"self")),
          children:[
            grandParentType:Style(
              properties:Properties(PropertyValue(property,"grandParent"))
            ),
          ]
        )
        expect{widget.get(property:property)}.to(equal("grandParent"))
      }
      it("gets properties of parent over properties of grandParent"){
        parent.style=Style(
          properties:Properties(PropertyValue(property,"self"))
        )
        grandParent.style=Style(
          children:[
            grandParentType:Style(
              children:[
                parentType:Style(
                  children:[
                    widgetType:Style(
                      properties:Properties(PropertyValue(property,"self"))
                    )
                  ]
                )
              ]
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal("self"))
      }
      it("gets properties of grandParent matching grandParent->parent->widget over any->parent->widget"){
        grandParent.style=Style(
          children:[
            anyWidgetType:Style(
              children:[
                parentType:Style(
                  children:[
                    widgetType:Style(
                      properties:Properties(PropertyValue(property,"any->parent->widget"))
                    )
                  ]
                )
              ]
            ),
            grandParentType:Style(
              children:[
                parentType:Style(
                  children:[
                    widgetType:Style(
                      properties:Properties(PropertyValue(property,"grandParent->parent->widget"))
                    )
                  ]
                )
              ]
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal("grandParent->parent->widget"))
      }
      it("gets properties of grandParent matching any->parent->widget over parent->widget"){
        grandParent.style=Style(
          children:[
            parentType:Style(
              children:[
                widgetType:Style(
                  properties:Properties(PropertyValue(property,"parent->widget"))
                )
              ]
            ),
            anyWidgetType:Style(
              children:[
                parentType:Style(
                  children:[
                    widgetType:Style(
                      properties:Properties(PropertyValue(property,"grandParent->parent->widget"))
                    )
                  ]
                )
              ]
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal("grandParent->parent->widget"))
      }
      it("gets properties of grandParent matching parent->widget over grandParent->any->widget"){
        grandParent.style=Style(
          children:[
            grandParentType:Style(
              children:[
                anyWidgetType:Style(
                  children:[
                    widgetType:Style(
                      properties:Properties(PropertyValue(property,"grandParent->any->widget"))
                    )
                  ]
                )
              ]
            ),
            parentType:Style(
              children:[
                widgetType:Style(
                  properties:Properties(PropertyValue(property,"parent->widget"))
                )
              ]
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal("parent->widget"))
      }
      it("gets properties of grandParent matching grandParent->any->widget over any->any->widget"){
        grandParent.style=Style(
          children:[
            anyWidgetType:Style(
              children:[
                anyWidgetType:Style(
                  children:[
                    widgetType:Style(
                      properties:Properties(PropertyValue(property,"any->any->widget"))
                    )
                  ]
                )
              ]
            ),
            grandParentType:Style(
              children:[
                anyWidgetType:Style(
                  children:[
                    widgetType:Style(
                      properties:Properties(PropertyValue(property,"grandParent->any->widget"))
                    )
                  ]
                )
              ]
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal("grandParent->any->widget"))
      }

      it("gets properties of grandParent matching any->any->widget over any->widget"){
        grandParent.style=Style(
          children:[
            anyWidgetType:Style(
              children:[
                widgetType:Style(
                  properties:Properties(PropertyValue(property,"any->widget"))
                ),
                anyWidgetType:Style(
                  children:[
                    widgetType:Style(
                      properties:Properties(PropertyValue(property,"any->any->widget"))
                    )
                  ]
                )
              ]
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal("any->any->widget"))
      }
      it("gets properties of grandParent matching any->widget over grandParent->widget"){
        grandParent.style=Style(
          children:[
            grandParentType:Style(
              children:[
                widgetType:Style(
                  properties:Properties(PropertyValue(property,"grandParent->widget"))
                )
              ]
            ),
            anyWidgetType:Style(
              children:[
                widgetType:Style(
                  properties:Properties(PropertyValue(property,"any->widget"))
                )
              ]
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal("any->widget"))
      }
      it("gets properties of grandParent matching grandParent->widget over widget"){
        grandParent.style=Style(
          children:[
            widgetType:Style(
              properties:Properties(PropertyValue(property,"widget"))
            ),
            grandParentType:Style(
              children:[
                widgetType:Style(
                  properties:Properties(PropertyValue(property,"grandParent->widget"))
                )
              ]
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal("grandParent->widget"))
      }
      it("gets properties of grandParent matching widget over grandParent->parent->any"){
        grandParent.style=Style(
          children:[
            grandParentType:Style(
              children:[
                parentType:Style(
                  children:[
                    anyWidgetType:Style(
                      properties:Properties(PropertyValue(property,"grandParent->parent->any"))
                    )
                  ]
                )
              ]
            ),
            widgetType:Style(
              properties:Properties(PropertyValue(property,"widget"))
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal("widget"))
      }
      it("gets properties of grandParent matching grandParent->parent->any over any->parent->any"){
        grandParent.style=Style(
          children:[
            anyWidgetType:Style(
              children:[
                parentType:Style(
                  children:[
                    anyWidgetType:Style(
                      properties:Properties(PropertyValue(property,"any->parent->any"))
                    )
                  ]
                )
              ]
            ),
            grandParentType:Style(
              children:[
                parentType:Style(
                  children:[
                    anyWidgetType:Style(
                      properties:Properties(PropertyValue(property,"grandParent->parent->any"))
                    )
                  ]
                )
              ]
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal("grandParent->parent->any"))
      }
      it("gets properties of grandParent matching any->parent->any over parent->any"){
        grandParent.style=Style(
          children:[
            parentType:Style(
              children:[
                anyWidgetType:Style(
                  properties:Properties(PropertyValue(property,"parent->any"))
                )
              ]
            ),
            anyWidgetType:Style(
              children:[
                parentType:Style(
                  children:[
                    anyWidgetType:Style(
                      properties:Properties(PropertyValue(property,"any->parent->any"))
                    )
                  ]
                )
              ]
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal("any->parent->any"))
      }
      it("gets properties of grandParent matching parent->any over grandParent->any->any"){
        grandParent.style=Style(
          children:[
            grandParentType:Style(
              children:[
                anyWidgetType:Style(
                  children:[
                    anyWidgetType:Style(
                      properties:Properties(PropertyValue(property,"grandParent->any->any"))
                    )
                  ]
                )
              ]
            ),
            parentType:Style(
              children:[
                anyWidgetType:Style(
                  properties:Properties(PropertyValue(property,"parent->any"))
                )
              ]
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal("parent->any"))
      }
      it("gets properties of grandParent matching grandParent->any->any over any->any->any"){
        grandParent.style=Style(
          children:[
            anyWidgetType:Style(
              children:[
                anyWidgetType:Style(
                  children:[
                    anyWidgetType:Style(
                      properties:Properties(PropertyValue(property,"any->any->any"))
                    )
                  ]
                )
              ]
            ),
            grandParentType:Style(
              children:[
                anyWidgetType:Style(
                  children:[
                    anyWidgetType:Style(
                      properties:Properties(PropertyValue(property,"grandParent->any->any"))
                    )
                  ]
                )
              ]
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal("grandParent->any->any"))
      }
      it("gets properties of grandParent matching any->any->any over any->any"){
        grandParent.style=Style(
          children:[
            anyWidgetType:Style(
              children:[
                anyWidgetType:Style(
                  properties:Properties(PropertyValue(property,"any->any")),
                  children:[
                    anyWidgetType:Style(
                      properties:Properties(PropertyValue(property,"any->any->any"))
                    )
                  ]
                )
              ]
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal("any->any->any"))
      }
      it("gets properties of grandParent matching any->any"){
        grandParent.style=Style(
          children:[
            anyWidgetType:Style(
              children:[
                anyWidgetType:Style(
                  properties:Properties(PropertyValue(property,"any->any"))
                )
              ]
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal("any->any"))
      }
      it("gets properties of grandParent matching grandParent->any over any"){
        grandParent.style=Style(
          children:[
            grandParentType:Style(
              properties:Properties(PropertyValue(property,"any")),
              children:[
                widgetType:Style(
                  properties:Properties(PropertyValue(property,"grandParent->any"))
                )
              ]
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal("grandParent->any"))
      }
      it("gets properties of grandParent matching anyWidgetType over grandParent->parent"){
        grandParent.style=Style(
          children:[
            grandParentType:Style(
              children:[
                parentType:Style(
                  properties:Properties(PropertyValue(property,"grandParent->parent"))
                )
              ]
            ),
            anyWidgetType:Style(
              properties:Properties(PropertyValue(property,"any"))
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal("any"))
      }
      it("gets properties of grandParent matching grandParent->parent over any->parent"){
        grandParent.style=Style(
          children:[
            anyWidgetType:Style(
              children:[
                parentType:Style(
                  properties:Properties(PropertyValue(property,"any->parent"))
                )
              ]
            ),
            grandParentType:Style(
              children:[
                parentType:Style(
                  properties:Properties(PropertyValue(property,"grandParent->parent"))
                )
              ]
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal("grandParent->parent"))
      }
      it("gets properties of grandParent matching any->parent over parent"){
        grandParent.style=Style(
          children:[
            parentType:Style(
              properties:Properties(PropertyValue(property,"parent"))
            ),
            anyWidgetType:Style(
              children:[
                parentType:Style(
                  properties:Properties(PropertyValue(property,"any->parent"))
                )
              ]
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal("any->parent"))
      }
      it("gets properties of grandParent matching parent over grandParent"){
        grandParent.style=Style(
          children:[
            grandParentType:Style(
              properties:Properties(PropertyValue(property,"grandParent"))
            ),
            parentType:Style(
              properties:Properties(PropertyValue(property,"parent"))
            )
          ]
        )
        expect{widget.get(property:property)}.to(equal("parent"))
      }
      it("gets properties of grandPrarent matching grandParent over self"){
        grandParent.style=Style(
          properties:Properties(PropertyValue(property,"self")),
          children:[
            grandParentType:Style(
              properties:Properties(PropertyValue(property,"grandParent"))
            ),
          ]
        )
        expect{widget.get(property:property)}.to(equal("grandParent"))
      }
    }
  }
}

