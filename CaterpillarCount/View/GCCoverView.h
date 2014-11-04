//
//  GCCoverView.h
//  CaterpillarCount
//
//  Created by Golden Compass on 9/21/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GCCoverViewController;

@interface GCCoverView : UIView
// Self
@property GCCoverViewController *parentController;
@property BOOL didSetupConstraints;

// View items
@property UILabel *label_Title;
@property UIImageView *imageView_Logo;
@property FUIButton *btn_SignIn, *btn_Register;


- (id)initWithParentController:(GCCoverViewController *)controller;


@end
