//
//  GCCoverViewController.m
//  CaterpillarCount
//
//  Created by Golden Compass on 9/21/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import "GCCoverViewController.h"
#import "GCCoverView.h"

@interface GCCoverViewController ()
@property GCCoverView *coverView;

@end

@implementation GCCoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.frame = ScreenBounds;
    self.navigationController.navigationBar.hidden = YES;
    self.coverView = [[GCCoverView alloc] initWithParentController:self];

    
}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = YES;
}
//- (BOOL)prefersStatusBarHidden {
//    return YES;
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
