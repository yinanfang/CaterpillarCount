//
//  GCSurveyScrollView.h
//  CaterpillarCount
//
//  Created by Golden Compass on 9/24/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GCSurveyViewController;
/**
 *  Survey Scroll View
 */
@interface GCSurveyScrollView : UIScrollView <UIScrollViewDelegate, UITextFieldDelegate>

/**
 *  Pointer for the parent controller
 */
@property GCSurveyViewController *parentController;
/**
 *  Boolean for setting up constraints
 */
@property BOOL didSetupConstraints;

/**
 *  Label and entries for upper section
 */
@property UILabel *label_Temp, *label_Time, *label_Date;
@property UIButton *entry_Temp, *entry_Time, *entry_Date;

/**
 *  Lbael and entries for middle section
 */
@property UILabel *label_SiteInfo;
@property FUIButton *btn_NewSite;
@property UIButton *btn_Info_Site;
@property UILabel *label_Site, *label_Circle, *label_Survey, *label_Notes;
@property UIButton *entry_Site, *entry_Circle, *entry_Survey;
@property UITextField *entry_SiteNotes;

/**
 *  Arthropod Order Info
 */
@property UILabel *label_ArthropodOrderInfo;
@property UIButton *btn_Info_Order;
@property FUIButton *btn_NewOrderInfo;
@property UITableView *orderTableView;
@property UILabel *label_tableTips;
/**
 *  Plant Information
 */
@property UILabel *label_PlantInfo, *label_PlantSpecies, *label_Herbivory;
@property UITextField *entry_PlantSpecies;
@property UIButton *entry_Herbivory;
/**
 *  Plant Photo
 */
@property UILabel *label_PlantPhoto;
@property UIButton *btn_Info_Plant;
@property UIImageView *entry_PlantPhoto;
@property UIButton *btn_PhotoPlaceHolder;
/**
 *  Submit Button
 */
@property FUIButton *btn_Submit;

/**
 *  States
 */
@property BOOL shouldMoveUpToAdjustForKeyboard;
@property BOOL shouldMoveDownToAdjustForKeyboard;

/**
 *  Initializer
 *
 *  @param controller Pointer to the parent controller
 *
 *  @return Returning a instance of this class
 */
- (id)initWithParentController:(GCSurveyViewController *)controller;



@end



