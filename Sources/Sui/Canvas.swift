public protocol Canvas : class {
  var size:Point { get }
  func draw(point:Point, renderer:Renderer)
  func fill(renderer:Renderer)
  func drawLine(from pointA:Point, to pointB: Point, renderer:Renderer)
}

public extension Canvas {
  func fill(renderer:Renderer) {
    for x in 0 ..< renderer.size.x {
      for y in 0 ..< renderer.size.y {
         draw(point:Point(x,y), renderer:renderer)
      }
    }
  }

  func drawLine(from pointA:Point, to pointB: Point, renderer:Renderer) {
    let dx = pointA.x - pointB.x
    let dy = pointA.y - pointB.y
    if(dx > dy) {
      for x in pointA.x ... pointB.x {
        draw(point:Point(x, pointB.y + dy * (x - pointB.x) / dx), renderer:renderer)
      }
    } else {
      for y in pointA.y ... pointB.y {
        draw(point:Point(pointB.x + dx * (y - pointB.y) / dy, y), renderer:renderer)
      }
    }
  }

  func fullSquare(from pointA:Point, to pointB: Point, renderer: Renderer) {
    var renderer = renderer

    let dx = abs(pointA.x - pointB.x)
    let dy = abs(pointA.y - pointB.y)
    renderer.size = Point(dx + renderer.size.x, dy + renderer.size.y)

    let x = min(pointA.x, pointB.x)
    let y = min(pointA.y, pointB.y)
    renderer.position = Point(x,y)

    fill(renderer:renderer)
  }
}

