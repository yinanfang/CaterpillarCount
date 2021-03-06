//
//  GCAppDelegate.m
//  CaterpillarCount
//
//  Created by Golden Compass on 9/21/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import "GCAppDelegate.h"
#import "GCSurveyViewController.h"
#import "GCCoverViewController.h"

@interface GCAppDelegate ()

@end

@implementation GCAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // App setup process
    [GCAppSetup setupApplicationWithProductionMode:YES];
    
    // Allocate window
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor clearColor];
    
    // Update view model
    [GCAppViewModel getAppDataFromNSUserDefaultsAndUpdateViewModel];
    
    // Set global tint color
    [self.window setTintColor:[UIColor whiteColor]];
    
    // Determine next page
    GCCoverViewController *coverViewController = [[GCCoverViewController alloc] init];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:coverViewController];
    if ([GCAppViewModel sharedInstance].appData.didLogedIn) {
        DDLogVerbose(@"Has Logged In already. Go to survey...");
        GCSurveyViewController *surveyViewController = [[GCSurveyViewController alloc] init];
        [navigationController pushViewController:surveyViewController animated:NO];
    } else {
        DDLogVerbose(@"Need to log in or register...");
    }
    
    // Set rootViewController
    self.window.rootViewController = navigationController;
    [self.window makeKeyAndVisible];

    return YES;
}

// Overwrite setting in the Summary/Info.plist
- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    return UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskLandscapeLeft;
}

// Others
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    DDLogVerbose(@"applicationDidEnterBackground");
//    [GCAppViewModel saveAppDataToNSUserDefaults];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    DDLogVerbose(@"applicationWillTerminate");
    [GCAppViewModel saveAppDataToNSUserDefaults];
}

@end

// Add category to help UINavigationController to determine rotation
@implementation UINavigationController (OrientationSettings_IOS6)
-(BOOL)shouldAutorotate {
    return [[self.viewControllers lastObject] shouldAutorotate];
}

-(NSUInteger)supportedInterfaceOrientations {
    return [[self.viewControllers lastObject] supportedInterfaceOrientations];
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return [[self.viewControllers lastObject] preferredInterfaceOrientationForPresentation];
}
@end