//
//  GCOrder.m
//  CaterpillarCount
//
//  Created by Golden Compass on 10/10/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import "GCOrder.h"

@implementation GCOrder

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"orderID": @"orderID",
             
             @"orderName": @"orderName",
             @"length": @"length",
             @"count": @"count",
             @"note": @"note",
             @"orderPhotoLocalURL": @"orderPhotoLocalURL",
//             @"orderPhotoView": @"orderPhotoView",
             };
}

+ (NSValueTransformer *)orderIDJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *idString){
        return idString;
    }reverseBlock:^(NSString *idString){
        return idString;
    }];
}

+ (NSValueTransformer *)orderNameJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *name){
        return name;
    }reverseBlock:^(NSString *name){
        return name;
    }];
}

+ (NSValueTransformer *)lengthJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSNumber *length){
        return length;
    }reverseBlock:^(NSNumber *length){
        return length;
    }];
}

+ (NSValueTransformer *)countJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSNumber *count){
        return count;
    }reverseBlock:^(NSNumber *count){
        return count;
    }];
}

+ (NSValueTransformer *)noteJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *note){
        return note;
    }reverseBlock:^(NSString *note){
        return note;
    }];
}

+ (NSValueTransformer *)orderPhotoURLJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSURL *url){
        return url;
    }reverseBlock:^(NSURL *url){
        return url;
    }];
}

//+ (NSValueTransformer *)orderPhotoViewJSONTransformer
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
