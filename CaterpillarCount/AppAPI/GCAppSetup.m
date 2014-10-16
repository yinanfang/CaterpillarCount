//
//  GCAppSetup.m
//  CaterpillarCount
//
//  Created by Golden Compass on 10/6/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import "GCAppSetup.h"

@implementation GCAppSetup

#pragma mark - Basic Setup
+ (void)setupApplicationWithProductionMode:(BOOL)mode
{
    // Logging
    [self setupLogging];
    DDLogInfo(@"====================  Application Setup Started  ====================");
    
    // Cache
    [self setCachePolicy];
    
    // Domain
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (mode) {
        DDLogInfo(@"In PRODUCTION mode with domain: %@", ProductionDomain);
        [defaults setObject:ProductionDomain forKey:@"current_domain"];
    }else {
        DDLogInfo(@"In Development mode with domain: %@", DevelopmentDomain);
        [defaults setObject:DevelopmentDomain forKey:@"current_domain"];
    }
}

+ (void)setCachePolicy
{
    // Disable Cache for the networking methods
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    [[NSURLCache sharedURLCache] setDiskCapacity:0];
    [[NSURLCache sharedURLCache] setMemoryCapacity:0];
}

+ (void)setupLogging
{
    // DDTTYLogger
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
    // And then enable colors
    // Add Environment Variable in "Edit scheme": XcodeColors YES
    // Follow the Issue Report: https://github.com/CocoaLumberjack/CocoaLumberjack/issues/50#issuecomment-34286656
    // Enables XcodeColors
    [[DDTTYLogger sharedInstance] setColorsEnabled:YES];
    // Set logger color
    [[DDTTYLogger sharedInstance] setForegroundColor:[UIColor redColor] backgroundColor:nil forFlag:LOG_FLAG_ERROR];
    [[DDTTYLogger sharedInstance] setForegroundColor:[UIColor purpleColor] backgroundColor:nil forFlag:LOG_FLAG_WARN];
    [[DDTTYLogger sharedInstance] setForegroundColor:[UIColor brownColor] backgroundColor:nil forFlag:LOG_FLAG_INFO];
    [[DDTTYLogger sharedInstance] setForegroundColor:[UIColor blackColor] backgroundColor:nil forFlag:LOG_FLAG_DEBUG];
    [[DDTTYLogger sharedInstance] setForegroundColor:[UIColor grayColor] backgroundColor:nil forFlag:LOG_FLAG_VERBOSE];
    // Test logger color
    DDLogError(@"DDLogError");
    DDLogWarn(@"DDLogWarn");
    DDLogInfo(@"DDLogInfo");
    DDLogDebug(@"DDLogDebug");
    DDLogVerbose(@"DDLogVerbose");
    DDLogTest(@"LogTest for XcodeColors");
    
    // DDASLLogger
    [DDLog addLogger:[DDASLLogger sharedInstance]];
    
    DDFileLogger *fileLogger = [[DDFileLogger alloc] init];
    [fileLogger setRollingFrequency:60 * 60 * 24];   // roll every day
    [fileLogger setMaximumFileSize:1024 * 1024 * 2]; // max 2mb file size
    [fileLogger.logFileManager setMaximumNumberOfLogFiles:7];
    [fileLogger setLogFormatter:[[CustomLogFormatters alloc] init]];
    
    [DDLog addLogger:fileLogger];
    DDLogInfo(@"Logging is setup (\"%@\")", [fileLogger.logFileManager logsDirectory]);
}

#pragma mark - Style, font, size
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
}

+ (void)configureBackButtonOfNavigationViewController:(UIViewController *)viewcontroller
{
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

+ (void)configureRightButtonOfNavigationViewController:(UIViewController *)viewcontroller
{
    // Back Button
    UIButton *rightButton = [[UIButton alloc] initWithFrame: CGRectMake(0, 0, 20.0f, 30.0f)];
    rightButton.backgroundColor = [UIColor clearColor];
    [rightButton setImage:[UIImage imageNamed:@"icon_menu"] forState:UIControlStateNormal];
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    viewcontroller.navigationItem.rightBarButtonItem = rightButtonItem;
    viewcontroller.navigationController.interactivePopGestureRecognizer.delegate = (id<UIGestureRecognizerDelegate>)self;
    [[rightButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
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
            make.top.equalTo(upperview.mas_bottom).with.offset(mas_Padding_Page_Large.top);
        }else{
            make.top.equalTo(upperview.mas_bottom).with.offset(mas_Padding_Page_Small.top);
        }
        make.left.equalTo(superview.mas_left).with.offset(mas_Padding_Page_Large.left);
        make.right.equalTo(superview.mas_right).with.offset(mas_Padding_Page_Large.right);
    }];

}

@end

#pragma mark - UIkit and Foundation extention
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

@implementation UIImageView (AdvancedInitialization)
+ (UIImageView *)ImageViewWithDefaultBackgroundImage:(UIImage *)image
{
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.backgroundColor = [UIColor lightGrayColor];
    if (image) {
        [imageView setImage:image];
    }
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.layer.cornerRadius = CornerRadius_General;
    imageView.clipsToBounds = YES;
    return imageView;
}
@end











