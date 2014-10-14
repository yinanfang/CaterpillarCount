//
//  GCAppData.m
//  CaterpillarCount
//
//  Created by Golden Compass on 10/12/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import "GCAppData.h"
#import "GCUser.h"
#import "GCSurvey.h"


@implementation GCAppData

- (id)init
{
    DDLogVerbose(@"Initializing GCAppData...");
    self = [super init];
    if (self) {
        // Initialize values
        self.surveys = [[NSMutableArray alloc] init];
    }
    return self;
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"user": @"user",
             @"surveys": @"surveys",
             };
}

+ (NSValueTransformer *)userJSONTransformer {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[GCUser class]];
}

+ (NSValueTransformer *)surveysJSONTransformer
{
    // tell Mantle to populate appActions property with an array of ChoosyAppAction objects
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[GCSurvey class]];
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionaryValue error:(NSError *__autoreleasing *)error{
    self = [super initWithDictionary:dictionaryValue error:error];
    if (self == nil) {
        return nil;
    }
    return self;
}


@end
