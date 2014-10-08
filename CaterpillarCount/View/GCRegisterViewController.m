//
//  GCRegisterViewController.m
//  CaterpillarCount
//
//  Created by Golden Compass on 9/29/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import "GCRegisterViewController.h"


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
        NSLog(@"Submit registration");
        
        NSString *url_string = [[NSString alloc] initWithFormat:@"%@/~pocket14/forsyth.im/caterpillars/users.php", [GCAppAPI getCurrentDomain]];
        DDLogVerbose(@"url is: %@", url_string);
//        NSDictionary *parameters = @{
//                                     @"email": self.registerScrollView.entry_Email.text,
//                                     @"password": [NSString stringWithFormat:@"%@",
//                                                   self.registerScrollView.entry_PasswordNew.text],
//                                     @"name": [NSString stringWithFormat:@"%@ %@",
//                                               self.registerScrollView.entry_NameFirst.text,
//                                               self.registerScrollView.entry_NameLast.text],
//                                     };
        NSDictionary *parameters = @{
                                     @"email": @"yinan_fang@hotmail.com",
                                     @"password": @"asdfasdf",
                                     @"name": @"Yinan Fang"
                                     };

        DDLogVerbose(@"parameter: %@", parameters);
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        [manager POST:url_string parameters:parameters success:^(AFHTTPRequestOperation *operation, NSDictionary *responseDictionary) {
            DDLogInfo(@"Get data successfully. Printing response JSON: %@", responseDictionary);
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            DDLogError(@"Error: %@", error);
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
