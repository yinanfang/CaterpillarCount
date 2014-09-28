//
//  GCNewOrderScrollView.m
//  CaterpillarCount
//
//  Created by Golden Compass on 9/28/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import "GCNewOrderScrollView.h"
#import "GCNewOrderViewController.h"

@interface GCNewOrderScrollView ()
@property GCNewOrderViewController *parentController;



@end

@implementation GCNewOrderScrollView



- (id)initWithParentController:(GCNewOrderViewController *)controller
{
    self = [super init];
    if (self) {
        self.parentController = controller;
        self.backgroundColor = [UIColor whiteColor];
        self.frame = ScreenBounds;
        self.delegate = self;
        [self.parentController.view addSubview:self];
        
    }
    return self;
    
}

@end
