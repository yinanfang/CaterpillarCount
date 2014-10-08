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
        self.backgroundColor = [UIColor whiteColor];
        [self.parentController.view addSubview:self];
        
        // Register Button
        self.btn_Register = [FUIButton ButtonWithTitle:@"Register" inBold:YES];
        [self addSubview:self.btn_Register];
        [[self.btn_Register rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            NSLog(@"button tapped");
            GCRegisterViewController *registerViewController = [[GCRegisterViewController alloc] init];
            [self.parentController.navigationController pushViewController:registerViewController animated:YES];
        }];
        
        // Sign In Button
        self.btn_SignIn = [FUIButton ButtonWithTitle:@"Sign In" inBold:YES];
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
