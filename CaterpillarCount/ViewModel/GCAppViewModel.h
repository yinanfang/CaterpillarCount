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
@property (copy) GCUserData *userData;
//@property GCUserData02 *userData;

// Accessor for Singleton class
+ (GCAppViewModel *)sharedInstance;

#pragma mark - App data
+ (void)getAppDataFromNSUserDefaultsAndUpdateViewModel;
+ (void)saveAppDataToNSUserDefaults;

//+ (GCAppData *)getAppDataFromMemory;
//+ (GCAppData *)getAppDataFromNSUserDefaults;
+ (void)updateUserWithGCUser:(NSDictionary *)userDictionary;

@end


