public struct GeneratedValue<InputType:Any, T:Any> {
  private var cashe:T?
  private let generate:(InputType)->T

  /**
    Clears cashe so that next time value is requested, GeneratedValue will
    generate a new value. Call this any time generated value is expected to
    change it's returned value.
  */
  public mutating func clearCashe() {
    cashe=nil
  }

  /**
    Gets the cahsed value. If the value is not cahsed, generate it first.
  */
  public mutating func get(_ input:InputType) -> T {
    if let value=cashe {
      return value
    }
    let value=generate(input)
    cashe=value
    return value
  }

  /**
    Create a new GeneratedValue
    - Parameter generate: Closure to run to cahse value when value is requested.
  */
  public init(_ generate: @escaping (InputType)->T) {
    self.generate=generate
  }
}
