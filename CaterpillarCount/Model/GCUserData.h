//
//  GCUserData.h
//  CaterpillarCount
//
//  Created by Golden Compass on 10/15/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import <Foundation/Foundation.h>
@class GCUser;
@class GCSurvey;

/**
 *  Data model for user data
 */
@interface GCUserData : MTLModel <MTLJSONSerializing>

/**
 *  User object
 */
@property GCUser *user;
/**
 *  Surveys
 */
@property NSMutableArray *surveys;
/**
 *  Sites
 */
@property NSMutableArray *sites;


@end