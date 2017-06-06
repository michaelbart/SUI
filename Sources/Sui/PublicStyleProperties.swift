import Properties

// MARK: property addedToContainer
func onDidSetContainerEvent4(widget:Widget, newContainer:Widget) {
  widget.get(property:addedToContainer)(newContainer, widget)
}

public let addedToContainer = Property<
  (Widget, Widget)->(),
  Style
>() {
  (Container, contained) in
}

// MARK: property removedFromContainer
func onWillSetContainerEvent3(widget:Widget, oldContainer:Widget) {
  widget.get(property:removedFromContainer)(oldContainer, widget)
}

public let removedFromContainer = Property<
 (Widget, Widget)->(), Style
>() {
 (container, contained) in
}

// MARK: property addedContained
func onDidSetContainerEvent3(widget:Widget, newContainer:Widget) {
  newContainer.get(property:addedContained)(newContainer, widget)
}

public let addedContained = Property<
  (Widget, Widget)->(),
   Style
>() {
 (container, contained) in
}

// MARK: property removedContained
func onWillSetContainerEvent2(widget:Widget, oldContainer:Widget) {
  oldContainer.get(property:removedContained)(oldContainer, widget)
}

public let removedContained = Property<
  (Widget, Widget)->(),
  Style
>() {
  (container, contained) in
}

// MARK: property contentsEmptied
func onDidSetContentsEvent1(widget:Widget) {
  if widget.contents.count == 0 {
    widget.get(property:contentsEmptied)(widget)
  }
}

let contentsEmptied = Property<(Widget)->(), Style>() { (widget) in }

// MARK: property allocatedSpaceChanged

public let allocatedSpaceChanged = Property<(Widget)->(), Style>() { (widget) in
}

// MARK: property redraw

public let drawBackground = Property<(Widget, Renderer)->(), Style> {
  (widget, renderer) in
}

public let drawForground = Property<(Widget, Renderer)->(), Style> {
  (widget, renderer) in
}
