//
//  GCStore.h
//  CaterpillarCount
//
//  Created by Golden Compass on 10/12/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  Variable that stays the same through out the app
 */
@interface GCStore : NSObject

/**
 *  Accessor for Singleton class
 */
+ (GCStore *)sharedInstance;

/**
 *  Temperature Ranges
 */
@property NSMutableArray *temperatureRanges;
/**
 *  Circles
 */
@property NSMutableArray *circles;
/**
 *  Survey Strings
 */
@property NSMutableArray *surveyStrings;
/**
 *  Herbivory
 */
@property NSMutableArray *herbivory;
/**
 *  Herbivory Views
 */
@property NSMutableArray *herbivoryViews;
/**
 *  Arthropod Order
 */
@property NSMutableArray *arthropodOrder;

@end
