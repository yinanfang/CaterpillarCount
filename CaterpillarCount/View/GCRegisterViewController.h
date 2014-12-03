//
//  GCRegisterViewController.h
//  CaterpillarCount
//
//  Created by Golden Compass on 9/29/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GCRegisterScrollView.h"

@interface GCRegisterViewController : UIViewController

/*!
 *  Pointer to the scroll view object
 */
@property GCRegisterScrollView *registerScrollView;

/**
 *  Pointer for the hud
 */
@property MBProgressHUD *hud;

@end
