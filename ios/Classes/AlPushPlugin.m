#import "AlPushPlugin.h"
#if __has_include(<al_push_plugin/al_push_plugin-Swift.h>)
#import <al_push_plugin/al_push_plugin-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "al_push_plugin-Swift.h"
#endif

@implementation AlPushPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftAlPushPlugin registerWithRegistrar:registrar];
}
@end
