//
//  GCStore.h
//  CaterpillarCount
//
//  Created by Golden Compass on 10/12/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import <Foundation/Foundation.h>
@class GCAppData;
@class GCUser;

@interface GCStore : NSObject

// App Data
@property GCStore *store;
@property GCAppData *appData;

// Accessor for Singleton class
+ (GCStore *)sharedInstance;

+ (GCAppData *)getAppData;
+ (void)updateUserWithGCUser:(GCUser *)user;


@end
