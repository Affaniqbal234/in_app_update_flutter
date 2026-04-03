import Flutter
import UIKit
import XCTest

@testable import in_app_update_flutter

class RunnerTests: XCTestCase {

  func testShowStoreUpdateWithoutArgs() {
    let plugin = InAppUpdateFlutterPlugin()

    let call = FlutterMethodCall(methodName: "showStoreUpdate", arguments: nil)

    let resultExpectation = expectation(description: "result block must be called.")
    plugin.handle(call) { result in
      // Without valid arguments, the plugin should return FlutterMethodNotImplemented
      XCTAssertEqual(result as? NSObject, FlutterMethodNotImplemented as NSObject)
      resultExpectation.fulfill()
    }
    waitForExpectations(timeout: 1)
  }

  func testUnknownMethod() {
    let plugin = InAppUpdateFlutterPlugin()

    let call = FlutterMethodCall(methodName: "unknownMethod", arguments: nil)

    let resultExpectation = expectation(description: "result block must be called.")
    plugin.handle(call) { result in
      XCTAssertEqual(result as? NSObject, FlutterMethodNotImplemented as NSObject)
      resultExpectation.fulfill()
    }
    waitForExpectations(timeout: 1)
  }

}
