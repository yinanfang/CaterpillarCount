//
//  GCNetwork.m
//  CaterpillarCount
//
//  Created by Golden Compass on 10/12/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import "GCNetwork.h"

@implementation GCNetwork

+ (void)twoWayJSONPOSTRequestWithViewController:(UIViewController *)controller URL:(NSURL *)url parameter:(NSDictionary *)parameter HUDMessage:(NSString *)message completion:(void (^)(BOOL succeeded, NSDictionary *responseDictionary))completionBlock
{
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:controller.view animated:YES];
    HUD.mode = MBProgressHUDModeIndeterminate;
    HUD.labelText = [NSString stringWithFormat:@"%@ in progress...", message];
    HUD.square = YES;
    [controller.view addSubview:HUD];
    
    DDLogVerbose(@"url is: %@", url.absoluteString);
    DDLogVerbose(@"parameter: %@", parameter);
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager POST:url.absoluteString parameters:parameter success:^(AFHTTPRequestOperation *operation, NSDictionary *responseDictionary) {
        DDLogInfo(@"Get data successfully. Printing response JSON: %@", responseDictionary);
        
        // Check response again here. Wrong password, Invalid User, Not activated
        
        
        
        // Check mark HUD
        HUD.mode = MBProgressHUDModeCustomView;
        dispatch_async(dispatch_get_main_queue(), ^{
            UIImage *image = [UIImage imageNamed:@"mark_check"];
            UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
            HUD.customView = imageView;
            HUD.labelText = [NSString stringWithFormat:@"%@ succeeded!", message];
        });
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1*NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            [HUD hide:YES];
            completionBlock(YES, responseDictionary);
        });
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DDLogWarn(@"Error: %@", error);
        // Cross mark HUD
        HUD.mode = MBProgressHUDModeCustomView;
        dispatch_async(dispatch_get_main_queue(), ^{
            UIImage *image = [UIImage imageNamed:@"mark_cross"];
            UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
            HUD.customView = imageView;
            HUD.labelText = @"Error!";
        });
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 4*NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            [HUD hide:YES];
        });
        
        // Customize error response
        if ([operation.response statusCode] == 409) {
            DDLogError(@"Email has already been registered");
            HUD.detailsLabelText = @"Email has already been registered";
        } else {
            DDLogError(@"Here's the error");
            HUD.detailsLabelText = [error localizedDescription];
        }
    }];
}

@end
