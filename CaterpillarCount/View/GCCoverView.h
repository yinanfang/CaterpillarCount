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

@property FUIButton *btn_SignIn, *btn_Register;

- (id)initWithParentController:(GCCoverViewController *)controller;


@end
