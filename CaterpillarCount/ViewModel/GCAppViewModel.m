//
//  GCAppDataViewModel.m
//  CaterpillarCount
//
//  Created by Golden Compass on 10/14/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import "GCAppViewModel.h"

@implementation GCAppViewModel

#pragma mark - Singleton Class
+ (GCAppViewModel *)sharedInstance
{
    static GCAppViewModel *shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[self alloc] init];
//        NSError *mantleError = nil;
//        shareInstance.appData = [[GCAppData alloc] init];
//        DDLogVerbose([shareInstance.appData description]);
//        if (mantleError) {
//            DDLogWarn(@"Cannot generate Mantle model!!! %@", [mantleError description]);
//        }
        DDLogVerbose(@"Initialized GCAppViewModel share instance. Current value: %@", [shareInstance description]);
    });
    return shareInstance;
}

- (id)init
{
    DDLogVerbose(@"Initializing GCAppDataViewModel...");
    self = [super init];
    if (self) {
        // Initialize values
        
        
    }
    return self;
}

#pragma mark - App data
+ (void)getAppDataFromNSUserDefaultsAndUpdateViewModel
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *appData_encoded = [defaults objectForKey:NSUserDefaultsKeyForAppData];
    GCAppViewModel *appViewModel = [GCAppViewModel sharedInstance];
    if (appData_encoded) {
        GCAppData *appData_decoded = [NSKeyedUnarchiver unarchiveObjectWithData:appData_encoded];
        appViewModel.appData = appData_decoded;
        DDLogVerbose(@"Finished updating GCAppViewModel. Current value: %@", [appViewModel.appData description]);
    } else {
        DDLogVerbose(@"There's not appData. Need to set up for the first time...");
        appViewModel.appData = [[GCAppData alloc] init];
        NSData *appData_encoded = [NSKeyedArchiver archivedDataWithRootObject:appViewModel.appData];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:appData_encoded forKey:NSUserDefaultsKeyForAppData];
        [defaults synchronize];
        DDLogVerbose(@"Finished setup of GCAppViewModel. Current value: %@", [appViewModel.appData description]);
    }
}








+ (GCAppData *)getAppDataFromMemory
{
    GCAppViewModel *appViewModel = [GCAppViewModel sharedInstance];
    return appViewModel.appData;
}

+ (GCAppData *)getAppDataFromNSUserDefaults
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *user_encoded = [defaults objectForKey:NSUserDefaultsKeyForAppData];
    
    GCAppViewModel *viewModel = [GCAppViewModel sharedInstance];
    return viewModel.appData;
}

#pragma mark - User data
+ (void)updateUserWithGCUser:(NSDictionary *)userDictionary
{
    GCAppViewModel *viewModel = [GCAppViewModel sharedInstance];
    
    // Init GCUser
    NSError *mantleError = nil;
    GCUser *user = [MTLJSONAdapter modelOfClass:[GCUser class] fromJSONDictionary:userDictionary error:&mantleError];
    DDLogVerbose([user description]);
    if (mantleError) {
        DDLogWarn(@"Cannot generate GCUser model!!!");
    }
    
    // Update Current User in View Model
    viewModel.userData.user = user;
    DDLogVerbose(@"Current App data is: %@", [GCAppViewModel getAppDataFromMemory]);
    DDLogVerbose(@"Current JSON serialization: %@", [MTLJSONAdapter JSONDictionaryFromModel:[GCAppViewModel getAppDataFromMemory]]);
    
    // Update Current User in NSUserDefaults
    NSData *user_encoded = [NSKeyedArchiver archivedDataWithRootObject:user];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:user_encoded forKey:NSUserDefaultsKeyForAppData];
    [defaults synchronize];
    
    DDLogVerbose(@"Updated User object in View Model and NSUserDefaults");
}





@end


