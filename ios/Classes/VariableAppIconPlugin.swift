import Flutter
import UIKit

public class VariableAppIconPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "variable_app_icon", binaryMessenger: registrar.messenger())
    let instance = VariableAppIconPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  // public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {

  //   guard let arguments = call.arguments as? [String: Any] else { return }

  //   switch call.method {
  //   case "changeAppIcon":
  //     let defaultIcon = arguments["defaultiOS"] as! String
  //     let currentIcon = arguments["iosIcon"] as! String
  //     UIApplication.shared.setAlternateIconName(defaultIcon == currentIcon ? nil : currentIcon)

  //   default:
  //     result(FlutterMethodNotImplemented)
  //   }
  // }
  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    guard let arguments = call.arguments as? [String: Any] else { return }

    switch call.method {
    case "changeAppIcon":
        let defaultIcon = arguments["defaultiOS"] as! String
        let currentIcon = arguments["iosIcon"] as! String
        let iconName = defaultIcon == currentIcon ? nil : currentIcon

        UIApplication.shared.setAlternateIconName(iconName) { (error) in
            if let error = error {
                // Обработка ошибки
                result(FlutterError(code: "IconChangeFailed", message: "Не удалось изменить иконку: \(error.localizedDescription)", details: nil))
            } else {
                // Показываем UIAlertController с информацией о смене иконки
                if let viewController = UIApplication.shared.delegate?.window??.rootViewController {
                    let alert = UIAlertController(title: "Смена иконки", message: "Иконка приложения была успешно изменена.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    viewController.present(alert, animated: true, completion: nil)
                }
                result(nil)
            }
        }

    default:
        result(FlutterMethodNotImplemented)
    }
}

}
