//
//  GCCoverView.m
//  CaterpillarCount
//
//  Created by Golden Compass on 9/21/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import "GCCoverView.h"
#import "GCCoverViewController.h"
#import "GCSurveyViewController.h"
#import "GCSignInViewController.h"

@interface GCCoverView ()

@end

@implementation GCCoverView

- (id)initWithParentController:(GCCoverViewController *)controller
{
    self = [super init];
    if (self) {
        // Initialization code
        self.parentController = controller;
        self.backgroundColor = [UIColor whiteColor];
        [self.parentController.view addSubview:self];
        
        // Register Button
        self.btn_Register = [[FUIButton alloc] init];
        self.btn_Register.buttonColor = [GCAppAPI getColorWithRGBAinHex:ThemeColor01];
        self.btn_Register.shadowColor = [UIColor greenSeaColor];
        self.btn_Register.shadowHeight = 1.0f;
        self.btn_Register.cornerRadius = 6.0f;
        self.btn_Register.titleLabel.font = [UIFont boldFlatFontOfSize:16];
        [self.btn_Register setTitle:@"Register" forState:UIControlStateNormal];
        [self.btn_Register setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
        [self.btn_Register setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [self addSubview:self.btn_Register];
        [[self.btn_Register rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            NSLog(@"button tapped");
            GCSurveyViewController *surveyViewController = [[GCSurveyViewController alloc] init];
//            surveyViewController.view.frame = [[UIScreen mainScreen] bounds];
            [self.parentController.navigationController pushViewController:surveyViewController animated:YES];
        }];
        
        // Sign In Button
        self.btn_SignIn = [[FUIButton alloc] init];
        self.btn_SignIn.buttonColor = [GCAppAPI getColorWithRGBAinHex:ThemeColor01];
        self.btn_SignIn.shadowColor = [UIColor greenSeaColor];
        self.btn_SignIn.shadowHeight = 1.0f;
        self.btn_SignIn.cornerRadius = 6.0f;
        self.btn_SignIn.titleLabel.font = [UIFont boldFlatFontOfSize:16];
        [self.btn_SignIn setTitle:@"Sign In" forState:UIControlStateNormal];
        [self.btn_SignIn setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
        [self.btn_SignIn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [self addSubview:self.btn_SignIn];

        [[self.btn_SignIn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            NSLog(@"Sign In button tapped");
            GCSignInViewController *signInViewController = [[GCSignInViewController alloc] init];
            [self.parentController.navigationController pushViewController:signInViewController animated:YES];
        }];
        
        // Cover Image
    }
    return self;
}

- (void)updateConstraints
{
    if(!self.didSetupConstraints) {
        // Self
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.parentController.view.mas_top);
            make.left.equalTo(self.parentController.view.mas_left);
            make.bottom.equalTo(self.parentController.view.mas_bottom);
            make.right.equalTo(self.parentController.view.mas_right);
        }];
        
        // Register
        [self.btn_Register mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(200, 50));
            make.centerX.equalTo(self.mas_centerX);
            make.bottom.equalTo(self.mas_bottom).with.offset(-50);
        }];
        // Sign In
        [self.btn_SignIn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(200, 50));
            make.centerX.equalTo(self.mas_centerX);
            make.bottom.equalTo(self.btn_Register.mas_top).with.offset(-10);
        }];
        
        self.didSetupConstraints = YES;
    }
    [super updateConstraints];
}



@end
