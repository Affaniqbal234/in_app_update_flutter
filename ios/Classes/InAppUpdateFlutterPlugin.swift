import UIKit
import Flutter
import StoreKit

public class InAppUpdateFlutterPlugin: NSObject, FlutterPlugin, SKStoreProductViewControllerDelegate {
  var flutterResult: FlutterResult?
  var controller: UIViewController?

  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "in_app_update_flutter", binaryMessenger: registrar.messenger())
    let instance = InAppUpdateFlutterPlugin()
    instance.controller = UIApplication.shared.delegate?.window??.rootViewController
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    if call.method == "showStoreUpdate",
       let args = call.arguments as? [String: Any],
       let appStoreId = args["appStoreId"] as? String {
      flutterResult = result
      showStoreProductView(appStoreId: appStoreId)
    } else {
      result(FlutterMethodNotImplemented)
    }
  }

  private func showStoreProductView(appStoreId: String) {
    let productViewController = SKStoreProductViewController()
    productViewController.delegate = self

    let parameters = [SKStoreProductParameterITunesItemIdentifier : appStoreId]

    productViewController.loadProduct(withParameters: parameters) { loaded, error in
      if let error = error {
        self.flutterResult?(FlutterError(code: "STORE_ERROR", message: "Failed to load product", details: error.localizedDescription))
        return
      }

      if loaded, let vc = self.controller {
        vc.present(productViewController, animated: true) {
          self.flutterResult?(nil)
        }
      } else {
        self.flutterResult?(FlutterError(code: "STORE_NOT_LOADED", message: "Could not load product", details: nil))
      }
    }
  }

  public func productViewControllerDidFinish(_ viewController: SKStoreProductViewController) {
    viewController.dismiss(animated: true, completion: nil)
  }
}
