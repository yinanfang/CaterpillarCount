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
        
        NSURL *url = [NSURL URLWithString:[[NSString alloc] initWithFormat:@"%@%@", [GCAppAPI getCurrentDomain], URIPathToUsersPHP]];
        
        //        NSDictionary *parameters = @{
        //                                     @"email": self.registerScrollView.entry_Email.text,
        //                                     @"password": [NSString stringWithFormat:@"%@",
        //                                                   self.registerScrollView.entry_PasswordNew.text],
        //                                     @"name": [NSString stringWithFormat:@"%@ %@",
        //                                               self.registerScrollView.entry_NameFirst.text,
        //                                               self.registerScrollView.entry_NameLast.text],
        //                                     };
        __block NSDictionary *parameters = @{
                                     @"email": @"yinan_fang@hotmail.com122",
                                     @"password": @"asdfasdf",
                                     };
        
        [GCNetwork twoWayJSONPOSTRequestWithViewController:self URL:url parameter:parameters HUDMessage:@"Log In" completion:^(BOOL succeeded, NSDictionary *userInfoDictionary){
            DDLogVerbose(@"Sign In succeeded.");
            
            parameters = @{
                           @"email": @"yinan_fang@hotmail.com122",
                           };
            [GCNetwork twoWayJSONPOSTRequestWithViewController:self URL:url parameter:parameters HUDMessage:@"Updating User Info" completion:^(BOOL succeeded, NSDictionary *userInfoDictionary){
                DDLogVerbose(@"Getting User object");
                // Update User Info
                [GCAppViewModel updateUserWithGCUser:userInfoDictionary];
                // Push to the Survey View
                GCSurveyViewController *surveyViewController = [[GCSurveyViewController alloc] init];
                [self.navigationController pushViewController:surveyViewController animated:YES];
            }];
        }];
    }];
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
