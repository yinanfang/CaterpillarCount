//
//  GCOrder.h
//  CaterpillarCount
//
//  Created by Golden Compass on 10/10/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  Data model for order
 */
@interface GCOrder : MTLModel <MTLJSONSerializing>

/**
 *  Order ID
 */
@property NSString *orderID;


/**
 *  Order Name
 */
@property NSString *orderName;
/**
 *  Length
 */
@property NSNumber *length;
/**
 *  Count
 */
@property NSNumber *count;
/**
 *  Note
 */
@property NSString *note;
/**
 *  URL for order photo in local disk
 */
@property NSString *orderPhotoLocalURL;
//@property UIImageView *orderPhotoView;


@end
