//
//  GCAppSetup.h
//  CaterpillarCount
//
//  Created by Golden Compass on 10/6/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FlatUIKit/FUIButton.h>
#import <Foundation/Foundation.h>
#import "GCAppConfig.h"

@interface GCAppSetup : NSObject

#pragma mark - Basic Setup
+ (void)setupApplicationWithProductionMode:(BOOL)mode;

#pragma mark - Style, font, size
+ (void)configureNavigationViewController:(UIViewController *)viewcontroller withNavigationTitle:(NSString *)title;
+ (void)configureBackButtonOfNavigationViewController:(UIViewController *)viewcontroller;
+ (UIButton *)configureRightButtonOfNavigationViewController:(UIViewController *)viewcontroller;

+ (void)setConstraints_FillFullScreenWithView:(UIView *)view superview:(UIView *)superview;
+ (void)setConstraints_PinHorizontallyWithPagePaddingAndTopWithPadding:(PagePaddingOption)paddingOption withView:(UIView *)view superview:(UIView *)superview upperview:(UIView *)upperview;


@end

#pragma mark - Category UILabel
@interface UILabel (AdvancedInitialization)
+ (UILabel *)LabelTitleWithString:(NSString *)title align:(NSTextAlignment)alignment;
+ (UILabel *)LabelSubTitleWithString:(NSString *)title align:(NSTextAlignment)alignment;
@end

#pragma mark - Category UIButton & FUIButton
@interface UIButton (AdvancedInitialization)
+ (UIButton *)ButtonWithTitle:(NSString *)title inBold:(BOOL)IsBold horizontalAlign:(UIControlContentHorizontalAlignment)horizontalAlign;
@end

@interface FUIButton (AdvancedInitialization)
+ (FUIButton *)ButtonWithTitle:(NSString *)title inBold:(BOOL)IsBold;
@end

#pragma mark - Category UIImageView
@interface UIImageView (AdvancedInitialization)
+ (UIImageView *)ImageViewWithDefaultBackgroundImage:(UIImage *)image;
@end

#pragma mark - Category UITextField
@interface UITextField (AdvancedInitialization)
+ (UITextField *)TextFieldWithPlaceHolder:(NSString *)placeHolder keyboardType:(UIKeyboardType)keyboardType;
@end










