//
//  GCSurveyScrollView.h
//  CaterpillarCount
//
//  Created by Golden Compass on 9/24/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GCSurveyViewController;

@interface GCSurveyScrollView : UIScrollView <UIScrollViewDelegate, UITextFieldDelegate, FUIAlertViewDelegate>

// Upper section
@property UILabel *label_Temp, *label_Time, *label_Date;
@property UIButton *entry_Temp, *entry_Time, *entry_Date;
// Input section
@property UILabel *label_SiteInfo;
@property UILabel *label_Site, *label_Circle, *label_Survey;
@property UIButton *entry_Site, *entry_Circle, *entry_Survey;
// Arthropod Order Info
@property UILabel *label_ArthropodOrderInfo;
@property FUIButton *btn_NewOrderInfo;
@property UITableView *orderTableView;
// Plant Information
@property UILabel *label_PlantInfo, *label_Herbivory;
@property UITextField *entry_PlantSpecies;
@property UIButton *entry_Herbivory;
// Plant Photo
@property UILabel *label_PlantPhoto;
@property UIImageView *entry_PlantPhoto;
@property UILabel *label_PhotoPlaceHolder;
// Submit Button
@property FUIButton *btn_Submit;


- (id)initWithParentController:(GCSurveyViewController *)controller;



@end



