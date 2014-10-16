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
        self.currentUserData = [[GCUserData alloc] init];
        self.currentUnsavedOrders = [[NSMutableArray alloc] init];
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
        appViewModel.currentUserData = appViewModel.appData.allUserData[appViewModel.appData.lastUserID];
    } else {
        DDLogVerbose(@"There's not appData...");
//        NSData *appData_encoded = [NSKeyedArchiver archivedDataWithRootObject:appViewModel.appData];
//        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//        [defaults setObject:appData_encoded forKey:NSUserDefaultsKeyForAppData];
//        [defaults synchronize];
    }
    DDLogVerbose(@"Finished updating GCAppViewModel");
    DDLogVerbose(@"appData Current value: %@", [MTLJSONAdapter JSONDictionaryFromModel:appViewModel.appData]); //appViewModel.appData);//
    DDLogVerbose(@"currentUserData Current value: %@", [MTLJSONAdapter JSONDictionaryFromModel:appViewModel.currentUserData]); // appViewModel.currentUserData);//
}

+ (void)saveAppDataToNSUserDefaults
{
    DDLogVerbose(@"Saveing app data...");
    GCAppViewModel *appViewModel = [GCAppViewModel sharedInstance];
//    [appViewModel.appData.allUserData setObject:appViewModel.userData forKey:appViewModel.appData.lastUserID];
    appViewModel.appData.allUserData[appViewModel.appData.lastUserID] = appViewModel.currentUserData;
//    // Init GCUser
//    NSError *mantleError = nil;
//    GCUserData *userData = [MTLJSONAdapter modelOfClass:[GCUser class] fromJSONDictionary:userDictionary error:&mantleError];
//    DDLogVerbose([user description]);
//    if (mantleError) {
//        DDLogWarn(@"Cannot generate GCUser model!!!");
//    }
    DDLogVerbose(@"App Data Current value: %@", [appViewModel.appData description]);
    DDLogVerbose(@"App Data Current valuein JSON: %@", [MTLJSONAdapter JSONDictionaryFromModel:appViewModel.appData]);
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
    GCUser *user = [MTLJSONAdapter modelOfClass:[GCUser class] fromJSONDictionary:userDictionary error:&mantleError];
    DDLogVerbose([user description]);
    if (mantleError) {
        DDLogWarn(@"Cannot generate GCUser model!!!");
    }
    
    NSLog(@"userData02: %@", [viewModel.currentUserData description]);
    viewModel.currentUserData.user = user;
    viewModel.currentUserData = viewModel.currentUserData;
    
    viewModel.appData.didLogedIn = YES;
    viewModel.appData.lastUserID = user.userID;
    DDLogVerbose(@"Current App data is: %@", viewModel.appData);
    DDLogVerbose(@"Current user data JSON serialization: %@", [MTLJSONAdapter JSONDictionaryFromModel:viewModel.currentUserData]);
    //    DDLogVerbose(@"Current user data is: %@", viewModel.userData);

}

+ (void)addCurrentunsavedOrdersWithDictionary:(NSDictionary *)orderDictionary
{
    GCAppViewModel *viewModel = [GCAppViewModel sharedInstance];
    GCOrder *order = [GCAppAPI getMantleModelWithDictionary:orderDictionary modelClass:[GCOrder class]];
    NSLog(@"before adding: %@",viewModel.currentUnsavedOrders);
    [viewModel.currentUnsavedOrders addObject:order];
    DDLogVerbose(@"Added a new order. currentUnsavedOrders: %@", viewModel.currentUnsavedOrders);
}




@end


