//
//  GCSurveyViewController.m
//  CaterpillarCount
//
//  Created by Golden Compass on 9/24/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import "GCSurveyViewController.h"
#import "GCSurveyScrollView.h"

@interface GCSurveyViewController ()
@property GCAppAPI *AppAPI;
@property GCSurveyScrollView *surveyScrollView;


@end

@implementation GCSurveyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.AppAPI = [GCAppAPI sharedInstance];
    self.view.frame = ScreenBounds;
    
    // Set Title
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 120, 30)];
    label.textAlignment = NSTextAlignmentCenter;
    [label setFont:[UIFont boldSystemFontOfSize:16.0]];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setTextColor:[UIColor whiteColor]];
    [label setText:@"CaterpillarCount"];
    self.navigationItem.titleView = label;
    [label sizeToFit];
    
    
    
    self.surveyScrollView = [[GCSurveyScrollView alloc] initWithParentController:self];
    
    
    
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.barTintColor = [self.AppAPI getColorWithRGBAinHex:ThemeColor01];
    self.navigationController.navigationBar.hidden = NO;
}
- (BOOL)prefersStatusBarHidden {
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
