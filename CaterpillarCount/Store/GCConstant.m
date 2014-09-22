//
//  GCConstant.m
//  CaterpillarCount
//
//  Created by Golden Compass on 9/21/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import "GCConstant.h"

@implementation GCConstant

#pragma mark - Gesture Recognizer
CGFloat const SWIPE_VELOCITY_THRESHOLD = 0.278f; // TODO: it's weird. Simulator require >.5 to be a swipe

#pragma mark - Others
NSString *const HasShownTour = @"HasShownTour";


+ (GCConstant *)sharedInstance
{
    static GCConstant *shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[self alloc] init];
    });
    return shareInstance;
}

- (id)init
{
    DDLogVerbose(@"Initializing Constant...");
    self = [super init];
    if (self) {
        // Set Constants
        // PNGTypeAndSuffix
        if (IS_IPHONE4S) {
            self.PNGTypeAndSuffix = @"@2x.png";
        } else if (IS_IPHONE5S) {
            self.PNGTypeAndSuffix = @"@R4.png";
        }
        
    }
    return self;
}

@end
