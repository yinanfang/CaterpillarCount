//
//  GCSurveyScrollView.h
//  CaterpillarCount
//
//  Created by Golden Compass on 9/24/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GCSurveyViewController;

@interface GCSurveyScrollView : UIScrollView <UIScrollViewDelegate>

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

- (id)initWithParentController:(GCSurveyViewController *)controller;



@end



