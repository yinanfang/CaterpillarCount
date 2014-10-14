//
//  GCStore.m
//  CaterpillarCount
//
//  Created by Golden Compass on 10/12/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import "GCAppData.h"
#import "GCStore.h"
#import "GCUser.h"

@implementation GCStore

#pragma mark - Singleton Class
+ (GCStore *)sharedInstance
{
    static GCStore *shareInstance = nil;
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
    DDLogVerbose(@"Initializing GCAppUtility...");
    self = [super init];
    if (self) {
        // Initialize values
        
        
    }
    return self;
}

#pragma mark - App data
+ (GCAppData *)getAppData
{
    GCStore *store = [GCStore sharedInstance];
    return store.appData;
}

+ (void)updateUserWithGCUser:(GCUser *)user
{
    GCStore *store = [GCStore sharedInstance];
    store.appData.user = user;
}

@end
