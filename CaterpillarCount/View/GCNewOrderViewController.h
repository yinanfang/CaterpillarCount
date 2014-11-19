//
//  GCNewOrderViewController.h
//  CaterpillarCount
//
//  Created by Golden Compass on 9/28/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GCNewOrderScrollView.h"


@interface GCNewOrderViewController : UIViewController
<   UINavigationControllerDelegate,
    UIImagePickerControllerDelegate,
    UITextFieldDelegate,
    UIScrollViewDelegate,
    UIPickerViewDelegate,
    UIPickerViewDataSource
>

@property GCNewOrderScrollView *orderScrollView;

// View Items
@property UIPickerView *picker_Generic;
@property PickerType pickerType;
@property __block BOOL didShowPicker;
@property NSMutableArray *pickerContent;

@property MBProgressHUD *hud;

@property BOOL isModifying;
@property NSInteger row;

@end
