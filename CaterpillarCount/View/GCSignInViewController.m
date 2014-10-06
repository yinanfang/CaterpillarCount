//
//  GCSignInViewController.m
//  CaterpillarCount
//
//  Created by Golden Compass on 9/29/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import "GCSignInViewController.h"
#import "GCSignInScrollView.h"

@interface GCSignInViewController ()
@property GCSignInScrollView *signInScrollView;

@end

@implementation GCSignInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // UI Navigation Bar
    // Set Title
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 120, 30)];
    label.textAlignment = NSTextAlignmentCenter;
    [label setFont:[UIFont boldSystemFontOfSize:16.0]];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setTextColor:[UIColor whiteColor]];
    [label setText:@"Sign In"];
    self.navigationItem.titleView = label;
    [label sizeToFit];
    // Back Button
    
    UIButton *backButton = [[UIButton alloc] initWithFrame: CGRectMake(0, 0, 20.0f, 30.0f)];
    backButton.backgroundColor = [UIColor clearColor];
    [backButton setTitle:@"<" forState:UIControlStateNormal];
    [backButton.titleLabel setFont:[UIFont fontWithName:@"Helvetica" size:20]];
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = backButtonItem;
    self.navigationController.interactivePopGestureRecognizer.delegate = (id<UIGestureRecognizerDelegate>)self;
    [[backButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    // Add Survey View
    self.signInScrollView = [[GCSignInScrollView alloc] initWithParentController:self];
}

#pragma mark - Other View Methods
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
