#include "AppDelegate.h"
#include "GeneratedPluginRegistrant.h"
#import <GoogleMaps/GoogleMaps.h> // Add this line

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [GMSServices provideAPIKey:@"AIzaSyAneuo8D6mL2CRNUu5u2E4S3FxDHmob1ZU"]; // Replace with API key
  [GeneratedPluginRegistrant registerWithRegistry:self];
  // Override point for customization after application launch.
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

@end
