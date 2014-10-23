//
//  GCStore.h
//  CaterpillarCount
//
//  Created by Golden Compass on 10/12/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GCStore : NSObject

// Accessor for Singleton class
+ (GCStore *)sharedInstance;

// Store Info
@property NSMutableArray *temperatureRanges;
@property NSMutableArray *circles;
@property NSMutableArray *surveyStrings;
@property NSMutableArray *herbivory;
@property NSMutableArray *arthropodOrder;

@end
