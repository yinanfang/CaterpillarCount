//
//  GCRegisterScrollView.h
//  CaterpillarCount
//
//  Created by Golden Compass on 9/29/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GCRegisterViewController;

@interface GCRegisterScrollView : UIScrollView <UIScrollViewDelegate, UITextFieldDelegate>

// Self
@property GCRegisterViewController *parentController;
@property BOOL didSetupConstraints;

// Log In
@property UILabel *label_Register;
@property UITextField *entry_NameFirst, *entry_NameLast, *entry_Email, *entry_PasswordNew, *entry_PasswordConfirm;

// Submit Button
@property FUIButton *btn_Submit;

/**
 *  Initializer
 *
 *  @param controller Pointer
 *
 *  @return Return intance of this class
 */
- (id)initWithParentController:(GCRegisterViewController *)controller;

@end
