#import "AltbeaconPlugin.h"
#if __has_include(<altbeacon/altbeacon-Swift.h>)
#import <altbeacon/altbeacon-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "altbeacon-Swift.h"
#endif

@implementation AltbeaconPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftAltbeaconPlugin registerWithRegistrar:registrar];
}
@end
