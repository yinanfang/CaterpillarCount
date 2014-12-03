//
//  GCAppDataViewModel.m
//  CaterpillarCount
//
//  Created by Golden Compass on 10/14/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import "GCAppViewModel.h"


@implementation GCAppViewModel

#pragma mark - Singleton Class
/**
 *  Class instance
 *
 *  @return Return a class instance
 */
+ (GCAppViewModel *)sharedInstance
{
    static GCAppViewModel *shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[self alloc] init];
        DDLogVerbose(@"Initialized GCAppViewModel share instance. Current value: %@", [shareInstance description]);
    });
    return shareInstance;
}

/**
 *  Initializer
 *
 *  @return Return an instance
 */
- (id)init
{
    DDLogVerbose(@"Initializing GCAppDataViewModel...");
    self = [super init];
    if (self) {
        // Initialize values
        self.appData = [[GCAppData alloc] init];
        self.currentUserData = [[GCUserData alloc] init];
        self.currentUnsavedOrders = [[NSMutableArray alloc] init];
    }
    return self;
}

#pragma mark - App data
+ (void)getAppDataFromNSUserDefaultsAndUpdateViewModel
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *appData_encoded = [defaults objectForKey:NSUserDefaultsKeyForAppData];
    GCAppViewModel *appViewModel = [GCAppViewModel sharedInstance];
    if (appData_encoded) {
        DDLogVerbose(@"Updating app data...");
        GCAppData *appData_decoded = [NSKeyedUnarchiver unarchiveObjectWithData:appData_encoded];
        appViewModel.appData = appData_decoded;
        appViewModel.currentUserData = [appViewModel.appData.allUserData[appViewModel.appData.lastUserID] copy];
    } else {
        DDLogVerbose(@"There's not appData...");
//        NSData *appData_encoded = [NSKeyedArchiver archivedDataWithRootObject:appViewModel.appData];
//        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//        [defaults setObject:appData_encoded forKey:NSUserDefaultsKeyForAppData];
//        [defaults synchronize];
    }
    DDLogVerbose(@"Finished updating GCAppViewModel");
    DDLogVerbose(@"appData Current value: %@", [MTLJSONAdapter JSONDictionaryFromModel:appViewModel.appData]); //appViewModel.appData);//
    DDLogVerbose(@"currentUserData Current value: %@", [MTLJSONAdapter JSONDictionaryFromModel:appViewModel.currentUserData]); // appViewModel.currentUserData);//
}

+ (void)saveAppDataToNSUserDefaults
{
    DDLogVerbose(@"Saveing app data...");
    GCAppViewModel *appViewModel = [GCAppViewModel sharedInstance];
    appViewModel.appData.allUserData[appViewModel.appData.lastUserID] = appViewModel.currentUserData;
    DDLogVerbose(@"App Data Current value: %@", [appViewModel.appData description]);
    DDLogVerbose(@"App Data Current valuein JSON: %@", [MTLJSONAdapter JSONDictionaryFromModel:appViewModel.appData]);
    NSData *appData_encoded = [NSKeyedArchiver archivedDataWithRootObject:appViewModel.appData];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:appData_encoded forKey:NSUserDefaultsKeyForAppData];
    [defaults synchronize];
}



#pragma mark - User data
+ (void)updateUserWithGCUser:(NSDictionary *)userDictionary
{
    GCAppViewModel *viewModel = [GCAppViewModel sharedInstance];
    
    // Init GCUser
    NSError *mantleError = nil;
    GCUser *user = [MTLJSONAdapter modelOfClass:[GCUser class] fromJSONDictionary:userDictionary error:&mantleError];
    DDLogVerbose([user description]);
    if (mantleError) {
        DDLogWarn(@"Cannot generate GCUser model!!!");
    }
    
    NSLog(@"userData02: %@", [viewModel.currentUserData description]);
    viewModel.currentUserData.user = user;
    viewModel.currentUserData = viewModel.currentUserData;
    
    viewModel.appData.didLogedIn = YES;
    viewModel.appData.lastUserID = user.userID;
    DDLogVerbose(@"Current App data is: %@", viewModel.appData);
    DDLogVerbose(@"Current user data JSON serialization: %@", [MTLJSONAdapter JSONDictionaryFromModel:viewModel.currentUserData]);
    //    DDLogVerbose(@"Current user data is: %@", viewModel.userData);

}

+ (void)addCurrentunsavedOrdersWithDictionary:(NSDictionary *)orderDictionary
{
    GCAppViewModel *viewModel = [GCAppViewModel sharedInstance];
    GCOrder *order = [GCAppAPI getMantleModelWithDictionary:orderDictionary modelClass:[GCOrder class]];
    NSLog(@"before adding: %@",viewModel.currentUnsavedOrders);
    [viewModel.currentUnsavedOrders addObject:order];
    DDLogVerbose(@"Added a new order. currentUnsavedOrders: %@", viewModel.currentUnsavedOrders);
}

+ (void)addSurveyData:(GCSurvey *)survey
{
//    DDLogVerbose(@"Survey data JSON serialization: %@", [MTLJSONAdapter JSONDictionaryFromModel:survey]);
    [[GCAppViewModel sharedInstance].currentUserData.surveys addObject:survey];
}

#pragma mark - Log In
+ (void)loginWithCredential:(NSDictionary *)credential completion:(void (^)(BOOL succeeded))completion
{
    DDLogVerbose(@"start to login...");
    NSURL *url = [NSURL URLWithString:[[NSString alloc] initWithFormat:@"%@%@", [GCAppAPI getCurrentDomain], URIPathToUsersPHP]];
    DDLogVerbose(@"url is: %@", url.absoluteString);
    DDLogVerbose(@"parameter: %@", credential);
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.securityPolicy.allowInvalidCertificates = YES;
    [manager POST:url.absoluteString parameters:credential success:^(AFHTTPRequestOperation *operation, NSData *data) {
        DDLogInfo(@"Get data successfully. Printing response data: %@", data);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DDLogWarn(@"Error: %@", error);
        // Customize error response
        if ([operation.response statusCode] == 409) {
            DDLogError(@"Email has already been registered");
        } else {
            DDLogError(@"Here's the error");
        }
    }];
    
    
//    [GCNetwork requestPOSTWithURL:url parameter:credential completion:^(BOOL succeeded, NSData *data) {
//        if (succeeded) {
//            NSDictionary *userDic = (NSDictionary *)data;
//            if ([userDic[@"iduser"] isEqualToString:@"0"]) {
//                DDLogVerbose(@"Rejected");
//                completion(NO);
//            } else {
//                DDLogVerbose(@"Logged in successfully");
//                // Init GCUser
//                NSError *error = nil;
//                GCUser *user = [MTLJSONAdapter modelOfClass:[GCUser class] fromJSONDictionary:userDic error:&error];
//                DDLogVerbose(@"user object: %@", [user description]);
//                if (error) {
//                    DDLogWarn(@"Cannot generate GCUser model!!!");
//                }
////                [GCAppViewModel sharedInstance].appData.currentUser = user;
//                completion(YES);
//            }
//        }
//    }];
}

+ (void)enterMainContainerViewController:(UIViewController *)controller
{
//    GCMainContainerViewController *mainContainerViewController = [[GCMainContainerViewController alloc] init];
//    [controller.navigationController pushViewController:mainContainerViewController animated:YES];
}

@end


