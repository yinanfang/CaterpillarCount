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


// Font, size, and style
+ (void)configureNavigationViewController:(UIViewController *)viewcontroller withNavigationTitle:(NSString *)title;
+ (void)setConstraints_FillFullScreenWithView:(UIView *)view superview:(UIView *)superview;
+ (void)setConstraints_PinHorizontallyWithPagePaddingAndTopWithPadding:(PagePaddingOption)paddingOption withView:(UIView *)view superview:(UIView *)superview upperview:(UIView *)upperview;


@end


@interface UILabel (AdvancedInitialization)
+ (UILabel *)LabelTitleWithString:(NSString *)title align:(NSTextAlignment)alignment;
+ (UILabel *)LabelSubTitleWithString:(NSString *)title align:(NSTextAlignment)alignment;
@end

@interface UIButton (AdvancedInitialization)
+ (UIButton *)ButtonWithTitle:(NSString *)title inBold:(BOOL)IsBold horizontalAlign:(UIControlContentHorizontalAlignment)horizontalAlign;
@end

@interface FUIButton (AdvancedInitialization)
+ (FUIButton *)ButtonWithTitle:(NSString *)title inBold:(BOOL)IsBold;
@end

@interface UITextField (AdvancedInitialization)
+ (UITextField *)TextFieldWithPlaceHolder:(NSString *)placeHolder keyboardType:(UIKeyboardType)keyboardType;
@end