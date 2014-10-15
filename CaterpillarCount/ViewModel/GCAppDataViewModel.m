//
//  GCAppDataViewModel.m
//  CaterpillarCount
//
//  Created by Golden Compass on 10/14/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import "GCAppDataViewModel.h"

// Data Model
#import "GCAppData.h"
#import "GCUser.h"
#import "GCSurvey.h"
#import "GCOrder.h"

@implementation GCAppDataViewModel

#pragma mark - Singleton Class
+ (GCAppDataViewModel *)sharedInstance
{
    static GCAppDataViewModel *shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[self alloc] init];
        NSError *mantleError = nil;
        shareInstance.appData = [[GCAppData alloc] init];
        DDLogVerbose([shareInstance.appData description]);
        if (mantleError) {
            DDLogWarn(@"Cannot generate Mantle model!!! %@", [mantleError description]);
        }
        DDLogVerbose(@"Initialized GCStore share instance");
        
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
+ (GCAppData *)getAppDataFromMemory
{
    GCAppDataViewModel *viewModel = [GCAppDataViewModel sharedInstance];
    return viewModel.appData;
}

+ (GCAppData *)getAppDataFromNSUserDefaults
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *user_encoded = [defaults objectForKey:NSUserDefaultsKeyForUserInfo];
    
    GCAppDataViewModel *viewModel = [GCAppDataViewModel sharedInstance];
    return viewModel.appData;
}

+ (void)updateUserWithGCUser:(NSDictionary *)userDictionary
{
    GCAppDataViewModel *viewModel = [GCAppDataViewModel sharedInstance];
    
    // Init GCUser
    NSError *mantleError = nil;
    GCUser *user = [MTLJSONAdapter modelOfClass:[GCUser class] fromJSONDictionary:userDictionary error:&mantleError];
    DDLogVerbose([user description]);
    if (mantleError) {
        DDLogWarn(@"Cannot generate GCUser model!!!");
    }
    
    // Update Current User in View Model
    viewModel.appData.user = user;
    DDLogVerbose(@"Current App data is: %@", [GCAppDataViewModel getAppDataFromMemory]);
    DDLogVerbose(@"Current JSON serialization: %@", [MTLJSONAdapter JSONDictionaryFromModel:[GCAppDataViewModel getAppDataFromMemory]]);
    
    // Update Current User in NSUserDefaults
    NSData *user_encoded = [NSKeyedArchiver archivedDataWithRootObject:user];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:user_encoded forKey:NSUserDefaultsKeyForUserInfo];
    [defaults synchronize];
    
    DDLogVerbose(@"Updated User object in View Model and NSUserDefaults");
}





@end


