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
#import "GCRegisterViewController.h"

@interface GCCoverView ()

@end

@implementation GCCoverView

- (id)initWithParentController:(GCCoverViewController *)controller
{
    self = [super init];
    if (self) {
        // Initialization code
        self.parentController = controller;
        self.backgroundColor = [GCAppAPI getColorWithRGBAinHex:ThemeColor01];
        [self.parentController.view addSubview:self];
        
        // Title Text
        self.label_Title = [[UILabel alloc] init];
        self.label_Title.textAlignment = NSTextAlignmentCenter;
        self.label_Title.numberOfLines = 2;
        [self.label_Title setFont:[UIFont fontWithName:@"Helvetica-Bold" size:2*FontSize_H1]];
        [self.label_Title setBackgroundColor:[UIColor clearColor]];
        [self.label_Title setTextColor:[UIColor whiteColor]];
        [self.label_Title setText:@"CATERPILLARS COUNT"];
        [self addSubview:self.label_Title];
        
        // Cover Logo
        self.imageView_Logo = [[UIImageView alloc] init];
        self.imageView_Logo.image = [UIImage imageNamed:@"cover_logo"];
        self.imageView_Logo.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:self.imageView_Logo];
        
        // Register Button
        self.btn_Register = [GCCoverView ButtonWithTitle:@"Register"];
        [self addSubview:self.btn_Register];
        [[self.btn_Register rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            NSLog(@"Register button tapped");
            GCRegisterViewController *registerViewController = [[GCRegisterViewController alloc] init];
            [self.parentController.navigationController pushViewController:registerViewController animated:YES];
        }];
        
        // Sign In Button
        self.btn_SignIn = [GCCoverView ButtonWithTitle:@"Sign In"];
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
        [GCAppSetup setConstraints_FillFullScreenWithView:self superview:self.parentController.view];
        
        // Title Text
        [self.label_Title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).with.offset(3*mas_Padding_Page_Large.top);
            make.left.equalTo(self.mas_left).with.offset(mas_Padding_Page_Large.left);
            make.right.equalTo(self.mas_right).with.offset(mas_Padding_Page_Large.right);
        }];
        
        // Cover Logo
        [self.imageView_Logo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(200, 200));
            make.centerX.equalTo(self.mas_centerX);
            make.centerY.equalTo(self.mas_centerY);
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

#pragma mark - Factory Methods
+ (FUIButton *)ButtonWithTitle:(NSString *)title
{
    FUIButton *button = [[FUIButton alloc] init];
    button.buttonColor = [UIColor whiteColor];
    button.shadowColor = [GCAppAPI getColorWithRGBAinHex:ThemeColor01_Variation01];
    button.shadowHeight = 1.0f;
    button.cornerRadius = 6.0f;
    button.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:FontSize_P1];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[GCAppAPI getColorWithRGBAinHex:ThemeColor01] forState:UIControlStateNormal];
    [button setTitleColor:[GCAppAPI getColorWithRGBAinHex:ThemeColor01_Variation01] forState:UIControlStateHighlighted];
    return button;
}

@end
