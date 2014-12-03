//
//  GCSignInScrollView.h
//  CaterpillarCount
//
//  Created by Golden Compass on 9/29/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GCSignInViewController;

@interface GCSignInScrollView : UIScrollView <UIScrollViewDelegate, UITextFieldDelegate>

// Self
@property GCSignInViewController *parentController;
@property BOOL didSetupConstraints;

// Log In
/*!
 * nothing The ViewController class' car object.
 */
@property UILabel *label_Login;

/**
 * @discussion The ViewController class' car object.
 */
@property UITextField *entry_Username, *entry_Password;

// Submit Button
/*!
 * @brief The ViewController class' car object.
 */
@property FUIButton *btn_Submit;

/**
 * @brief The ViewController class' car object lallala.
 */
- (id)initWithParentController:(GCSignInViewController *)controller;

@end
