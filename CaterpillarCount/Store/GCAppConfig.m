//
//  GCAppConfig.m
//  CaterpillarCount
//
//  Created by Golden Compass on 9/21/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import "GCAppConfig.h"

@implementation GCAppConfig

#pragma mark - Domain
// Change the domain for server here
NSString *const DevelopmentDomain = @"https://secure28.webhostinghub.com";
NSString *const ProductionDomain = @"https://secure28.webhostinghub.com";
NSString *const URIPathToUsersPHP = @"/~pocket14/forsyth.im/caterpillars/users.php";
NSString *const URIPathToSubmissionPHP = @"/~pocket14/forsyth.im/caterpillars/submission.php";

#pragma mark - NSUserDefaults values
NSString *const NSUserDefaultsKeyForDidShownTour = @"didShownTour";
NSString *const NSUserDefaultsKeyForDidRunAppBefore = @"didRunAppBefore";
NSString *const NSUserDefaultsKeyForAppData = @"AppData";

+ (GCAppConfig *)sharedInstance
{
    static GCAppConfig *shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[self alloc] init];
    });
    return shareInstance;
}

- (id)init
{
    DDLogVerbose(@"Initializing App Configuration...");
    self = [super init];
    if (self) {
        // Initialize values
        
        // General
        self.PixelAdjustForHorizontalGap = 1.0;

        
        
        
    }
    return self;
}








@end
