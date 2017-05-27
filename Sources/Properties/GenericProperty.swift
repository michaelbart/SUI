import AbstractionAsserter
import HashableUsingAddress

public /*abstract*/ class GenericProperty<U:Any>:AbstractionAsserter, HashableUsingAddress {
  /**
    Creates a new GenericProperty.
  */
  /*abstract*/ init() {
    abstractInit()
  }
}

