//
//  GCNewOrderViewController.m
//  CaterpillarCount
//
//  Created by Golden Compass on 9/28/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import "GCNewOrderViewController.h"

@interface GCNewOrderViewController ()

@end

@implementation GCNewOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.frame = ScreenBounds;
    
    // UI Navigation Bar
    [GCAppConfig configureNavigationViewController:self withNavigationTitle:@"New Arthropod Order"];
    
    // Add new order scroll view
    self.singleOrderScrollView = [[GCNewOrderScrollView alloc] initWithParentController:self];
    
    
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
