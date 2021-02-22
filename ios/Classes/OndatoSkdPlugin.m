#import "OndatoSkdPlugin.h"
#if __has_include(<ondato_skd/ondato_skd-Swift.h>)
#import <ondato_skd/ondato_skd-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "ondato_skd-Swift.h"
#endif

@implementation OndatoSkdPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftOndatoSkdPlugin registerWithRegistrar:registrar];
}
@end
