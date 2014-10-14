//
//  GCRegisterViewController.m
//  CaterpillarCount
//
//  Created by Golden Compass on 9/29/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import "GCRegisterViewController.h"
#import "GCSurveyViewController.h"

@interface GCRegisterViewController ()

@end

@implementation GCRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // UI Navigation Bar
    [GCAppSetup configureNavigationViewController:self withNavigationTitle:@"Register"];
    
    // Add Survey View
    self.registerScrollView = [[GCRegisterScrollView alloc] initWithParentController:self];
    [self.registerScrollView setNeedsUpdateConstraints];
    [self.registerScrollView updateConstraintsIfNeeded];
    
    // Submit Control
    [[self.registerScrollView.btn_Submit rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        NSLog(@"Submit registration button hit!");
        
        self.HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        self.HUD.mode = MBProgressHUDModeIndeterminate;
        self.HUD.labelText = @"Loging In...";
        self.HUD.square = YES;
        [self.view addSubview:self.HUD];
        NSURL *url = [NSURL URLWithString:[[NSString alloc] initWithFormat:@"%@/~pocket14/forsyth.im/caterpillars/users.php", [GCAppAPI getCurrentDomain]]];
        DDLogVerbose(@"url is: %@", url.absoluteString);
        //        NSDictionary *parameters = @{
        //                                     @"email": self.registerScrollView.entry_Email.text,
        //                                     @"password": [NSString stringWithFormat:@"%@",
        //                                                   self.registerScrollView.entry_PasswordNew.text],
        //                                     @"name": [NSString stringWithFormat:@"%@ %@",
        //                                               self.registerScrollView.entry_NameFirst.text,
        //                                               self.registerScrollView.entry_NameLast.text],
        //                                     };
        NSDictionary *parameters = @{
                                     @"email": @"yinan_fang@hotmail.com118",
                                     @"password": @"asdfasdf",
                                     @"name": @"Yinan Fang"
                                     };
        DDLogVerbose(@"parameter: %@", parameters);
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        [manager POST:url.absoluteString parameters:parameters success:^(AFHTTPRequestOperation *operation, NSDictionary *responseDictionary) {
            DDLogInfo(@"Get data successfully. Printing response JSON: %@", responseDictionary);
            NSError *mantleError = nil;
            GCUser *user = [MTLJSONAdapter modelOfClass:[GCUser class] fromJSONDictionary:responseDictionary error:&mantleError];
            DDLogVerbose([user description]);
            if (mantleError) {
                DDLogWarn(@"Cannot generate Mantle model!!!");
            }
            
            // Check mark HUD
            self.HUD.mode = MBProgressHUDModeCustomView;
            dispatch_async(dispatch_get_main_queue(), ^{
                UIImage *image = [UIImage imageNamed:@"mark_check"];
                UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
                self.HUD.customView = imageView;
                self.HUD.labelText = @"Logged in successfully";
            });
            
            // Update Current User
            [GCStore updateUserWithGCUser:user];
            DDLogVerbose(@"Current App data is: %@", [GCStore getAppData]);
            DDLogVerbose(@"Current JSON serialization: %@", [MTLJSONAdapter JSONDictionaryFromModel:[GCStore getAppData]]);
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1*NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                [self.HUD hide:YES];
                GCSurveyViewController *surveyViewController = [[GCSurveyViewController alloc] init];
                [self.navigationController pushViewController:surveyViewController animated:YES];
            });
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            DDLogWarn(@"Error: %@", error);
            // Cross mark HUD
            self.HUD.mode = MBProgressHUDModeCustomView;
            dispatch_async(dispatch_get_main_queue(), ^{
                UIImage *image = [UIImage imageNamed:@"mark_cross"];
                UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
                self.HUD.customView = imageView;
                self.HUD.labelText = @"Error!";
            });
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 4*NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                [self.HUD hide:YES];
            });

            // Customize error response
            if ([operation.response statusCode] == 409) {
                DDLogError(@"Email has already been registered");
                self.HUD.detailsLabelText = @"Email has already been registered";
            } else {
                DDLogError(@"Here's the error");
                self.HUD.detailsLabelText = [error localizedDescription];
            }
        }];

        
        
        
//        FUIAlertView *alertView = [[FUIAlertView alloc] initWithTitle:@"Well Done!" message:@"Submitting the data..." delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil, nil];
//        alertView.alertViewStyle = FUIAlertViewStylePlainTextInput;
//        alertView.delegate = self;
//        alertView.titleLabel.textColor = [UIColor cloudsColor];
//        alertView.titleLabel.font = [UIFont boldFlatFontOfSize:16];
//        alertView.messageLabel.textColor = [UIColor cloudsColor];
//        alertView.messageLabel.font = [UIFont flatFontOfSize:14];
//        alertView.backgroundOverlay.backgroundColor = [[UIColor cloudsColor] colorWithAlphaComponent:0.8];
//        alertView.alertContainer.backgroundColor = [UIColor midnightBlueColor];
//        alertView.defaultButtonColor = [UIColor cloudsColor];
//        alertView.defaultButtonShadowColor = [UIColor asbestosColor];
//        alertView.defaultButtonFont = [UIFont boldFlatFontOfSize:16];
//        alertView.defaultButtonTitleColor = [UIColor asbestosColor];
//        [alertView show];
    }];
    
}

- (void)hudWasHidden:(MBProgressHUD *)hud {
}

- (void)viewWillAppear:(BOOL)animated
{
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
