//
//  GCAppViewModel.h
//  CaterpillarCount
//
//  Created by Golden Compass on 10/14/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import <Foundation/Foundation.h>
@class GCAppData, GCUserData, GCUserData02, GCUser, GCSurvey, GCOrder;

@interface GCAppViewModel : NSObject

// App Data
@property GCAppData *appData;
@property GCUserData *currentUserData;
@property NSMutableArray *currentUnsavedOrders;
//@property GCUserData02 *userData;

// Accessor for Singleton class
+ (GCAppViewModel *)sharedInstance;

#pragma mark - App data
+ (void)getAppDataFromNSUserDefaultsAndUpdateViewModel;
+ (void)saveAppDataToNSUserDefaults;

#pragma mark - User data
+ (void)updateUserWithGCUser:(NSDictionary *)userDictionary;
+ (void)addCurrentunsavedOrdersWithDictionary:(NSDictionary *)orderDictionary;
+ (void)addSurveyData:(GCSurvey *)survey;

#pragma mark - Log In
+ (void)loginWithCredential:(NSDictionary *)credential completion:(void (^)(BOOL succeeded))completion;
+ (void)enterMainContainerViewController:(UIViewController *)controller;

@end



