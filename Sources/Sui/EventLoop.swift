import CoreFoundation

/**
  Starts the EventLoop in a run cycle and block until eventloopStop is called from an event.

  eventLooprun may be called recursively. When calling recusivly, eventLoopStop will only unblock last called eventLoopRun.
**/
public func eventLoopRun() {
  CFRunLoopRun()
}

/**
  stops the EventLoop from a run cycle. The event loop may continue until there are no closures to be ran.

  If eventLoopRan was called recusivly, eventLoopStop will only unblock last called eventLoopRun.
**/
public func eventLoopStop() {
  eventLoopPerform{
    CFRunLoopStop(CFRunLoopGetCurrent())
  }
  CFRunLoopWakeUp(CFRunLoopGetCurrent())
}

/**
  Adds an closure to be ran on the EventLoop.
*/
public func eventLoopPerform(_ block: @escaping ()->()) {
  CFRunLoopPerformBlock(CFRunLoopGetCurrent(), kCFRunLoopDefaultMode, block) 
  CFRunLoopWakeUp(CFRunLoopGetCurrent())
}

