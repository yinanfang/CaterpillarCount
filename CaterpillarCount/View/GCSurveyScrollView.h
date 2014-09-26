//
//  GCSurveyScrollView.h
//  CaterpillarCount
//
//  Created by Golden Compass on 9/24/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GCSurveyViewController;

@interface GCSurveyScrollView : UIScrollView

// Upper section
@property UILabel *label_Temp, *label_Time, *label_Date;
@property UIButton *entry_Temp, *entry_Time, *entry_Date;



- (id)initWithParentController:(GCSurveyViewController *)controller;



@end
