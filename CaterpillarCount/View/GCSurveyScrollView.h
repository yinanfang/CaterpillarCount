//
//  GCSurveyScrollView.h
//  CaterpillarCount
//
//  Created by Golden Compass on 9/24/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GCSurveyViewController;

@interface GCSurveyScrollView : UIScrollView <UIScrollViewDelegate, UITextFieldDelegate>
// Self
@property GCSurveyViewController *parentController;
@property BOOL didSetupConstraints;

// Upper section
@property UILabel *label_Temp, *label_Time, *label_Date;
@property UIButton *entry_Temp, *entry_Time, *entry_Date;
// Input section
@property UILabel *label_SiteInfo;
@property UILabel *label_Site, *label_Circle, *label_Survey, *label_Notes;
@property UIButton *entry_Site, *entry_Circle, *entry_Survey;
@property UITextField *entry_SiteNotes;

// Arthropod Order Info
@property UILabel *label_ArthropodOrderInfo;
@property FUIButton *btn_NewOrderInfo;
@property UITableView *orderTableView;
// Plant Information
@property UILabel *label_PlantInfo, *label_PlantSpecies, *label_Herbivory;
@property UITextField *entry_PlantSpecies;
@property UIButton *entry_Herbivory;
// Plant Photo
@property UILabel *label_PlantPhoto;
@property UIImageView *entry_PlantPhoto;
@property UIButton *btn_PhotoPlaceHolder;
// Submit Button
@property FUIButton *btn_Submit;

// States
@property BOOL shouldMoveUpToAdjustForKeyboard;
@property BOOL shouldMoveDownToAdjustForKeyboard;


- (id)initWithParentController:(GCSurveyViewController *)controller;



@end



