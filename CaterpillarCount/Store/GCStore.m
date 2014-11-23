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
        self.herbivory = [GCStore initHerbivory];
        self.herbivoryViews = [GCStore initHerbivoryViews];
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
                  [@"A",
                   @"B",
                   @"C",
                   @"D",
                   @"E",
                   ]
                  mutableCopy];
    return surveyStringArray;
}

+ (NSMutableArray *)initHerbivory
{
    NSMutableArray *herbivoryArray = [NSMutableArray new];
    herbivoryArray = [@
                  [@"0 - No Damage",
                   @"1 - Minor, 0% to 5%",
                   @"2 - Light, 5% to 10%",
                   @"3 - Moderate, 10% to 25%",
                   @"4 - Heavy, greater than 25%",
                   ]
                  mutableCopy];
    return herbivoryArray;
}

+ (NSMutableArray *)initHerbivoryViews
{
    NSMutableArray *herbivoryArray = [NSMutableArray new];
    UIImageView *herbivory00 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"herbivory_0"]];
    UIImageView *herbivory05 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"herbivory_5"]];
    UIImageView *herbivory10 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"herbivory_10"]];
    UIImageView *herbivory25 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"herbivory_25"]];
    UIImageView *herbivory99 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"herbivory_max"]];
    CGFloat contentHeight = 70.0f;
    UIView *view0 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, contentHeight)];
    UILabel *label0 = [UILabel LabelSubTitleWithString:@"0 - None" align:NSTextAlignmentLeft];
    [view0 addSubview:label0];
    [view0 addSubview:herbivory00];
    [view0 addSubview:herbivory05];
    
    herbivoryArray = [@
                      [view0,
                       ]
                      mutableCopy];
    return herbivoryArray;
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
