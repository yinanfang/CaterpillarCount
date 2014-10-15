//
//  GCSurvey.m
//  CaterpillarCount
//
//  Created by Golden Compass on 10/10/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import "GCSurvey.h"

@implementation GCSurvey

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"userID": @"useID",
             @"surveyID": @"surveyID",
             
             @"siteName": @"siteName",
             @"circleNumber": @"circleNumber",
             @"surveyString": @"surveyString",
             @"timeSubmitted": @"timeSubmitted",
             @"temperature": @"temperature",
             @"ordersArray": @"ordersArray",
             @"plantSpecies": @"plantSpecies",
             @"herbivory": @"herbivory",
             @"plantPhotoLocalURL": @"plantPhotoLocalURL",
//             @"plantPhotoView": @"plantPhotoView",
             };
}

+ (NSValueTransformer *)userIDJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *idString){
        return idString;
    }reverseBlock:^(NSString *idString){
        return idString;
    }];
}

+ (NSValueTransformer *)surveyIDJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *idString){
        return idString;
    }reverseBlock:^(NSString *idString){
        return idString;
    }];
}

+ (NSValueTransformer *)siteNameJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *str){
        return str;
    }reverseBlock:^(NSString *str){
        return str;
    }];
}

+ (NSValueTransformer *)circleNumberJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSNumber *num){
        return num;
    }reverseBlock:^(NSNumber *num){
        return num;
    }];
}

+ (NSValueTransformer *)surveyStringJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *str){
        return str;
    }reverseBlock:^(NSString *str){
        return str;
    }];
}

+ (NSValueTransformer *)timeSubmittedJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *str){
        return str;
    }reverseBlock:^(NSString *str){
        return str;
    }];
}

+ (NSValueTransformer *)temperatureJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *str){
        return str;
    }reverseBlock:^(NSString *str){
        return str;
    }];
}

+ (NSValueTransformer *)ordersArrayJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSMutableArray *array){
        return array;
    }reverseBlock:^(NSMutableArray *array){
        return array;
    }];
}

+ (NSValueTransformer *)plantSpeciesJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *str){
        return str;
    }reverseBlock:^(NSString *str){
        return str;
    }];
}

+ (NSValueTransformer *)herbivoryJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *str){
        return str;
    }reverseBlock:^(NSString *str){
        return str;
    }];
}

+ (NSValueTransformer *)plantPhotoUrlJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *localURL){
        return localURL;
    }reverseBlock:^(NSString *localURL){
        return localURL;
    }];
}

//+ (NSValueTransformer *)plantPhotoViewJSONTransformer
//{
//    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(UIImageView *imageView){
//        return imageView;
//    }reverseBlock:^(UIImageView *imageView){
//        return imageView;
//    }];
//}

- (instancetype)initWithDictionary:(NSDictionary *)dictionaryValue error:(NSError *__autoreleasing *)error{
    self = [super initWithDictionary:dictionaryValue error:error];
    if (self == nil) {
        return nil;
    }
    return self;
}

@end
