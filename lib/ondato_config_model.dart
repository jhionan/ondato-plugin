import 'dart:typed_data';
import 'dart:ui';

enum OndatoEnvironment { test, live }
enum OndatoLanguage { en, de, lt }

extension OndatoEnvironmentExt on OndatoEnvironment {
  String toMap() => this.toString().split('.')?.elementAt(1);
}

extension OndatoLanguageExt on OndatoLanguage {
  String toMap() => this.toString().split('.')?.elementAt(1);
}

class OndatoServiceConfiguration {
  OndatoAppearance appearance;
  OndatoFlowConfiguration flowConfiguration;
  OndatoEnvironment mode;
  OndatoLanguage language;
  OndataCredencials credencials;

  OndatoServiceConfiguration({
    this.appearance,
    this.flowConfiguration,
    this.mode = OndatoEnvironment.test,
    this.language = OndatoLanguage.en,
    this.credencials,
  }) : assert(credencials != null, 'Credencials must be provide');

  Map<String, dynamic> toMap() {
    return {
      'appearance': appearance?.toMap(),
      'flowConfiguration': flowConfiguration?.toMap(),
      'mode': mode?.toMap(),
      'language': language?.toMap(),
      'credencials': credencials?.toMap(),
    };
  }
}

class OndataCredencials {
  final String username;
  final String password;
  final String accessToken;
  OndataCredencials({
    this.username,
    this.password,
    this.accessToken,
  }) : assert(
            ((username != null && password != null) && accessToken == null) ||
                ((username == null && password == null) && accessToken != null),
            'Use or username and password or accessToken');

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'password': password,
      'accessToken': accessToken,
    };
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
  OndatoFlowConfiguration({
    this.showSplashScreen = true,
    this.showStartScreen = true,
    this.showConsentScreen = true,
    this.showSelfieAndDocumentScreen = true,
    this.showSuccessWindow = true,
    this.ignoreLivenessErrors = false,
    this.ignoreVerificationErrors = false,
    this.recordProcess = true,
  });

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
    };
  }

  factory OndatoFlowConfiguration.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

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

class OndatoAppearance {
  /// Logo image that can be shown in the splash screen
  Uint8List logoImage;

  /// background color of the `ProgressBarView` which guides the user through the flow
  Color progressColor;

  /// background color of the primary action buttons
  Color buttonColor;

  /// background color of the primary action buttons text
  Color buttonTextColor;

  /// background color of the error message background
  Color errorColor;

  /// background color of the error message text color
  Color errorTextColor;

  /// regular text font
  String regularFontName;

  /// medium text font
  String mediumFontName;

  OndatoAppearance({
    this.logoImage,
    this.progressColor,
    this.buttonColor,
    this.buttonTextColor,
    this.errorColor,
    this.errorTextColor,
    this.regularFontName,
    this.mediumFontName,
  });

  /// appearance of header, body, acceptButton, declineButton in consent screen
  //var consentWindow;

  Map<String, dynamic> toMap() {
    return {
      'logoImage': logoImage,
      'progressColor': progressColor?.value,
      'buttonColor': buttonColor?.value,
      'buttonTextColor': buttonTextColor?.value,
      'errorColor': errorColor?.value,
      'errorTextColor': errorTextColor?.value,
      'regularFontName': regularFontName,
      'mediumFontName': mediumFontName,
    };
  }
}
