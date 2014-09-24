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
        

    }
    return self;
    
}





@end
