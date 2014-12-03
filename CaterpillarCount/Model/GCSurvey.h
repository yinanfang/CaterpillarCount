//
//  GCSurvey.h
//  CaterpillarCount
//
//  Created by Golden Compass on 10/10/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GCSurvey : MTLModel <MTLJSONSerializing>

/**
 *  User ID
 */
@property NSNumber *userID;
/**
 *  Survey ID
 */
@property NSNumber *surveyID;

/**
 *  Site Name
 */
@property NSString *siteName;
/**
 *  Circle Number
 */
@property NSNumber *circleNumber;
/**
 *  Survey String
 */
@property NSString *surveyString;
/**
 *  Submission time
 */
@property NSDate *timeSubmitted;
/**
 *  Temperature
 */
@property NSString *temperature;
/**
 *  Notes for the site
 */
@property NSString *siteNotes;


/**
 *  Order array
 */
@property NSMutableArray *ordersArray;

/**
 *  Plant species
 */
@property NSString *plantSpecies;
/**
 *  Herbivory
 */
@property NSNumber *herbivory;
/**
 *  URL for plant photo in local
 */
@property NSString *plantPhotoLocalURL;
/**
 *  URL for plant photo in server
 */
@property NSString *plantPhotoServerURL;
//@property UIImageView *plantPhotoView;

@end
