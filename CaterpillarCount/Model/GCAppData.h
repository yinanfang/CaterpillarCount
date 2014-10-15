//
//  GCAppData.h
//  CaterpillarCount
//
//  Created by Golden Compass on 10/12/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GCAppData : MTLModel <MTLJSONSerializing>

@property BOOL didLogedIn;
@property NSNumber *previousUserID;
@property NSMutableDictionary *allUserData;

@end
