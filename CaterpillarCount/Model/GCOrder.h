//
//  GCOrder.h
//  CaterpillarCount
//
//  Created by Golden Compass on 10/10/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GCOrder : MTLModel <MTLJSONSerializing>

@property NSString *orderID;

@property NSString *orderName;
@property NSNumber *length;
@property NSNumber *count;
@property NSString *note;
@property NSString *orderPhotoLocalURL;
//@property UIImageView *orderPhotoView;


@end
