//
//  GCUser.h
//  CaterpillarCount
//
//  Created by Golden Compass on 10/8/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GCUser : MTLModel <MTLJSONSerializing>

@property NSNumber *userID;
@property NSString *email;
@property NSString *userName;
@property BOOL isValidUser;
@property BOOL isActive;


@end
