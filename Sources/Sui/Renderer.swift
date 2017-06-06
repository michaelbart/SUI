public struct Renderer {
  var size: Point
  var position: Point
  let canvas: Canvas

  public func draw(point:Point) {
    canvas.draw(point:point, renderer:self)
  }

  public func fill() {
    canvas.fill(renderer:self)
  }

  public func drawLine(from pointA:Point, to pointB: Point) {
    canvas.drawLine(from:pointA, to:pointB, renderer:self)
  }

  public init (canvas:Canvas) {
    self.canvas = canvas
    self.size = canvas.size
    self.position = Point(0,0)
  }
}

