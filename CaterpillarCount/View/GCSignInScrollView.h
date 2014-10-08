//
//  GCSignInScrollView.h
//  CaterpillarCount
//
//  Created by Golden Compass on 9/29/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GCSignInViewController;

@interface GCSignInScrollView : UIScrollView <UIScrollViewDelegate, UITextFieldDelegate, FUIAlertViewDelegate>

// Self
@property GCSignInViewController *parentController;
@property BOOL didSetupConstraints;

// Log In
@property UILabel *label_Login;
@property UITextField *entry_Username, *entry_Password;

// Submit Button
@property FUIButton *btn_Submit;

- (id)initWithParentController:(GCSignInViewController *)controller;

@end
