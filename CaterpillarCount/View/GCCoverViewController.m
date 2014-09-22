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

@end

@implementation GCCoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.frame = [[UIScreen mainScreen] bounds];
    
    GCCoverView *coverView = [[GCCoverView alloc] init];
    
    
    
}









- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
