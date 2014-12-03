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

// Data Model
#import "GCAppData.h"
#import "GCUserData.h"
#import "GCUser.h"
#import "GCSurvey.h"
#import "GCOrder.h"

// View Model
#import "GCAppViewModel.h"

// App Import
#import "GCAppSetup.h"
#import "GCUserData.h"
#import "GCAppConfig.h"
#import "GCConstant.h"
#import "GCNetwork.h"
#import "GCStore.h"

/**
 *  App API that include all the most used header files
 */
@interface GCAppAPI : NSObject

/**
 *  Accessor for Singleton class
 *
 *  @return Returns an shared instance
 */
+ (GCAppAPI *)sharedInstance;

#pragma mark - Basic Utilities
/**
 *  Get current Domain
 *
 *  @return Return the domain
 */
+ (NSString *)getCurrentDomain;
/**
 *  Get UI Color
 *
 *  @param color color code in hex
 *
 *  @return Return UIColor
 */
+ (UIColor *)getColorWithRGBAinHex:(NSUInteger)color;
/**
 *  Check if the tour is shown
 *
 *  @param mode BOOL
 */
+ (void)setHasShownTour:(BOOL)mode;
/**
 *  Check if the app is run before
 *
 *  @return BOOL
 */
+ (BOOL)didRunAppBefore;
/**
 *  Get full screen image view
 */
+ (UIImageView *)getFullScreenImageView:(NSString *)name;
+ (CGPoint)getCGPointZeroWithStatusbarAndNavigationBar:(UIViewController *)controller;
+ (CGRect)getScreenBoundsDependOnOrientation;

#pragma mark - Mantle
/**
 *  Get Mantle data model
 *
 *  @param dictionary Data in NSDictionry
 *  @param modelClass Model class
 *
 *  @return Return data in Mantle model
 */
+ (id)getMantleModelWithDictionary:(NSDictionary *)dictionary modelClass:(Class)modelClass;















@end