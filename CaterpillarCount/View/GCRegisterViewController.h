//
//  GCRegisterViewController.h
//  CaterpillarCount
//
//  Created by Golden Compass on 9/29/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GCRegisterScrollView.h"
#import "GCUser.h"

@interface GCRegisterViewController : UIViewController <FUIAlertViewDelegate, MBProgressHUDDelegate>

@property GCRegisterScrollView *registerScrollView;

@property MBProgressHUD *HUD;

@end
