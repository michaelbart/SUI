/**
  All the WidgetTypes of Controls.
*/
fileprivate var controlWidgetTypes:[String:WidgetType]=[:]

public class Control<T:Any>:ModelWidget<T> {

  /**
    Create Control of a value.
    - Parameter of value: The value to make a Control of. This will create a model of the value.
  */
  init(of value:T) {
    super.init(of:Model(of:value))
  }

  /**
    Create Control of a model.
    - Parameter of model: The model to make a Control of.
  */
  override init(of model:Model<T>) {
    super.init(of:model)
  }

  /**
    The WidgetType of the Contorl. Each generic has a seperate WidgetType.
  */
  static var controlWidgetType: WidgetType{
    get {
      if let widgetType=controlWidgetTypes[getTypeName()] {
        return widgetType
      }
      let widgetType=WidgetType(parent:genericWidgetType)
      controlWidgetTypes[getTypeName()] = widgetType
      return widgetType
    }
  }
}
