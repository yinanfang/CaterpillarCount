//
//  GCSurvey.h
//  CaterpillarCount
//
//  Created by Golden Compass on 10/10/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GCSurvey : MTLModel <MTLJSONSerializing>

@property NSString *userID;
@property NSString *surveyID;

@property NSString *siteName;
@property NSNumber *circleNumber;
@property NSString *surveyString;
@property NSDate *timeSubmitted;
@property NSString *temperature;

@property NSMutableArray *ordersArray;

@property NSString *plantSpecies;
@property NSString *herbivory;
@property NSString *plantPhotoLocalURL;
//@property UIImageView *plantPhotoView;

@end
