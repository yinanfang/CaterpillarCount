//
//  GCCoverView.h
//  CaterpillarCount
//
//  Created by Golden Compass on 9/21/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GCCoverViewController;

/*!
 *  View Container for the Cover View
 */
@interface GCCoverView : UIView

/*!
 *  Pointer to the objects in parent controller
 */
@property GCCoverViewController *parentController;
@property BOOL didSetupConstraints;


/*!
 *  Pointer to the objects in this view
 */
@property UILabel *label_Title;
@property UIImageView *imageView_Logo;
@property FUIButton *btn_SignIn, *btn_Register;

/*!
 *  Initializer
 *
 *  @param controller Pointer to the parent controller
 *
 *  @return Instance of this class
 */
- (id)initWithParentController:(GCCoverViewController *)controller;


@end
