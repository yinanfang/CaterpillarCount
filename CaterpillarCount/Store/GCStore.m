//
//  GCStore.m
//  CaterpillarCount
//
//  Created by Golden Compass on 10/12/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import "GCStore.h"

@implementation GCStore

#pragma mark - Singleton Class
+ (GCStore *)sharedInstance
{
    static GCStore *shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[self alloc] init];
    });
    return shareInstance;
    
}

- (id)init
{
    DDLogVerbose(@"Initializing GCStore...");
    self = [super init];
    if (self) {
        // Initialize values
        self.temperatureRanges = [GCStore initTemperatureRanges];
        self.circles = [GCStore initCircles];
        self.surveyStrings = [GCStore initSurveyStrings];
        self.arthropodOrder = [GCStore initArthropodOrder];
    }
    return self;
}

+ (NSMutableArray *)initTemperatureRanges
{
    NSMutableArray *tempArray = [NSMutableArray new];
    tempArray = [@
                 [@"Below 40F",
                  @"40F - 50F",
                  @"50F - 60F",
                  @"60F - 70F",
                  @"70F - 80F",
                  @"80F - 90F",
                  @"90F - 100F",
                  @"Above 100F"]
                 mutableCopy];
    return tempArray;
}

+ (NSMutableArray *)initCircles
{
    NSMutableArray *circleArray = [NSMutableArray new];
    circleArray = [@
                 [@"1",
                  @"2",
                  @"3",
                  @"4",
                  @"5",
                  @"6",
                  @"7",
                  @"8"]
                 mutableCopy];
    return circleArray;
}

+ (NSMutableArray *)initSurveyStrings
{
    NSMutableArray *surveyStringArray = [NSMutableArray new];
    surveyStringArray = [@
                  [@"1A",
                   @"1B",
                   @"1C",
                   @"1D",
                   @"1E",
                   @"2A",
                   @"2B",
                   @"2C",
                   @"2D",
                   @"2E",
                   @"3A",
                   @"3B",
                   @"3C",
                   @"3D",
                   @"3E",
                   @"4A",
                   @"4B",
                   @"4C",
                   @"4D",
                   @"4E",
                   @"5A",
                   @"5B",
                   @"5C",
                   @"5D",
                   @"5E",
                   @"6A",
                   @"6B",
                   @"6C",
                   @"6D",
                   @"6E",
                   @"7A",
                   @"7B",
                   @"7C",
                   @"7D",
                   @"7E",
                   @"8A",
                   @"8B",
                   @"8C",
                   @"8D",
                   @"8E",
                   ]
                  mutableCopy];
    return surveyStringArray;
}

+ (NSMutableArray *)initArthropodOrder
{
    NSMutableArray *orderArray = [NSMutableArray new];
    orderArray = [@
                  [@"Ants (Formicidae)",
                   @"Aphids and Psyllids",
                   @"Bees and Wasps (Hymenoptera, excluding ants)",
                   @"Beetles (Coleoptera)",
                   @"Caterpillars (Lepidoptera larvae)",
                   @"Daddy longlegs (Opiliones)",
                   @"Flies (Diptera)",
                   @"Grasshoppers, Crickets (Orthoptera)",
                   @"Leaf hoppers and True Bugs (Hemiptera, excluding aphids)",
                   @"Moths, Butterflies (Lepidoptera)",
                   @"Spiders (Araneae; not daddy longlegs!)",
                   @"Other (describe in Notes)",
                   @"UNIDENTIFIED",
                   @"NONE",
                   ]
                  mutableCopy];
    return orderArray;
}

@end
