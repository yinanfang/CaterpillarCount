//
//  GCUser.m
//  CaterpillarCount
//
//  Created by Golden Compass on 10/8/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import "GCUser.h"

@implementation GCUser

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"userID": @"userID",
             @"email": @"email",
             @"userName": @"name",
             @"isValidUser": @"validUser",
             @"isActive": @"active",
             };
}

+ (NSValueTransformer *)userIDJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSNumber *idNumber){
        return idNumber;
    }reverseBlock:^(NSNumber *idNumber){
        return idNumber;
    }];
}

+ (NSValueTransformer *)emailJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *email){
        return email;
    }reverseBlock:^(NSString *email){
        return email;
    }];
}

+ (NSValueTransformer *)userNameJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *str){
        return str;
    }reverseBlock:^(NSString *str){
        return str;
    }];
}

+ (NSValueTransformer *)isValidUserJSONTransformer
{
    return [NSValueTransformer valueTransformerForName:MTLBooleanValueTransformerName];
}

+ (NSValueTransformer *)isActiveJSONTransformer
{
    return [NSValueTransformer valueTransformerForName:MTLBooleanValueTransformerName];
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionaryValue error:(NSError *__autoreleasing *)error{
    self = [super initWithDictionary:dictionaryValue error:error];
    if (self == nil) {
        return nil;
    }
    return self;
}

















@end
