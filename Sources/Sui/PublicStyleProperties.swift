let addedToContainer:StyleProperty<(Widget?, Widget)->()> = StyleProperty() { (Container, contained) in }

let removedFromContainer:StyleProperty<(Widget?, Widget)->()> = StyleProperty() { (container, contained) in }

let addedContained:StyleProperty<(Widget, Widget)->()> = StyleProperty() { (container, contained) in }

let removedContained:StyleProperty<(Widget, Widget)->()> = StyleProperty() { (container, contained) in }

