import Flutter
import UIKit
import OndatoSDK


public class SwiftOndatoSkdPlugin: NSObject, FlutterPlugin {

    
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "ondato_skd", binaryMessenger: registrar.messenger())
        let instance = SwiftOndatoSkdPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
        
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        
        switch call.method {
        case "getPlatformVersion":
        result(FlutterMethodNotImplemented)
            //result("iOS " + UIDevice.current.systemVersion)
        case "initialSetup":
            create(call: call, flutterResult: result)
        case "startIdentification":
            startIdentification(flutterResult: result)
        default:
            result(FlutterMethodNotImplemented)
        }
        
    }
    
    func create(call:
                    FlutterMethodCall, flutterResult: FlutterResult) -> Void {
        guard let args = call.arguments as? [String: Any] else {
            return}
        guard let credencials : Dictionary<String, Any> = args["credencials"] as? [String: Any] else {
            flutterResult(false)
            return
        }
        
        if let accessToken: String = credencials["accessToken"] as? String {
            OndatoService.shared.initialize(accessToken: accessToken)
        }
        if let username = credencials["username"] as? String, let password = credencials["password"] as? String {
            OndatoService.shared.initialize(username: username, password: password)
        }
        
        
        let configuration: OndatoServiceConfiguration = OndatoService.shared.configuration
        if let appearance : [String: Any] = args["appearance"] as? [String:Any]{
            let ondatoAppearance =  OndatoAppearance()
            
            if let buttonColor : Int = appearance["buttonColor"] as? Int {
                ondatoAppearance.buttonColor = buttonColor.toUIColor()
            }
            
            if let buttonTextColor : Int = appearance["buttonTextColor"] as? Int {
                ondatoAppearance.buttonTextColor = buttonTextColor.toUIColor()
            }
            
            if let errorColor : Int = appearance["errorColor"] as? Int {
                ondatoAppearance.errorColor = errorColor.toUIColor()
            }
            
            if let errorTextColor : Int = appearance["errorTextColor"] as? Int {
                ondatoAppearance.errorTextColor = errorTextColor.toUIColor()
            }
            
            
            if let errorTextColor : Int = appearance["errorTextColor"] as? Int {
                ondatoAppearance.errorTextColor = errorTextColor.toUIColor()
            }
            
            if let regularFontName : String = appearance["regularFontName"] as? String {
                ondatoAppearance.regularFontName = regularFontName
            }
            
            if let mediumFontName : String = appearance["mediumFontName"] as? String {
                ondatoAppearance.mediumFontName = mediumFontName
            }
            
            configuration.appearance = ondatoAppearance
            
        }
        
        if let flowConfiguration : [String: Any] = args["flowConfiguration"] as? [String:Any]{
            let ondatoFlowConfiguration = OndatoFlowConfiguration()
            
            ondatoFlowConfiguration.showSplashScreen = (flowConfiguration["showSplashScreen"] as? Bool) ?? true
            ondatoFlowConfiguration.showStartScreen = (flowConfiguration["showStartScreen"] as? Bool) ?? true
            ondatoFlowConfiguration.showConsentScreen = (flowConfiguration["showConsentScreen"] as? Bool) ?? true
            ondatoFlowConfiguration.showSelfieAndDocumentScreen = (flowConfiguration["showSelfieAndDocumentScreen"] as? Bool) ?? true
            ondatoFlowConfiguration.showSuccessWindow = (flowConfiguration["showSuccessWindow"] as? Bool) ?? true
            ondatoFlowConfiguration.ignoreLivenessErrors = (flowConfiguration["ignoreLivenessErrors"] as? Bool) ?? false
            ondatoFlowConfiguration.ignoreVerificationErrors = (flowConfiguration["ignoreVerificationErrors"] as? Bool) ?? false
            ondatoFlowConfiguration.recordProcess = (flowConfiguration["recordProcess"] as? Bool) ?? true
            
            configuration.flowConfiguration = ondatoFlowConfiguration;
            
        }
        if let mode : String = args["mode"] as? String {
            
            configuration.mode = mode == "live" ? OndatoEnvironment.live : OndatoEnvironment.test
        }
        
        if let language :  String = args["language"] as? String {
            var selectedLanguage : OndatoSDK.OndatoSupportedLanguage
            switch language {
            case "en":
                selectedLanguage = OndatoSDK.OndatoSupportedLanguage.EN
            case "de":
                selectedLanguage = OndatoSDK.OndatoSupportedLanguage.DE
            case "lt":
                selectedLanguage = OndatoSDK.OndatoSupportedLanguage.LT
            default:
                selectedLanguage = OndatoSDK.OndatoSupportedLanguage.EN
            }
            OndatoLocalizeHelper.language = selectedLanguage
        }
        
        DispatchQueue.main.async {
            let sdk = OndatoService.shared.instantiateOndatoViewController()
            sdk.modalPresentationStyle = .fullScreen
            
            self.present(sdk, animated: true, completion: nil)
        }
    }
    
    func startIdentification(flutterResult: @escaping  FlutterResult) {
        weak var delegate: OndatoSDK.OndatoFlowDelegate? =  {() -> OndatoSDK.OndatoFlowDelegate in
            class FlowDelegate : OndatoSDK.OndatoFlowDelegate {
                private let result : FlutterResult
                init(r: @escaping FlutterResult) {
                    self.result = r
                }
                func flowDidSucceed(identificationId: String?) {
                    result(["identificationId": identificationId])
                }
                
                func flowDidFail(identificationId: String?, error: OndatoServiceError) {
                    result(["identificationId": identificationId, "error": String(error.rawValue)])
                }  
            }
            let flowDelegate = FlowDelegate(r: flutterResult)
            return flowDelegate
        }()
        
        OndatoService.shared.flowDelegate = delegate
            
    }
}

extension Int {
    func toUIColor() -> UIColor {
        let uInt32Color = UInt32(self)
        let mask : UInt32 = 0x000000FF
        let alpha = CGFloat(uInt32Color >> 24)
        let red = CGFloat((uInt32Color >> 16) & mask)
        let green = CGFloat((uInt32Color >> 8) & mask)
        let blue = CGFloat(uInt32Color & mask)
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
}
