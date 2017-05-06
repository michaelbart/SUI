// MARK: property addedToContainer
func onDidSetContainerEvent4(widget:Widget, newContainer:Widget) {
  widget.get(property:addedToContainer)(newContainer, widget)
}

let addedToContainer:StyleProperty<(Widget, Widget)->()> = StyleProperty() { (Container, contained) in }

// MARK: property removedFromContainer
func onWillSetContainerEvent3(widget:Widget, oldContainer:Widget) {
  widget.get(property:removedFromContainer)(oldContainer, widget)
}

let removedFromContainer:StyleProperty<(Widget, Widget)->()> = StyleProperty() { (container, contained) in }

// MARK: property addedContained
func onDidSetContainerEvent3(widget:Widget, newContainer:Widget) {
  newContainer.get(property:addedContained)(newContainer, widget)
}

let addedContained:StyleProperty<(Widget, Widget)->()> = StyleProperty() { (container, contained) in }

// MARK: property removedContained
func onWillSetContainerEvent2(widget:Widget, oldContainer:Widget) {
  oldContainer.get(property:removedContained)(oldContainer, widget)
}

let removedContained:StyleProperty<(Widget, Widget)->()> = StyleProperty() { (container, contained) in }

// MARK: property contentsEmptied
func onDidSetContentsEvent1(widget:Widget) {
  if widget.contents.count == 0 {
    widget.get(property:contentsEmptied)(widget)
  }
}

let contentsEmptied:StyleProperty<(Widget)->()> = StyleProperty() { (widget) in }

