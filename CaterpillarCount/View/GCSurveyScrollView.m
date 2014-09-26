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
        [self.parentController.view addSubview:self];
        
        // General Layout Metrics
        UIEdgeInsets padding_large = UIEdgeInsetsMake(20, 20, -20, -20);
        UIEdgeInsets padding_small = UIEdgeInsetsMake(5, 5, -5, -5);
        CGFloat FontSize_h1 = 20.0;
        CGFloat FontSize_h2 = 16.0;
        CGFloat FontSize_p1 = 14.0;
        CGFloat WidthForEntryfieldBorder = 1.0;
        
#pragma mark - Content Initialization
        // Temp, Time, Date Label
        self.label_Temp = [[UILabel alloc] init];
        self.label_Temp.textAlignment = NSTextAlignmentCenter;
        [self.label_Temp setFont:[UIFont boldSystemFontOfSize:FontSize_h2]];
        [self.label_Temp setBackgroundColor:[UIColor clearColor]];
        [self.label_Temp setTextColor:[GCAppAPI getColorWithRGBAinHex:ThemeColor01]];
        [self.label_Temp setText:@"Temp"];
        [self addSubview:self.label_Temp];
        
        self.label_Time = [[UILabel alloc] init];
        self.label_Time.textAlignment = NSTextAlignmentCenter;
        [self.label_Time setFont:[UIFont boldSystemFontOfSize:FontSize_h2]];
        [self.label_Time setBackgroundColor:[UIColor clearColor]];
        [self.label_Time setTextColor:[GCAppAPI getColorWithRGBAinHex:ThemeColor01]];
        [self.label_Time setText:@"Time"];
        [self addSubview:self.label_Time];
        
        self.label_Date = [[UILabel alloc] init];
        self.label_Date.textAlignment = NSTextAlignmentCenter;
        [self.label_Date setFont:[UIFont boldSystemFontOfSize:FontSize_h2]];
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
        self.entry_Temp.layer.cornerRadius = 10;
        self.entry_Temp.clipsToBounds = YES;
        [self addSubview:self.entry_Temp];
        
        self.entry_Time = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [self.entry_Time setTitle:@"xxxxxxxx" forState:UIControlStateNormal];
        self.entry_Time.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:FontSize_p1];
        [self.entry_Time setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.entry_Time.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [[self.entry_Time layer] setBorderWidth:WidthForEntryfieldBorder];
        [[self.entry_Time layer] setBorderColor:[UIColor lightGrayColor].CGColor];
        self.entry_Time.layer.cornerRadius = 10;
        self.entry_Time.clipsToBounds = YES;
        [self addSubview:self.entry_Time];
        
        self.entry_Date = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [self.entry_Date setTitle:@"sssssss" forState:UIControlStateNormal];
        self.entry_Date.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:FontSize_p1];
        [self.entry_Date setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.entry_Date.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [[self.entry_Date layer] setBorderWidth:WidthForEntryfieldBorder];
        [[self.entry_Date layer] setBorderColor:[UIColor lightGrayColor].CGColor];
        self.entry_Date.layer.cornerRadius = 10;
        self.entry_Date.clipsToBounds = YES;
        [self addSubview:self.entry_Date];
        
#pragma mark - Content Layout
        // Temp, Time, Date Label
        [self.label_Temp mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).with.offset(padding_large.top);
            make.left.equalTo(self.mas_left).with.offset(padding_large.left);
        }];
        [self.label_Time mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).with.offset(padding_large.top);
            make.left.equalTo(self.label_Temp.mas_right);
            make.width.equalTo(self.label_Temp.mas_width);
            make.centerX.equalTo(self.mas_centerX);
        }];
        [self.label_Date mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).with.offset(padding_large.top);
            make.left.equalTo(self.label_Time.mas_right);
            make.right.equalTo(self.mas_right).with.offset(padding_large.right);
            make.width.equalTo(self.label_Time.mas_width);
        }];
        
        // Temp, Time, Date Entry
        [self.entry_Temp mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.label_Temp.mas_bottom).with.offset(padding_small.top);
            make.left.equalTo(self.mas_left).with.offset(padding_large.left);
            make.bottom.equalTo(self.mas_bottom).with.offset(padding_large.bottom);
        }];
        [self.entry_Time mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.label_Time.mas_bottom).with.offset(padding_small.top);
            make.left.equalTo(self.entry_Temp.mas_right).with.offset(padding_small.left);
            make.bottom.equalTo(self.mas_bottom).with.offset(padding_large.bottom);
            make.right.equalTo(self.entry_Date.mas_left).with.offset(padding_small.right);
            make.width.equalTo(self.entry_Temp.mas_width);
            make.centerX.equalTo(self.mas_centerX);
        }];
        [self.entry_Date mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.label_Date.mas_bottom).with.offset(padding_small.top);
            make.right.equalTo(self.mas_right).with.offset(padding_large.right);
            make.width.equalTo(self.entry_Time.mas_width);
        }];
        
        
    }
    return self;
    
}





@end
