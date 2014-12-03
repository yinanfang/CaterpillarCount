//
//  GCAppViewModel.h
//  CaterpillarCount
//
//  Created by Golden Compass on 10/14/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import <Foundation/Foundation.h>
@class GCAppData, GCUserData, GCUserData02, GCUser, GCSurvey, GCOrder;
/**
 *  View model that store all data for the app
 */
@interface GCAppViewModel : NSObject

/**
 *  App Data
 */
@property GCAppData *appData;
@property GCUserData *currentUserData;
@property NSMutableArray *currentUnsavedOrders;

/**
 *  Accessor for Singleton class
 *
 *  @return Return an pointer to the class object
 */
+ (GCAppViewModel *)sharedInstance;

#pragma mark - App data
/**
 *  Get app data from the disk
 */
+ (void)getAppDataFromNSUserDefaultsAndUpdateViewModel;
/**
 *  Save data to the disk
 */
+ (void)saveAppDataToNSUserDefaults;

#pragma mark - User data
/**
 *  Update user info
 *
 *  @param userDictionary User info in NSDictionary
 */
+ (void)updateUserWithGCUser:(NSDictionary *)userDictionary;
/**
 *  Add an new order
 *
 *  @param orderDictionary order in NSDictionary
 */
+ (void)addCurrentunsavedOrdersWithDictionary:(NSDictionary *)orderDictionary;
/**
 *  Add survey data
 *
 *  @param survey survey data in GCSurvey
 */
+ (void)addSurveyData:(GCSurvey *)survey;

#pragma mark - Log In
/**
 *  Login with credential
 *
 *  @param credential credential in NSDictionary
 *  @param completion Completion block
 */
+ (void)loginWithCredential:(NSDictionary *)credential completion:(void (^)(BOOL succeeded))completion;
/**
 *  Enter main container view controller
 *
 *  @param controller Pointer to the parent controller
 */
+ (void)enterMainContainerViewController:(UIViewController *)controller;

@end



