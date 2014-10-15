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
        self.appData = [[GCAppData alloc] init];
        self.userData = [[GCUserData alloc] init];
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
        DDLogVerbose(@"Updating app data...");
        GCAppData *appData_decoded = [NSKeyedUnarchiver unarchiveObjectWithData:appData_encoded];
        appViewModel.appData = appData_decoded;
//        appViewModel.userData = appViewModel.appData.allUserData[appViewModel.appData.lastUserID];
    } else {
        DDLogVerbose(@"There's not appData. Need to set up for the first time...");
        NSData *appData_encoded = [NSKeyedArchiver archivedDataWithRootObject:appViewModel.appData];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:appData_encoded forKey:NSUserDefaultsKeyForAppData];
        [defaults synchronize];
    }
    DDLogVerbose(@"Finished setup/update GCAppViewModel");
    DDLogVerbose(@"appData Current value: %@", [MTLJSONAdapter JSONDictionaryFromModel:appViewModel.appData]);
    DDLogVerbose(@"userData Current value: %@", [MTLJSONAdapter JSONDictionaryFromModel:appViewModel.userData]);
}

+ (void)saveAppDataToNSUserDefaults
{
    DDLogVerbose(@"Saveing app data...");
    GCAppViewModel *appViewModel = [GCAppViewModel sharedInstance];
    [appViewModel.appData.allUserData setObject:appViewModel.userData forKey:appViewModel.appData.lastUserID];
    DDLogVerbose(@"Current value: %@", [MTLJSONAdapter JSONDictionaryFromModel:appViewModel.appData]);
    NSData *appData_encoded = [NSKeyedArchiver archivedDataWithRootObject:appViewModel.appData];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:appData_encoded forKey:NSUserDefaultsKeyForAppData];
    [defaults synchronize];
}

//+ (GCAppData *)getAppDataFromMemory
//{
//    GCAppViewModel *appViewModel = [GCAppViewModel sharedInstance];
//    return appViewModel.appData;
//}
//
//+ (GCAppData *)getAppDataFromNSUserDefaults
//{
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    NSData *user_encoded = [defaults objectForKey:NSUserDefaultsKeyForAppData];
//    
//    GCAppViewModel *viewModel = [GCAppViewModel sharedInstance];
//    return viewModel.appData;
//}

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
    viewModel.appData.didLogedIn = YES;
    viewModel.appData.lastUserID = user.userID;
    DDLogVerbose(@"Current App data is: %@", viewModel.appData);
//    DDLogVerbose(@"Current user data is: %@", viewModel.userData);
    DDLogVerbose(@"Current user data JSON serialization: %@", [MTLJSONAdapter JSONDictionaryFromModel:viewModel.userData]);
}





@end


