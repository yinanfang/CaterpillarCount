//
//  GCSignInViewController.m
//  CaterpillarCount
//
//  Created by Golden Compass on 9/29/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import "GCSignInViewController.h"
#import "GCSurveyViewController.h"

@interface GCSignInViewController ()

@end

@implementation GCSignInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // UI Navigation Bar
    [GCAppSetup configureNavigationViewController:self withNavigationTitle:@"Sign In"];

    // Add Survey View
    self.signInScrollView = [[GCSignInScrollView alloc] initWithParentController:self];
    [self.signInScrollView setNeedsUpdateConstraints];
    [self.signInScrollView updateConstraintsIfNeeded];
    
    // Sign In submit control
    [[self.signInScrollView.btn_Submit rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        NSLog(@"Sign In button submit");
//        BOOL isValid = YES;
        BOOL isValidInput = [self isValidInput];
        if (isValidInput) {
            [self signIn];
        }
    }];
}

- (BOOL)isValidInput
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    if (![emailTest evaluateWithObject:self.signInScrollView.entry_Username.text]) {
        DDLogVerbose(@"Email format wrong!");
        [self makeHUDErrorAlertWithString:@"Email format wrong!"];
        return NO;
    }
    return YES;
}

- (void)signIn
{
    // Prepare
    DDLogVerbose(@"start to login...");
    [self makeHUDProgressWithString:@"Log In"];
    NSURL *url = [NSURL URLWithString:[[NSString alloc] initWithFormat:@"%@%@", [GCAppAPI getCurrentDomain], URIPathToUsersPHP]];
    NSDictionary *credential = @{
                                 @"email": self.signInScrollView.entry_Username.text,
                                 @"password": self.signInScrollView.entry_Password.text,
                                 };
    DDLogVerbose(@"url is: %@", url.absoluteString);
    DDLogVerbose(@"parameter: %@", credential);
    
    // Network Request
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.securityPolicy.allowInvalidCertificates = YES;
    [manager POST:url.absoluteString parameters:credential success:^(AFHTTPRequestOperation *operation, NSDictionary *data) {
        DDLogInfo(@"Get data successfully. Printing response data: %@", data);
        [self.hud hide:YES];
        if ([data[@"validUser"] isEqualToString:@"1"]&&[data[@"validPw"] isEqualToString:@"0"]&&[data[@"active"] isEqualToString:@"1"]) {
            [self makeHUDErrorAlertWithString:@"Wrong password"];
        } else if ([data[@"validUser"] isEqualToString:@"0"]&&[data[@"validPw"] isEqualToString:@"1"]&&[data[@"active"] isEqualToString:@"1"]) {
            [self makeHUDErrorAlertWithString:@"Invalid User"];
        } else if ([data[@"validUser"] isEqualToString:@"1"]&&[data[@"validPw"] isEqualToString:@"1"]&&[data[@"active"] isEqualToString:@"0"]) {
            [self makeHUDErrorAlertWithString:@"Not activated"];
        } else if ([data[@"validUser"] isEqualToString:@"1"]&&[data[@"validPw"] isEqualToString:@"1"]&&[data[@"active"] isEqualToString:@"1"]) {
            [self makeHUDSuccessWithString:@"Logged In successfully"];
            DDLogVerbose(@"Getting User object");
            NSDictionary *email = @{@"email":credential[@"email"]};
            [manager POST:url.absoluteString parameters:email success:^(AFHTTPRequestOperation *operation, NSDictionary *userDict) {
                DDLogInfo(@"Get data successfully. Printing response data: %@", userDict);
                // Update User Info
                [GCAppViewModel updateUserWithGCUser:userDict];
                // Push to the Survey View
                GCSurveyViewController *surveyViewController = [[GCSurveyViewController alloc] init];
                [self.navigationController pushViewController:surveyViewController animated:YES];

            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                DDLogWarn(@"Error: %@", error);
            }];
        } else {
            [self makeHUDErrorAlertWithString:@"Log In information incorrect"];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.hud hide:YES];
        // Customize error response
        if ([operation.response statusCode] == 404) {
            DDLogError(@"Email Not Found");
            [self makeHUDErrorAlertWithString:@"Email has already been registered"];
        } else {
            DDLogWarn(@"Error: %@", error);
            DDLogError(@"Here's the error");
            [self makeHUDErrorAlertWithString:[error localizedDescription]];
        }
    }];

    
//    [GCAppViewModel loginWithCredential:credential completion:^(BOOL succeeded) {
//        if (succeeded) {
//            [GCAppViewModel enterMainContainerViewController:self];
////            self.signInView.label_ErrorMessage.text = @"";
//        } else {
//            DDLogVerbose(@"Log In fail. Need to enter again");
////            self.signInView.label_ErrorMessage.text = @"Incorrect email or password";
////            [self restoreLoginPageLayout];
//        }
//    }];

    

//    [GCNetwork twoWayJSONPOSTRequestWithViewController:self URL:url parameter:parameters HUDMessage:@"Log In" completion:^(BOOL succeeded, NSDictionary *userInfoDictionary){
//        DDLogVerbose(@"Sign In succeeded.");
//        
//        parameters = @{
//                       @"email": @"yinan_fang@hotmail.com138",
//                       };
//        [GCNetwork twoWayJSONPOSTRequestWithViewController:self URL:url parameter:parameters HUDMessage:@"Updating User Info" completion:^(BOOL succeeded, NSDictionary *userInfoDictionary){
//            DDLogVerbose(@"Getting User object");
//            // Update User Info
//            [GCAppViewModel updateUserWithGCUser:userInfoDictionary];
//            // Push to the Survey View
//            GCSurveyViewController *surveyViewController = [[GCSurveyViewController alloc] init];
//            [self.navigationController pushViewController:surveyViewController animated:YES];
//        }];
//    }];
}

- (void)makeHUDProgressWithString:(NSString *)message
{
    self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.hud.mode = MBProgressHUDModeIndeterminate;
    self.hud.labelText = [NSString stringWithFormat:@"%@ in progress...", message];
    self.hud.square = YES;
}

- (void)makeHUDErrorAlertWithString:(NSString *)message
{
    self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.hud.mode = MBProgressHUDModeCustomView;
    dispatch_async(dispatch_get_main_queue(), ^{
        UIImage *image = [UIImage imageNamed:@"mark_cross"];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        self.hud.customView = imageView;
        self.hud.labelText = @"Error!";
        self.hud.detailsLabelText = message;
    });
    [self.hud hide:YES afterDelay:3];
}

- (void)makeHUDSuccessWithString:(NSString *)message
{
    self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.hud.mode = MBProgressHUDModeCustomView;
    dispatch_async(dispatch_get_main_queue(), ^{
        UIImage *image = [UIImage imageNamed:@"mark_check"];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        self.hud.customView = imageView;
        self.hud.labelText = @"Succeeded!";
        self.hud.detailsLabelText = message;
    });
    [self.hud hide:YES afterDelay:3];
}

#pragma mark - Other View Merringtonthods
- (void)viewWillAppear:(BOOL)animated
{
//    self.navigationController.navigationBar.tintColor =[UIColor redColor];
    self.navigationController.navigationBar.barTintColor = [GCAppAPI getColorWithRGBAinHex:ThemeColor01];
    self.navigationController.navigationBar.hidden = NO;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
