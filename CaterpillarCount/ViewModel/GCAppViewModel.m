//
//  GCAppDataViewModel.m
//  CaterpillarCount
//
//  Created by Golden Compass on 10/14/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import "GCAppViewModel.h"
#import "GCUserData02.h"

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
        NSLog(@"running");
        DDLogVerbose(@"Updating app data...");
        GCAppData *appData_decoded = [NSKeyedUnarchiver unarchiveObjectWithData:appData_encoded];
        appViewModel.appData = appData_decoded;
        // Convert them back to GCUserData object
//        for(id key in appViewModel.appData.allUserData) {
//            NSError *mantleError = nil;
//            GCUserData *userData = [MTLJSONAdapter modelOfClass:[GCUserData class] fromJSONDictionary:appViewModel.appData.allUserData[key] error:&mantleError];
//            if (mantleError) {
//                NSLog(@"Cannot generate GCUser model!!!");
//            }
//            appViewModel.appData.allUserData[key] = userData;
//        }
//        GCUserData *currentUserData = appViewModel.appData.allUserData[appViewModel.appData.lastUserID];
//        NSLog(@"key-value: %@", currentUserData);
        
        appViewModel.userData = appViewModel.appData.allUserData[appViewModel.appData.lastUserID];
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
//    [appViewModel.appData.allUserData setObject:appViewModel.userData forKey:appViewModel.appData.lastUserID];
    appViewModel.appData.allUserData[appViewModel.appData.lastUserID] = appViewModel.userData;
//    // Init GCUser
//    NSError *mantleError = nil;
//    GCUserData *userData = [MTLJSONAdapter modelOfClass:[GCUser class] fromJSONDictionary:userDictionary error:&mantleError];
//    DDLogVerbose([user description]);
//    if (mantleError) {
//        DDLogWarn(@"Cannot generate GCUser model!!!");
//    }
    DDLogVerbose(@"Current value:");

    DDLogVerbose(@"Current value: %@", [MTLJSONAdapter JSONDictionaryFromModel:appViewModel.appData]);
    NSData *appData_encoded = [NSKeyedArchiver archivedDataWithRootObject:appViewModel.appData];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:appData_encoded forKey:NSUserDefaultsKeyForAppData];
    [defaults synchronize];
}

#pragma mark - User data
+ (void)updateUserWithGCUser:(NSDictionary *)userDictionary
{
    GCAppViewModel *viewModel = [GCAppViewModel sharedInstance];
    
    // Init GCUser
    NSError *mantleError = nil;
    GCUser *user02 = [[GCUser alloc] init];
    GCUser *user = [MTLJSONAdapter modelOfClass:[GCUser class] fromJSONDictionary:userDictionary error:&mantleError];
    DDLogVerbose([user description]);
    if (mantleError) {
        DDLogWarn(@"Cannot generate GCUser model!!!");
    }
    
    // Update Current User in View Model
//    NSDictionary *userDataDic = [NSDictionary dictionaryWithObjectsAndKeys:user, @"user", [[NSArray alloc] init], @"surveys", nil];
//      GCUserData *userData = [MTLJSONAdapter modelOfClass:[GCUserData class] fromJSONDictionary:userDataDic error:&mantleError];
//    
//    viewModel.userData = userData;
    GCUserData02 *userdata02 = [[GCUserData02 alloc] init];
    GCUserData *LLuserData = [[GCUserData alloc] init];
//    userData.user = [user copy];
//    viewModel.userData = [userData copy];
    
    viewModel.appData.didLogedIn = YES;
    viewModel.appData.lastUserID = user.userID;
    DDLogVerbose(@"Current App data is: %@", viewModel.appData);
//    DDLogVerbose(@"Current user data is: %@", viewModel.userData);
    DDLogVerbose(@"Current user data JSON serialization: %@", [MTLJSONAdapter JSONDictionaryFromModel:viewModel.userData]);
}





@end


