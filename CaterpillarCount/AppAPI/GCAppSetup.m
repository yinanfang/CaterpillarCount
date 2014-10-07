//
//  GCAppSetup.m
//  CaterpillarCount
//
//  Created by Golden Compass on 10/6/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import "GCAppSetup.h"

@implementation GCAppSetup

+ (void)configureNavigationViewController:(UIViewController *)viewcontroller withNavigationTitle:(NSString *)title
{
    // Set Title
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 120, 30)];
    label.textAlignment = NSTextAlignmentCenter;
    [label setFont:[UIFont boldSystemFontOfSize:16.0]];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setTextColor:[UIColor whiteColor]];
    [label setText:title];
    viewcontroller.navigationItem.titleView = label;
    [label sizeToFit];
    // Back Button
    
    UIButton *backButton = [[UIButton alloc] initWithFrame: CGRectMake(0, 0, 20.0f, 30.0f)];
    backButton.backgroundColor = [UIColor clearColor];
    [backButton setTitle:@"<" forState:UIControlStateNormal];
    [backButton.titleLabel setFont:[UIFont fontWithName:@"Helvetica" size:20]];
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    viewcontroller.navigationItem.leftBarButtonItem = backButtonItem;
    viewcontroller.navigationController.interactivePopGestureRecognizer.delegate = (id<UIGestureRecognizerDelegate>)self;
    [[backButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [viewcontroller.navigationController popViewControllerAnimated:YES];
    }];
}

+ (void)setConstraints_FillFullScreenWithView:(UIView *)view superview:(UIView *)superview
{
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(superview.mas_top);
        make.left.equalTo(superview.mas_left);
        make.bottom.equalTo(superview.mas_bottom);
        make.right.equalTo(superview.mas_right);
    }];
}
+ (void)setConstraints_PinHorizontallyWithPagePaddingAndTopWithPadding:(PagePaddingOption)paddingOption withView:(UIView *)view superview:(UIView *)superview upperview:(UIView *)upperview;
{
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        if (paddingOption==PagePaddingLarge) {
            make.top.equalTo(upperview.mas_bottom).with.offset(Padding_Page_Large.top);
        }else{
            make.top.equalTo(upperview.mas_bottom).with.offset(Padding_Page_Small.top);
        }
        make.left.equalTo(superview.mas_left).with.offset(Padding_Page_Large.left);
        make.right.equalTo(superview.mas_right).with.offset(Padding_Page_Large.right);
    }];

}

@end


@implementation UILabel (AdvancedInitialization)
+ (UILabel *)LabelTitleWithString:(NSString *)title align:(NSTextAlignment)alignment
{
    UILabel *label = [[UILabel alloc] init];
    label.textAlignment = alignment;
    [label setFont:[UIFont fontWithName:@"Helvetica-Bold" size:FontSize_h1]];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setTextColor:[GCAppAPI getColorWithRGBAinHex:ThemeColor01]];
    [label setText:title];
    return label;
}

+ (UILabel *)LabelSubTitleWithString:(NSString *)title align:(NSTextAlignment)alignment
{
    UILabel *label = [[UILabel alloc] init];
    label.textAlignment = alignment;
    [label setFont:[UIFont fontWithName:@"Helvetica" size:FontSize_p1]];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setTextColor:[GCAppAPI getColorWithRGBAinHex:ThemeColor01]];
    [label setText:title];
    return label;
}
@end


@implementation UIButton (AdvancedInitialization)
+ (UIButton *)ButtonWithTitle:(NSString *)title inBold:(BOOL)IsBold horizontalAlign:(UIControlContentHorizontalAlignment)horizontalAlign
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.contentEdgeInsets = Insets_Button;
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    if (IsBold) {
        button.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:FontSize_p1];
    }else{
        button.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:FontSize_p1];
    }
    button.contentHorizontalAlignment = horizontalAlign;
    button.layer.borderWidth = WidthForEntryfieldBorder;
    button.layer.borderColor = [UIColor lightGrayColor].CGColor;
    button.layer.cornerRadius = CornerRadius_General;
    button.clipsToBounds = YES;
    return button;
}
@end

@implementation FUIButton (AdvancedInitialization)
+ (FUIButton *)ButtonWithTitle:(NSString *)title inBold:(BOOL)IsBold
{
    FUIButton *button = [[FUIButton alloc] init];
    button.buttonColor = [GCAppAPI getColorWithRGBAinHex:ThemeColor01];
    button.shadowColor = [GCAppAPI getColorWithRGBAinHex:ThemeColor01_Variation01];
    button.shadowHeight = 1.0f;
    button.cornerRadius = 6.0f;
    if (IsBold) {
        button.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:FontSize_p1];
    }else{
        button.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:FontSize_p1];
    }
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    return button;
}
@end

@implementation UITextField (AdvancedInitialization)
+ (UITextField *)TextFieldWithPlaceHolder:(NSString *)placeHolder keyboardType:(UIKeyboardType)keyboardType
{
    UITextField *textField = [[UITextField alloc] init];
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.font = [UIFont systemFontOfSize:FontSize_p1];
    textField.placeholder = placeHolder;
    textField.autocorrectionType = UITextAutocorrectionTypeYes;
    textField.keyboardType = keyboardType;
    textField.returnKeyType = UIReturnKeyDone;
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    textField.contentVerticalAlignment = UIControlContentHorizontalAlignmentLeft;
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    return textField;
}
@end










