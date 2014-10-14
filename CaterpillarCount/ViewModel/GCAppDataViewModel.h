//
//  GCAppDataViewModel.h
//  CaterpillarCount
//
//  Created by Golden Compass on 10/14/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import <Foundation/Foundation.h>
@class GCAppData, GCUser, GCSurvey, GCOrder;

@interface GCAppDataViewModel : NSObject

// App Data
@property GCAppDataViewModel *store;
@property GCAppData *appData;

// Accessor for Singleton class
+ (GCAppDataViewModel *)sharedInstance;

+ (GCAppData *)getAppData;
+ (void)updateUserWithGCUser:(NSDictionary *)userDictionary;

@end



