//
//  GCSurveyScrollView.m
//  CaterpillarCount
//
//  Created by Golden Compass on 9/24/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import "GCSurveyViewController.h"
#import "GCSurveyScrollView.h"


@interface GCSurveyScrollView ()
@property GCAppAPI *AppAPI;
@property GCSurveyViewController *parentController;



@end

@implementation GCSurveyScrollView

- (id)initWithParentController:(GCSurveyViewController *)controller
{
    self = [super init];
    if (self) {
        // Initialization code
        self.AppAPI = [GCAppAPI sharedInstance];
        self.parentController = controller;
        self.backgroundColor = [UIColor whiteColor];
        self.frame = ScreenBounds;
        self.delegate = self;
        [self.parentController.view addSubview:self];
        
        // General Layout Metrics
        UIEdgeInsets Padding_Page_Large = UIEdgeInsetsMake(20, 20, -20, -20);
        UIEdgeInsets Padding_Page_Small = UIEdgeInsetsMake(5, 5, -5, -5);
        UIEdgeInsets Insets_Button = UIEdgeInsetsMake(8, 10, 8, 10);
        CGFloat FontSize_h1 = 18.0;
        CGFloat FontSize_h2 = 16.0;
        CGFloat FontSize_p1 = 16.0;
        CGFloat WidthForEntryfieldBorder = 1.0;
        CGFloat CornerRadiusForButton = 10.0;
        
#pragma mark - Content Initialization
        // Temp, Time, Date Label
        self.label_Temp = [[UILabel alloc] init];
        self.label_Temp.textAlignment = NSTextAlignmentCenter;
        [self.label_Temp setFont:[UIFont fontWithName:@"Helvetica" size:FontSize_p1]];
//        [self.label_Temp setFont:[UIFont boldSystemFontOfSize:FontSize_h2]];
        [self.label_Temp setBackgroundColor:[UIColor clearColor]];
        [self.label_Temp setTextColor:[GCAppAPI getColorWithRGBAinHex:ThemeColor01]];
        [self.label_Temp setText:@"Temp"];
        [self addSubview:self.label_Temp];
        
        self.label_Time = [[UILabel alloc] init];
        self.label_Time.textAlignment = NSTextAlignmentCenter;
        [self.label_Time setFont:[UIFont fontWithName:@"Helvetica" size:FontSize_p1]];
        [self.label_Time setBackgroundColor:[UIColor clearColor]];
        [self.label_Time setTextColor:[GCAppAPI getColorWithRGBAinHex:ThemeColor01]];
        [self.label_Time setText:@"Time"];
        [self addSubview:self.label_Time];
        
        self.label_Date = [[UILabel alloc] init];
        self.label_Date.textAlignment = NSTextAlignmentCenter;
        [self.label_Date setFont:[UIFont fontWithName:@"Helvetica" size:FontSize_p1]];
        [self.label_Date setBackgroundColor:[UIColor clearColor]];
        [self.label_Date setTextColor:[GCAppAPI getColorWithRGBAinHex:ThemeColor01]];
        [self.label_Date setText:@"Date"];
        [self addSubview:self.label_Date];
        
        // Temp, Time, Date Entry
        self.entry_Temp = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [self.entry_Temp setTitle:@"70 F" forState:UIControlStateNormal];
        self.entry_Temp.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:FontSize_p1];
        [self.entry_Temp setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.entry_Temp.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [[self.entry_Temp layer] setBorderWidth:WidthForEntryfieldBorder];
        [[self.entry_Temp layer] setBorderColor:[UIColor lightGrayColor].CGColor];
        self.entry_Temp.layer.cornerRadius = CornerRadiusForButton;
        self.entry_Temp.clipsToBounds = YES;
        [self addSubview:self.entry_Temp];

        self.entry_Time = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [self.entry_Time setTitle:@"System Time" forState:UIControlStateNormal];
        self.entry_Time.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:FontSize_p1];
        [self.entry_Time setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.entry_Time.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [[self.entry_Time layer] setBorderWidth:WidthForEntryfieldBorder];
        [[self.entry_Time layer] setBorderColor:[UIColor lightGrayColor].CGColor];
        self.entry_Time.layer.cornerRadius = CornerRadiusForButton;
        self.entry_Time.clipsToBounds = YES;
        [self addSubview:self.entry_Time];
        NSDate *currentTime = [NSDate date];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"hh:mm a"];
        NSString *timeString = [dateFormatter stringFromDate: currentTime];
        [self.entry_Time setTitle:timeString forState:UIControlStateNormal];
        
        self.entry_Date = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [self.entry_Date setTitle:@"sssssss" forState:UIControlStateNormal];
        self.entry_Date.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:FontSize_p1];
        [self.entry_Date setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.entry_Date.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [[self.entry_Date layer] setBorderWidth:WidthForEntryfieldBorder];
        [[self.entry_Date layer] setBorderColor:[UIColor lightGrayColor].CGColor];
        self.entry_Date.layer.cornerRadius = CornerRadiusForButton;
        self.entry_Date.clipsToBounds = YES;
        [self addSubview:self.entry_Date];
        
        // Site Information
        self.label_SiteInfo = [[UILabel alloc] init];
        self.label_SiteInfo.textAlignment = NSTextAlignmentLeft;
        [self.label_SiteInfo setFont:[UIFont fontWithName:@"Helvetica-Bold" size:FontSize_h1]];
        [self.label_SiteInfo setBackgroundColor:[UIColor clearColor]];
        [self.label_SiteInfo setTextColor:[GCAppAPI getColorWithRGBAinHex:ThemeColor01]];
        [self.label_SiteInfo setText:@"Site Information"];
        [self addSubview:self.label_SiteInfo];
        
        // Site
        self.label_Site = [[UILabel alloc] init];
        self.label_Site.textAlignment = NSTextAlignmentLeft;
        [self.label_Site setFont:[UIFont fontWithName:@"Helvetica" size:FontSize_p1]];
        [self.label_Site setBackgroundColor:[UIColor clearColor]];
        [self.label_Site setTextColor:[GCAppAPI getColorWithRGBAinHex:ThemeColor01]];
        [self.label_Site setText:@"Site"];
        [self addSubview:self.label_Site];
        
        self.entry_Site = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.entry_Site.contentEdgeInsets = Insets_Button;
        [self.entry_Site setTitle:@"Click to choose a site" forState:UIControlStateNormal];
        self.entry_Site.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:FontSize_p1];
        [self.entry_Site setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.entry_Site.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [[self.entry_Site layer] setBorderWidth:WidthForEntryfieldBorder];
        [[self.entry_Site layer] setBorderColor:[UIColor lightGrayColor].CGColor];
        self.entry_Site.layer.cornerRadius = CornerRadiusForButton;
        self.entry_Site.clipsToBounds = YES;
        [self addSubview:self.entry_Site];
        
        // Circle
        self.label_Circle = [[UILabel alloc] init];
        self.label_Circle.textAlignment = NSTextAlignmentLeft;
        [self.label_Circle setFont:[UIFont fontWithName:@"Helvetica" size:FontSize_p1]];
        [self.label_Circle setBackgroundColor:[UIColor clearColor]];
        [self.label_Circle setTextColor:[GCAppAPI getColorWithRGBAinHex:ThemeColor01]];
        [self.label_Circle setText:@"Circle"];
        [self addSubview:self.label_Circle];
        
        self.entry_Circle = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.entry_Circle.contentEdgeInsets = Insets_Button;
        [self.entry_Circle setTitle:@"Click to choose a circle" forState:UIControlStateNormal];
        self.entry_Circle.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:FontSize_p1];
        [self.entry_Circle setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.entry_Circle.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [[self.entry_Circle layer] setBorderWidth:WidthForEntryfieldBorder];
        [[self.entry_Circle layer] setBorderColor:[UIColor lightGrayColor].CGColor];
        self.entry_Circle.layer.cornerRadius = CornerRadiusForButton;
        self.entry_Circle.clipsToBounds = YES;
        [self addSubview:self.entry_Circle];
        
        // Survey
        self.label_Survey = [[UILabel alloc] init];
        self.label_Survey.textAlignment = NSTextAlignmentLeft;
        [self.label_Survey setFont:[UIFont fontWithName:@"Helvetica" size:FontSize_p1]];
        [self.label_Survey setBackgroundColor:[UIColor clearColor]];
        [self.label_Survey setTextColor:[GCAppAPI getColorWithRGBAinHex:ThemeColor01]];
        [self.label_Survey setText:@"Survey"];
        [self addSubview:self.label_Survey];
        
        self.entry_Survey = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.entry_Survey.contentEdgeInsets = Insets_Button;
        [self.entry_Survey setTitle:@"Click to choose a survey" forState:UIControlStateNormal];
        self.entry_Survey.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:FontSize_p1];
        [self.entry_Survey setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.entry_Survey.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [[self.entry_Survey layer] setBorderWidth:WidthForEntryfieldBorder];
        [[self.entry_Survey layer] setBorderColor:[UIColor lightGrayColor].CGColor];
        self.entry_Survey.layer.cornerRadius = CornerRadiusForButton;
        self.entry_Survey.clipsToBounds = YES;
        [self addSubview:self.entry_Survey];
        
        // Arthropod Order Info
        self.label_ArthropodOrderInfo = [[UILabel alloc] init];
        self.label_ArthropodOrderInfo.textAlignment = NSTextAlignmentLeft;
        [self.label_ArthropodOrderInfo setFont:[UIFont fontWithName:@"Helvetica-Bold" size:FontSize_h1]];
        [self.label_ArthropodOrderInfo setBackgroundColor:[UIColor clearColor]];
        [self.label_ArthropodOrderInfo setTextColor:[GCAppAPI getColorWithRGBAinHex:ThemeColor01]];
        [self.label_ArthropodOrderInfo setText:@"Arthropod Order Info"];
        [self addSubview:self.label_ArthropodOrderInfo];
        
        // New Order Info Button
        self.btn_NewOrderInfo = [[FUIButton alloc] init];
        self.btn_NewOrderInfo.buttonColor = [GCAppAPI getColorWithRGBAinHex:ThemeColor01];
        self.btn_NewOrderInfo.shadowColor = [UIColor greenSeaColor];
        self.btn_NewOrderInfo.shadowHeight = 1.0f;
        self.btn_NewOrderInfo.cornerRadius = 6.0f;
        self.btn_NewOrderInfo.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:FontSize_h1];
        [self.btn_NewOrderInfo setTitle:@"New" forState:UIControlStateNormal];
        [self.btn_NewOrderInfo setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
        [self.btn_NewOrderInfo setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [self addSubview:self.btn_NewOrderInfo];
        [[self.btn_NewOrderInfo rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            NSLog(@"add order button tapped");
        }];
        
        
#pragma mark - Content Layout
        // Temp, Time, Date Label
        [self.label_Temp mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).with.offset(Padding_Page_Large.top);
            make.left.equalTo(self.mas_left).with.offset(Padding_Page_Large.left);
        }];
        [self.label_Time mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).with.offset(Padding_Page_Large.top);
            make.left.equalTo(self.label_Temp.mas_right);
            make.width.equalTo(self.label_Temp.mas_width);
            make.centerX.equalTo(self.mas_centerX);
        }];
        [self.label_Date mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).with.offset(Padding_Page_Large.top);
            make.left.equalTo(self.label_Time.mas_right);
            make.right.equalTo(self.mas_right).with.offset(Padding_Page_Large.right);
            make.width.equalTo(self.label_Time.mas_width);
        }];
        
        // Temp, Time, Date Entry
        [self.entry_Temp mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.label_Temp.mas_bottom).with.offset(Padding_Page_Small.top);
            make.left.equalTo(self.mas_left).with.offset(Padding_Page_Large.left);
            make.bottom.equalTo(self.label_SiteInfo.mas_top).with.offset(Padding_Page_Large.bottom);
        }];
        [self.entry_Time mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.label_Time.mas_bottom).with.offset(Padding_Page_Small.top);
            make.left.equalTo(self.entry_Temp.mas_right).with.offset(Padding_Page_Small.left);
            make.bottom.equalTo(self.label_SiteInfo.mas_top).with.offset(Padding_Page_Large.bottom);
            make.right.equalTo(self.entry_Date.mas_left).with.offset(Padding_Page_Small.right);
            make.width.equalTo(self.entry_Temp.mas_width);
            make.centerX.equalTo(self.mas_centerX);
        }];
        [self.entry_Date mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.label_Date.mas_bottom).with.offset(Padding_Page_Small.top);
            make.right.equalTo(self.mas_right).with.offset(Padding_Page_Large.right);
            make.bottom.equalTo(self.label_SiteInfo.mas_top).with.offset(Padding_Page_Large.bottom);
            make.width.equalTo(self.entry_Time.mas_width);
        }];
        
        // Site Information
        [self.label_SiteInfo mas_makeConstraints:^(MASConstraintMaker *make) {
            // top is defined by three entries above
            make.left.equalTo(self.mas_left).with.offset(Padding_Page_Large.left);
            make.right.equalTo(self.mas_right).with.offset(Padding_Page_Large.right);
        }];
        // Site
        [self.label_Site mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.label_SiteInfo.mas_bottom).with.offset(Padding_Page_Small.top);
            make.left.equalTo(self.mas_left).with.offset(Padding_Page_Large.left);
            make.right.equalTo(self.mas_right).with.offset(Padding_Page_Large.right);
        }];
        [self.entry_Site mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.label_Site.mas_bottom).with.offset(Padding_Page_Small.top);
            make.left.equalTo(self.mas_left).with.offset(Padding_Page_Large.left);
            make.right.equalTo(self.mas_right).with.offset(Padding_Page_Large.right);
        }];
        // Circle
        [self.label_Circle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.entry_Site.mas_bottom).with.offset(Padding_Page_Small.top);
            make.left.equalTo(self.mas_left).with.offset(Padding_Page_Large.left);
            make.right.equalTo(self.mas_right).with.offset(Padding_Page_Large.right);
        }];
        [self.entry_Circle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.label_Circle.mas_bottom).with.offset(Padding_Page_Small.top);
            make.left.equalTo(self.mas_left).with.offset(Padding_Page_Large.left);
            make.right.equalTo(self.mas_right).with.offset(Padding_Page_Large.right);
        }];
        // Survey
        [self.label_Survey mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.entry_Circle.mas_bottom).with.offset(Padding_Page_Small.top);
            make.left.equalTo(self.mas_left).with.offset(Padding_Page_Large.left);
            make.right.equalTo(self.mas_right).with.offset(Padding_Page_Large.right);
        }];
        [self.entry_Survey mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.label_Survey.mas_bottom).with.offset(Padding_Page_Small.top);
            make.left.equalTo(self.mas_left).with.offset(Padding_Page_Large.left);
            make.right.equalTo(self.mas_right).with.offset(Padding_Page_Large.right);
        }];
        
        // Arthropod Order Info
        [self.label_ArthropodOrderInfo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.entry_Survey.mas_bottom).with.offset(Padding_Page_Large.top);
            make.left.equalTo(self.mas_left).with.offset(Padding_Page_Large.left);
            make.bottom.equalTo(self.mas_bottom).with.offset(Padding_Page_Large.bottom);
            make.height.mas_equalTo(20);
        }];
        // Add button
        [self.btn_NewOrderInfo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.entry_Survey.mas_bottom).with.offset(Padding_Page_Large.top);
            make.left.equalTo(self.label_ArthropodOrderInfo.mas_right);
            make.right.equalTo(self.mas_right).with.offset(Padding_Page_Large.right);
            make.size.mas_equalTo(CGSizeMake(80, 23));
//            make.bottom.equalTo(self.mas_bottom);
        }];
        
    }
    return self;
    
}






@end
