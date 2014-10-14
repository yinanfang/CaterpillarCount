//
//  GCAppAPI.h
//  CaterpillarCount
//
//  Created by Golden Compass on 9/21/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import <Foundation/Foundation.h>

// AFNetworking
#import <AFNetworking.h>
// CocoaLumberjack
#import <CocoaLumberjack/CocoaLumberjack.h>
#import <DDTTYLogger.h>
#import <DDASLLogger.h>
#import <DDFileLogger.h>
#import "GCCustomLogFormatters.h"
// facebook-ios-sdk
#import <FacebookSDK/FacebookSDK.h>
// FlatUIKit
#import <FlatUIKit/FlatUIKit.h>
// LBBlurredImage
#import <FXBlurView/FXBlurView.h>
// Mantle
#import <Mantle/Mantle.h>
// Masonry
#import <Masonry.h>
// MBProgressHUD
#import "MBProgressHUD.h"
// TSMessage
#import <TSMessages/TSMessage.h>
// POP
#import <pop/POP.h>
// ReactiveCocoa
#import <ReactiveCocoa/ReactiveCocoa.h>
// Shimmer
#import <Shimmer/FBShimmeringView.h>
// Tweaks
#import <Tweaks/FBTweak.h>

// App Import
#import "GCAppSetup.h"
#import "GCAppConfig.h"
#import "GCConstant.h"
#import "GCNetwork.h"
#import "GCStore.h"
#import "GCAppDataViewModel.h"

@interface GCAppAPI : NSObject

// Accessor for Singleton class
+ (GCAppAPI *)sharedInstance;

#pragma mark - Basic Utilities
+ (NSString *)getCurrentDomain;
+ (UIColor *)getColorWithRGBAinHex:(NSUInteger)color;
+ (void)setHasShownTour:(BOOL)mode;
+ (UIImageView *)getFullScreenImageView:(NSString *)name;
+ (CGPoint)getCGPointZeroWithStatusbarAndNavigationBar:(UIViewController *)controller;
+ (CGRect)getScreenBoundsDependOnOrientation;

#pragma mark - Network API Calls
















@end