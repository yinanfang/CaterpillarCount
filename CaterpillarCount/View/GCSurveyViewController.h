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

@interface GCSurveyViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource, UITableViewDelegate, UITableViewDataSource>

@property (strong) GCSurveyScrollView *surveyScrollView;
@property (strong) NSMutableDictionary *offscreenCells;


@property UIPickerView *picker_Temp;
@property NSMutableArray *pickerContentArray;

typedef NS_ENUM(NSInteger, PickerType) {
    PickerType01,
    PickerType02,
};
//@property StoryDisplayStyleMode storyDisplayStyleMode;




@end





//[parentController.view layoutIfNeeded];
//[UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//    // Change the controller height
//    [parentController.view mas_updateConstraints:^(MASConstraintMaker *make){
//        make.height.equalTo(@(newStoryImageHeight));
//    }];
//    // Adjust scroll view offset
//    [storyItemViews[0] mas_updateConstraints:^(MASConstraintMaker *make){
//        make.left.equalTo(self.mas_left).offset(1);
//    }];
//    // Change the image size for this scroll view. Update other when scroll to them
//    for (GCStoryItemView *storyItemView in self.storyItemViews) {
//        [storyItemView mas_updateConstraints:^(MASConstraintMaker *make){
//            make.height.equalTo(@(newStoryImageHeight));
//            make.width.equalTo(@(newStoryImageWidth));
//        }];
//    }
//    [parentController.view layoutIfNeeded];
//}completion:nil];
//self.contentOffset = CGPointMake(numberOfStoryItemBeforeTheItemTouch*ScreenWidth, 0);