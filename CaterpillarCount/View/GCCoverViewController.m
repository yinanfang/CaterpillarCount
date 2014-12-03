//
//  GCCoverViewController.m
//  CaterpillarCount
//
//  Created by Golden Compass on 9/21/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import "GCCoverViewController.h"
#import "GCSurveyViewController.h"
#import "GCCoverView.h"

@interface GCCoverViewController ()
@property GCCoverView *coverView;

@end

@implementation GCCoverViewController
/**
 *  test doc
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    self.coverView = [[GCCoverView alloc] initWithParentController:self];
    [self.coverView setNeedsUpdateConstraints];
    [self.coverView updateConstraintsIfNeeded];
}

- (void)viewWillAppear:(BOOL)animated
{
//    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Enter" style:UIBarButtonItemStyleBordered target:self action:@selector(enterDirectly)];
//    self.navigationItem.rightBarButtonItem = rightButton;
    
    self.navigationController.navigationBar.hidden = YES;
}
//- (void)enterDirectly
//{
//    GCSurveyViewController *surveyViewController = [[GCSurveyViewController alloc] init];
//    [self.navigationController pushViewController:surveyViewController animated:YES];
//}

- (BOOL)prefersStatusBarHidden {
    return NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
