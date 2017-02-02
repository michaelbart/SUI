/**
  All the WidgetTypes of Views.
*/
fileprivate var viewWidgetTypes:[String:WidgetType]=[:]

public class View<T:Any>:ModelWidget<T> {

  /**
    Create View of a value.
    - Parameter of value: The value to make a View of. This will create a model of the value.
  */
  public init(of value:T) {
    super.init(of:Model(of:value))
  }

  /**
    Create View of a model.
    - Parameter of model: The model to make a View of.
  */
  public override init(of model:Model<T>) {
    super.init(of:model)
  }

  /**
    The WidgetType of the View. Each generic has a seperate WidgetType.
  */
  static var viewWidgetType: WidgetType{
    get {
      if let widgetType=viewWidgetTypes[getTypeName()] {
        return widgetType
      }
      let widgetType=WidgetType(parent:genericWidgetType)
      viewWidgetTypes[getTypeName()] = widgetType
      return widgetType
    }
  }
}
