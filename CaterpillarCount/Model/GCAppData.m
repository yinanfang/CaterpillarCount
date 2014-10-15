//
//  GCAppData.m
//  CaterpillarCount
//
//  Created by Golden Compass on 10/12/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import "GCAppData.h"

@implementation GCAppData

- (id)init
{
    DDLogVerbose(@"Initializing GCAppData...");
    self = [super init];
    if (self) {
        // Initialize values
        self.allUserData = [[NSMutableDictionary alloc] init];
    }
    return self;
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"didLogedIn": @"didLogedIn",
             @"lastUserID": @"lastUserID",
             @"allUserData": @"allUserData",
             };
}

+ (NSValueTransformer *)didLogedInJSONTransformer
{
    return [NSValueTransformer valueTransformerForName:MTLBooleanValueTransformerName];
}

+ (NSValueTransformer *)lastUserIDJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSNumber *idNumber){
        return idNumber;
    }reverseBlock:^(NSNumber *idNumber){
        return idNumber;
    }];
}

+ (NSValueTransformer *)allUserDataJSONTransformer {
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSMutableDictionary *allUserDataDictionary){
//        return allUserData;
        NSMutableDictionary *allUserData = [[NSMutableDictionary alloc] init];
        for(id key in allUserData) {
            NSError *mantleError = nil;
            GCUserData *userData = [MTLJSONAdapter modelOfClass:[GCUserData class] fromJSONDictionary:allUserData[key] error:&mantleError];
            if (mantleError) {
                NSLog(@"Cannot generate GCUser model!!!");
            }
            allUserData[key] = userData;
        }
        return allUserData;
    }reverseBlock:^(NSMutableDictionary *allUserData){
        NSMutableDictionary *allUserDic = [[NSMutableDictionary alloc] init];
        for(id key in allUserData) {
            GCUserData *userData = [allUserData objectForKey:key];
            [allUserDic setObject:[MTLJSONAdapter JSONDictionaryFromModel:userData] forKey:key];
        }        
        return allUserDic;
    }];
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionaryValue error:(NSError *__autoreleasing *)error{
    self = [super initWithDictionary:dictionaryValue error:error];
    if (self == nil) {
        return nil;
    }
    return self;
}


@end
