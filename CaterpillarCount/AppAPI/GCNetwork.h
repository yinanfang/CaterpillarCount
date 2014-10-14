//
//  GCNetwork.h
//  CaterpillarCount
//
//  Created by Golden Compass on 10/12/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GCNetwork : NSObject

+ (void)twoWayJSONPOSTRequestWithViewController:(UIViewController *)controller URL:(NSURL *)url parameter:(NSDictionary *)parameter HUDMessage:(NSString *)message completion:(void (^)(BOOL succeeded, NSDictionary *responseDictionary))completionBlock;

    
@end
