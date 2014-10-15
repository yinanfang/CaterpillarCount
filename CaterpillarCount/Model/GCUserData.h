//
//  GCUserData.h
//  CaterpillarCount
//
//  Created by Golden Compass on 10/14/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import <Foundation/Foundation.h>
@class GCUser;
@class GCSurvey;

@interface GCUserData : MTLModel <MTLJSONSerializing>

@property GCUser *user;
@property NSMutableArray *surveys;

@end




