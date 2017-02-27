@testable import Sui

public class MockWidget : Widget {
  var cashedStyleCleared=false
  override public func clearStyleCashe() {
    cashedStyleCleared=true
    super.clearStyleCashe()
  }

  var cashedRequestedSizeCleared=false
  override public func clearRequestedSizeCashe() {
    cashedRequestedSizeCleared=true
    super.clearRequestedSizeCashe()
  }

  var cashedAllocatedSpaceCleared=false
  override public func clearAllocatedSpaceCashe() {
    cashedAllocatedSpaceCleared=true
    super.clearAllocatedSpaceCashe()
  }
}
