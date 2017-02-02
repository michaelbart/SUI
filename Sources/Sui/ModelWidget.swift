import AbstractionAsserter

/**
  All WidgetTypes of ModelWidgets.
*/
fileprivate var genericWidgetTypes:[String:WidgetType]=[:]

public /*Abstract*/ class ModelWidget<T:Any>:Widget, AbstractionAsserter {
  /**
    The model this is a Widget of.
  */
  var model:Model<T>

  /**
    updates the widget from changes of model
  */
  func update() {
  }

  /**
    Create a new ModelWidget
    -Parameter of model: The model to make a Widget of.
  */
  init(of model:Model<T>) {
    self.model=model
    super.init(type:ModelWidget.genericWidgetType)
    abstractInit()
    model.add(modelWidget:self)
  }

  deinit {
    model.remove(modelWidget:self)
  }
  /**
    Gets the name of the generic type.
    - Returns: The name of the generic type.
  */
  static func getTypeName() -> String {
    return String(describing: type(of: T.self))
  }

  /**
    The WidgetType of the ModelWidget. Each generic has a seperate WidgetType.
  */
  public static var genericWidgetType: WidgetType{
    get {
      if let widgetType=genericWidgetTypes[getTypeName()] {
        return widgetType
      }
      let widgetType=WidgetType(parent:anyWidgetType)
      genericWidgetTypes[getTypeName()] = widgetType 
      return widgetType
    }
  }
}
