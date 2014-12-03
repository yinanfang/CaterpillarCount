//
//  GCAppData.h
//  CaterpillarCount
//
//  Created by Golden Compass on 10/12/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  Data Model for the App Data
 */
@interface GCAppData : MTLModel <MTLJSONSerializing>

/**
 *  Log in indicator
 */
@property BOOL didLogedIn;
/**
 *  Last user ID
 */
@property NSNumber *lastUserID;
/**
 *  All user data
 */
@property NSMutableDictionary *allUserData;

@end
