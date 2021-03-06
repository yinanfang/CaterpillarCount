//
//  GCSignInViewController.h
//  CaterpillarCount
//
//  Created by Golden Compass on 9/29/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GCSignInScrollView.h"

@interface GCSignInViewController : UIViewController

/*!
 *  Pointer to the view container
 */
@property GCSignInScrollView *signInScrollView;

/*!
 *  Pointer to a progress hud
 */
@property MBProgressHUD *hud;

@end
