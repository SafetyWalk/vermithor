#include "AppDelegate.h"
#include "GeneratedPluginRegistrant.h"
#import <GoogleMaps/GoogleMaps.h> // Add this line

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [GMSServices provideAPIKey:@"PUT_THE_GOOGLE_MAPS_API_KEY"]; // Replace with API key
  [GeneratedPluginRegistrant registerWithRegistry:self];
  // Override point for customization after application launch.
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

@end
