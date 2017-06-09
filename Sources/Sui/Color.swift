
public struct Color {
  public let red: UInt8
  public let green: UInt8
  public let blue: UInt8
  public let alpha: UInt8

  public init (
    red: UInt8,
    green: UInt8,
    blue: UInt8,
    alpha: UInt8 = 255
  ) {
    // TODO: error if any color is not between 0 and 1
    self.red = red
    self.green = green
    self.blue = blue
    self.alpha = alpha
  }
}
