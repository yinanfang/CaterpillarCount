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
             @"userID": @"userID",
             @"surveyID": @"surveyID",
             
             @"siteName": @"siteName",
             @"circleNumber": @"circleNumber",
             @"surveyString": @"surveyString",
             @"timeSubmitted": @"timeSubmitted",
             @"temperature": @"temperature",
             @"siteNotes": @"siteNotes",
             
             @"ordersArray": @"ordersArray",
             
             @"plantSpecies": @"plantSpecies",
             @"herbivory": @"herbivory",
             @"plantPhotoLocalURL": @"plantPhotoLocalURL",
//             @"plantPhotoView": @"plantPhotoView",
             };
}

+ (NSValueTransformer *)userIDJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSNumber *num){
        return num;
    }reverseBlock:^(NSNumber *num){
        return num;
    }];
}

+ (NSValueTransformer *)surveyIDJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSNumber *num){
        return num;
    }reverseBlock:^(NSNumber *num){
        return num;
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
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *timeString){
        return [self.dateFormatter dateFromString:timeString];
    }reverseBlock:^(NSDate *date){
        return [self.dateFormatter stringFromDate:date];
    }];
}

+ (NSDateFormatter *)dateFormatter {
    
    static NSDateFormatter *kDateFormatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        kDateFormatter = [[NSDateFormatter alloc] init];
        kDateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
        kDateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";  // you configure this based on the strings that your webservice uses!!
    });
    return kDateFormatter;
}

+ (NSValueTransformer *)temperatureJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *str){
        return str;
    }reverseBlock:^(NSString *str){
        return str;
    }];
}

+ (NSValueTransformer *)siteNotesJSONTransformer
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
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSNumber *num){
        return num;
    }reverseBlock:^(NSNumber *num){
        return num;
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
