import 'dart:convert';
import 'dart:ui';

enum OndatoEnvironment { test, live }
/* 
English (en) 🇬🇧
Lithuanian (lt) 🇱🇹
German (de) 🇩🇪
Latvian (lv) 🇱🇻
Estonian (et) 🇪🇪
Russian (ru) 🇷🇺
Albanian (sq)
 */
enum OndatoLanguage { en, de, lt, lv, et, ru, sq }

extension OndatoEnvironmentExt on OndatoEnvironment {
  String toMap() => this.toString().split('.').elementAt(1);
}

extension OndatoLanguageExt on OndatoLanguage {
  String toMap() => this.toString().split('.').elementAt(1);
}

class OndatoServiceConfiguration {
  OndatoIosAppearance? appearance;
  OndatoFlowConfiguration? flowConfiguration;
  OndatoEnvironment? mode;
  OndatoLanguage language;
  OndataCredencials credentials;

  OndatoServiceConfiguration({
    this.appearance,
    this.flowConfiguration,
    this.mode = OndatoEnvironment.test,
    this.language = OndatoLanguage.en,
    required this.credentials,
  });

  Map<String, dynamic> toMap() {
    return {
      'appearance': appearance?.toMap(),
      'flowConfiguration': flowConfiguration?.toMap(),
      'mode': mode?.toMap(),
      'language': language.toMap(),
      'credentials': credentials.toMap(),
    };
  }
}

class OndataCredencials {
  OndataCredencials({
    required this.accessToken,
    required this.identificationId,
  });
  final String accessToken;
  final String identificationId;

  Map<String, String> toMap() {
    return {'accessToken': accessToken, 'identificationId': identificationId};
  }
}

class OndatoFlowConfiguration {
  /// Should the splash screen be shown
  bool showSplashScreen;

  /// Should the start screen be shown
  bool showStartScreen;

  /// Should the consent screen be shown
  bool showConsentScreen;

  /// Should a selfie with document be requested when taking document pictures
  bool showSelfieAndDocumentScreen;

  /// Should the success window be shown
  bool showSuccessWindow;

  /// Allows user to skip liveness check in case of failure
  bool ignoreLivenessErrors;

  /// Allows user to skip document verification error result checks
  bool ignoreVerificationErrors;

  /// Should the verification process be recorded
  bool recordProcess;

  /// As for back of drive licence
  bool askDriverLicenseBackSide;

  OndatoFlowConfiguration(
      {this.showSplashScreen = true,
      this.showStartScreen = true,
      this.showConsentScreen = true,
      this.showSelfieAndDocumentScreen = true,
      this.showSuccessWindow = true,
      this.ignoreLivenessErrors = true,
      this.ignoreVerificationErrors = true,
      this.recordProcess = true,
      this.askDriverLicenseBackSide = true});

  Map<String, dynamic> toMap() {
    return {
      'showSplashScreen': showSplashScreen,
      'showStartScreen': showStartScreen,
      'showConsentScreen': showConsentScreen,
      'showSelfieAndDocumentScreen': showSelfieAndDocumentScreen,
      'showSuccessWindow': showSuccessWindow,
      'ignoreLivenessErrors': ignoreLivenessErrors,
      'ignoreVerificationErrors': ignoreVerificationErrors,
      'recordProcess': recordProcess,
      'askDriverLicenseBackSide': askDriverLicenseBackSide,
    };
  }

  factory OndatoFlowConfiguration.fromMap(Map<String, dynamic> map) {
    return OndatoFlowConfiguration(
      showSplashScreen: map['showSplashScreen'],
      showStartScreen: map['showStartScreen'],
      showConsentScreen: map['showConsentScreen'],
      showSelfieAndDocumentScreen: map['showSelfieAndDocumentScreen'],
      showSuccessWindow: map['showSuccessWindow'],
      ignoreLivenessErrors: map['ignoreLivenessErrors'],
      ignoreVerificationErrors: map['ignoreVerificationErrors'],
      recordProcess: map['recordProcess'],
    );
  }
}

class OndatoIosAppearance {
  /// Logo image that can be shown in the splash screen
  String? logoImageBase64;

  /// background color of the `ProgressBarView` which guides the user through the flow
  Color? progressColor;

  /// background color of the primary action buttons
  Color? buttonColor;

  /// background color of the primary action buttons text
  Color? buttonTextColor;

  /// background color of the error message background
  Color? errorColor;

  /// background color of the error message text color
  Color? errorTextColor;

  Color? headerColor;

  Color? acceptButtonColor;

  Color? declineButtonColor;

  OndatoIosAppearance({
    this.logoImageBase64,
    this.progressColor,
    this.buttonColor,
    this.buttonTextColor,
    this.errorColor,
    this.errorTextColor,
    this.headerColor,
    this.acceptButtonColor,
    this.declineButtonColor,
  });

  /// appearance of header, body, acceptButton, declineButton in consent screen
  //var consentWindow;

  Map<String, dynamic> toMap() {
    return {
      'logoImageBase64': logoImageBase64,
      'progressColor': progressColor?.value,
      'buttonColor': buttonColor?.value,
      'buttonTextColor': buttonTextColor?.value,
      'errorColor': errorColor?.value,
      'errorTextColor': errorTextColor?.value,
      'headerColor': headerColor?.value,
      'acceptButtonColor': acceptButtonColor?.value,
      'declineButtonColor': declineButtonColor?.value,
    };
  }
}

class OndatoException implements Exception {
  OndatoError? error;
  String identificationId;
  OndatoException(this.identificationId, error) {
    switch (error) {
      case 'cancelled':
        this.error = OndatoError.cancelled;
        break;
      case 'invalidServerResponse':
        this.error = OndatoError.invalidServerResponse;
        break;
      case 'invalidCredentials':
        this.error = OndatoError.invalidCredentials;
        break;
      default:
        this.error = OndatoError.unexpectedInternalError;
    }
  }
}

enum OndatoError {
  cancelled,
  invalidServerResponse,
  invalidCredentials,
  unexpectedInternalError
}

class OndatoResponse {
  bool? success;
  String? identificationId;
  String? error;
  OndatoResponse({
    this.success,
    this.identificationId,
    this.error,
  });

  Map<String, dynamic> toMap() {
    return {
      'success': success,
      'identificationId': identificationId,
      'error': error,
    };
  }

  factory OndatoResponse.fromMap(Map<String, dynamic> map) {
    return OndatoResponse(
      success: map['success'],
      identificationId: map['identificationId'],
      error: map['error'],
    );
  }

  String toJson() => json.encode(toMap());

  factory OndatoResponse.fromJson(String source) =>
      OndatoResponse.fromMap(json.decode(source));

  @override
  String toString() =>
      'OndatoResponse(success: $success, identificationId: $identificationId, error: $error)';
}
