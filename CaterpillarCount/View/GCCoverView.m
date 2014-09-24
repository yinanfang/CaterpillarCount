//
//  GCCoverView.m
//  CaterpillarCount
//
//  Created by Golden Compass on 9/21/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import "GCCoverView.h"
#import "GCCoverViewController.h"
#import "GCSurveyViewController.h"

@interface GCCoverView ()
@property GCAppAPI *AppAPI;
@property GCCoverViewController *parentController;
@property FUIButton *btn_Start;


@end

@implementation GCCoverView

- (id)initWithParentController:(GCCoverViewController *)controller
{
    self = [super init];
    if (self) {
        // Initialization code
        self.AppAPI = [GCAppAPI sharedInstance];
        self.parentController = controller;
        self.backgroundColor = [UIColor whiteColor];
        self.frame = ScreenBounds;
        [controller.view addSubview:self];

        // Start Button
        self.btn_Start = [[FUIButton alloc] init];
        self.btn_Start.buttonColor = [self.AppAPI getColorWithRGBAinHex:ThemeColor01];
//        self.btn_Start.buttonColor = [UIColor grayColor];
        self.btn_Start.shadowColor = [UIColor greenSeaColor];
        self.btn_Start.shadowHeight = 1.0f;
        self.btn_Start.cornerRadius = 6.0f;
        self.btn_Start.titleLabel.font = [UIFont boldFlatFontOfSize:16];
        [self.btn_Start setTitle:@"Start" forState:UIControlStateNormal];
        [self.btn_Start setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
        [self.btn_Start setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [self addSubview:self.btn_Start];
        [self.btn_Start mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(200, 50));
            make.centerX.equalTo(self.mas_centerX);
            make.bottom.equalTo(self.mas_bottom).with.offset(-50);
        }];
        [[self.btn_Start rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            NSLog(@"button tapped");
            GCSurveyViewController *surveyViewController = [[GCSurveyViewController alloc] init];
            surveyViewController.view.frame = [[UIScreen mainScreen] bounds];
            [self.parentController.navigationController pushViewController:surveyViewController animated:YES];
        }];
    }
    return self;
}




@end
