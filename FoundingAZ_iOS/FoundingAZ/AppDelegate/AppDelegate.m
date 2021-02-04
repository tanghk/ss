//
//  AppDelegate.m
//  FoundingAZ
//
//  Created by 创业酵母 on 2021/01/21.
//

#import "AppDelegate.h"
#import "AppDelegate+Services.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self XZ_initWithWindow];
    
    [self XZ_initWithKeyboardService];
    [self XZ_initWithThridService];
    
    [self XZ_initWithMainUI];
    
    // Override point for customization after application launch.
    return YES;
}

@end
