//
//  GCSignInScrollView.h
//  CaterpillarCount
//
//  Created by Golden Compass on 9/29/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GCSignInViewController;

@interface GCSignInScrollView : UIScrollView <UIScrollViewDelegate>

// Self
@property GCSignInViewController *parentController;
@property BOOL didSetupConstraints;





- (id)initWithParentController:(GCSignInViewController *)controller;

@end
