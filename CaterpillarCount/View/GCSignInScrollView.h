//
//  GCSignInScrollView.h
//  CaterpillarCount
//
//  Created by Golden Compass on 9/29/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GCSignInViewController;

/**
 *  Sign In Scroll View
 */
@interface GCSignInScrollView : UIScrollView <UIScrollViewDelegate, UITextFieldDelegate>

/*!
 *  Pointer to the parent controller
 */
@property GCSignInViewController *parentController;
@property BOOL didSetupConstraints;

/*!
 *  Objects in the view
 */
@property UILabel *label_Login;
@property UITextField *entry_Username, *entry_Password;

@property FUIButton *btn_Submit;

/*!
 *  Initializer
 *
 *  @param controller Pointer to the parent controller
 *
 *  @return Instance of the class
 */
- (id)initWithParentController:(GCSignInViewController *)controller;

@end
