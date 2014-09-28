//
//  GCNewOrderScrollView.h
//  CaterpillarCount
//
//  Created by Golden Compass on 9/28/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GCNewOrderViewController;

@interface GCNewOrderScrollView : UIScrollView <UIScrollViewDelegate, UITextFieldDelegate, FUIAlertViewDelegate>

// Upper section
@property UILabel *label_Order;
@property UIButton *entry_Order;
@property UITextField *entry_Length, *entry_Count, *entry_Notes;

// Photo
@property UILabel *label_Photo;
@property UIImageView *entry_Photo;
@property UILabel *label_PhotoPlaceHolder;
// Submit Button
@property FUIButton *btn_Submit;

- (id)initWithParentController:(GCNewOrderViewController *)controller;


@end
