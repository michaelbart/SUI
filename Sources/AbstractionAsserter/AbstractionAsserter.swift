import Foundation

/**
  To enable AbstractionAsserter, inherit from AbstractionAsserter.
  Call abstractInit() on all initializers of abstract class. Call abstractMethod() on any abstract method.
  These function's will assert if these abstract method or initialiser are called and fail during runtime.
*/
public protocol AbstractionAsserter {
}

extension AbstractionAsserter {
  /**
    Asserts if Init is called on an object that is directly of the abstract class. This will not assert if the object is of any other class that inherits from the abstract class. This should be called on all initializers of an abstract class.

    Important: class is expected to be defined in className.swift. If this is not the case, ClasName will need to be specified or assert will fail silently.

    - Parameters:
      - className: The name of the abstract class.
      - file: The file the function where abstractInit is called.
      - line: The line number of the where abstractInit is called.
  */
  public func abstractInit(
    className:String=URL(fileURLWithPath:#file).deletingPathExtension().lastPathComponent,
    file:StaticString=#file,
    line:UInt=#line
  ) {
    assert("\(type(of:self))" != className, "constructor called on abstract class", file:file, line:line)
  }

  /**
    Always asserts when called. This should be the only member of all abstract methods.

    - Parameters:
      - file: The file the fuction where abstractMethod is called.
      - line: The line number of the where abstractMethod is called.

  */
  public func abstractMethod(
    file:StaticString=#file,
    line:UInt=#line
  ) {
    assert(false, "abstract method called on abstract class", file:file, line:line)
  }
}
