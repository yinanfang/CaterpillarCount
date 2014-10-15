//
//  GCUserData02.m
//  CaterpillarCount
//
//  Created by Golden Compass on 10/15/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import "GCUserData02.h"

@implementation GCUserData02

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