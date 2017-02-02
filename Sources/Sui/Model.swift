import AbstractionAsserter
import Weak

public /* abstract */ class GenericModel: AbstractionAsserter {
  /**
    Create a View of model.
    - Returns: The new View.
  */
  public /*abstract*/ func createView() -> Widget {
    abstractMethod()
    return Widget(type:anyWidgetType)
  }

  /**
    Create a Control of model.
    - Returns: The new Control.
  */
  public /*abstract*/ func createControl() -> Widget {
    abstractMethod()
    return Widget(type:anyWidgetType)
  }

  /**
    Creates a new Model.
  */
  /*abstract*/ fileprivate init() {
    abstractInit()
  }
}

public class Model<T:Any>:GenericModel {
  /** 
    All widgets of model.
  */
  private var modelWidgets:[Weak<ModelWidget<T>>]=[]

  /**
    Add a modelWidget to modelWidgets. This should only be used on modelWidget's init.
  */
  func add(modelWidget:ModelWidget<T>) {
    modelWidgets.append(Weak(modelWidget))
  }

  /**
    Remove a modelWidget from modelWidgets. This shoudl only be used on modelWidget's deinit.
  */
  func remove(modelWidget:ModelWidget<T>) {
    modelWidgets=modelWidgets.filter() { $0.value === modelWidget }
  }

  /** 
    The value for the model.
  */
  public var value:T {
    didSet {
      for modelWidget in modelWidgets {
        modelWidget.value?.update()
      }
    }
  }

  /**
    Create a new model of value.
    - Parameter value: The value of the model.
  */
  public init(of value:T) {
    self.value=value
  }

  /**
    Create a View of model.
    - Returns: The new View.
  */
  public override func createView() -> View<T> {
    return View(of:self)
  }

  /**
    Create a Control of model.
    - Returns: The new Control.
  */
  public override func createControl() -> Control<T> {
    return Control(of:self)
  }
}
 
