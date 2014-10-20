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
    
    // Register submit control
    [[self.registerScrollView.btn_Submit rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        NSLog(@"Submit registration button hit!");
        
        NSURL *url = [NSURL URLWithString:[[NSString alloc] initWithFormat:@"%@/~pocket14/forsyth.im/caterpillars/users.php", [GCAppAPI getCurrentDomain]]];
        
        //        NSDictionary *parameters = @{
        //                                     @"email": self.registerScrollView.entry_Email.text,
        //                                     @"password": [NSString stringWithFormat:@"%@",
        //                                                   self.registerScrollView.entry_PasswordNew.text],
        //                                     @"name": [NSString stringWithFormat:@"%@ %@",
        //                                               self.registerScrollView.entry_NameFirst.text,
        //                                               self.registerScrollView.entry_NameLast.text],
        //                                     };
        NSDictionary *parameters = @{
                                     @"email": @"yinan_fang@hotmail.com145",
                                     @"password": @"asdfasdf",
                                     @"name": @"Yinan Fang"
                                     };
        
        [GCNetwork twoWayJSONPOSTRequestWithViewController:self URL:url parameter:parameters HUDMessage:@"Register" completion:^(BOOL succeeded, NSDictionary *userInfoDictionary){
            // Update User Info
            [GCAppViewModel updateUserWithGCUser:userInfoDictionary];
            // Push to the Survey View
            GCSurveyViewController *surveyViewController = [[GCSurveyViewController alloc] init];
            [self.navigationController pushViewController:surveyViewController animated:YES];
        }];
    }];
    
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
