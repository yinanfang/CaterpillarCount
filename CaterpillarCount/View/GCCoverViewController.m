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
    self.coverView = [[GCCoverView alloc] initWithParentController:self];
    [self.coverView setNeedsUpdateConstraints];
    [self.coverView updateConstraintsIfNeeded];

}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
//    DDLogVerbose(@"touchesBegan:withEvent:");
//    DDLogVerbose(@"controller.view.frame = %@", [NSValue valueWithCGRect:[[UIScreen mainScreen] bounds]]);
//    DDLogVerbose(@"screen height = %f", ScreenHeight);
//    DDLogVerbose(@"screen width = %f", ScreenWidth);
    [super touchesBegan:touches withEvent:event];
}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = YES;
}
- (BOOL)prefersStatusBarHidden {
    return NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
