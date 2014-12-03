//
//  GCSurveyViewController.h
//  CaterpillarCount
//
//  Created by Golden Compass on 9/24/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GCSurveyScrollView.h"
#import "GCNewOrderViewController.h"

/**
 *  Controller for the Survey View
 */
@interface GCSurveyViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource, UITableViewDelegate, UITableViewDataSource,UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIAlertViewDelegate>

/**
 *  Pointer to the survey scroll view
 */
@property (strong) GCSurveyScrollView *surveyScrollView;

/**
 *  Aler View for adding site
 */
@property UIAlertView *alertView_addSite;

/**
 *  Re-usable picker for all buttons
 */
@property UIPickerView *picker_Generic;
/**
 *  RACCommand for starting a picker
 */
@property RACCommand *firePicker;
/**
 *  Picker Type
 */
@property PickerType pickerType;
/**
 *  Boolean for picker's presence
 */
@property __block BOOL didShowPicker;
/**
 *  Picker's content
 */
@property NSMutableArray *pickerContent;

/**
 *  Picker for start time
 */
@property UIDatePicker *picker_TimeStart;

/**
 *  HTTP manager
 */
@property AFHTTPRequestOperationManager *manager;
/**
 *  Outgoing image buffer
 */
@property NSMutableArray *imageBuffer;
/**
 *  Progress HUD
 */
@property MBProgressHUD *hud;

/**
 *  Alert for log out
 */
@property UIAlertView *alert_Logout;


@end

