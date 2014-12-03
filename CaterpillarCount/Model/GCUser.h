//
//  GCUser.h
//  CaterpillarCount
//
//  Created by Golden Compass on 10/8/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  Data Model for the user
 */
@interface GCUser : MTLModel <MTLJSONSerializing>

/**
 *  User ID
 */
@property NSNumber *userID;
/**
 *  Email Address
 */
@property NSString *email;
/**
 *  User Name
 */
@property NSString *userName;
/**
 *  Valid User indicator
 */
@property BOOL isValidUser;
/**
 *  Active indicator
 */
@property BOOL isActive;


@end
