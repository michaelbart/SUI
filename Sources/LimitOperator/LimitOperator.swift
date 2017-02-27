public protocol MinMaxType {
  static var min: Self { get }
  static var max: Self { get }
}

extension Int : MinMaxType {}
extension Int8 : MinMaxType {}
extension Int16 : MinMaxType {}
extension Int32 : MinMaxType {}
extension Int64 : MinMaxType {}
extension UInt : MinMaxType {}
extension UInt8 : MinMaxType {}
extension UInt16 : MinMaxType {}
extension UInt32 : MinMaxType {}
extension UInt64 : MinMaxType {}

infix operator ^+ : AdditionPrecedence
infix operator ^- : AdditionPrecedence
infix operator ^* : MultiplicationPrecedence

/**
  limit addition operator
  - Returns: max value for data type if overflow occurs on addition, else returns the result of the addition.
*/
public func ^+<T:MinMaxType & IntegerArithmetic> (left: T, right: T) -> T{
  let (a, didOverflow) = T.addWithOverflow(left, right)
  if didOverflow {
    return T.max
  }
  return a
}

/**
  limit subtraction operator
  - Returns: min value for data type if overflow occurs on subtraction, else returns the result of the subtraction.
*/
public func ^-<T:MinMaxType & IntegerArithmetic> (left: T, right: T) -> T{
  let (a, didOverflow) = T.subtractWithOverflow(left, right)
  if didOverflow {
    return T.min
  }
  return a
}

/**
  limit multiplication operator
  - Returns: max value for data type if overflow occurs on multiplication, else returns the result of the multiplication.
*/
public func ^*<T:MinMaxType & IntegerArithmetic> (left: T, right: T) -> T{
  let (a, didOverflow) = T.multiplyWithOverflow(left, right)
  if didOverflow {
    return T.max
  }
  return a
}

