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
//    self.view.frame = ScreenBounds;
//    [self.view mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.view.superview.mas_top);
//        make.left.equalTo(self.view.superview.mas_left);
//        make.bottom.equalTo(self.view.superview.mas_right);
//        make.right.equalTo(self.view.superview.mas_top);
//    }];
    self.navigationController.navigationBar.hidden = YES;
    self.coverView = [[GCCoverView alloc] initWithParentController:self];

    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    DDLogVerbose(@"touchesBegan:withEvent:");
    DDLogVerbose(@"controller.view.frame = %@", [NSValue valueWithCGRect:[[UIScreen mainScreen] bounds]]);
    DDLogVerbose(@"screen height = %f", ScreenHeight);
    DDLogVerbose(@"screen width = %f", ScreenWidth);

    [super touchesBegan:touches withEvent:event];
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
