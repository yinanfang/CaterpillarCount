//
//  GCSignInScrollView.m
//  CaterpillarCount
//
//  Created by Golden Compass on 9/29/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import "GCSignInViewController.h"
#import "GCSignInScrollView.h"

@interface GCSignInScrollView ()


@end

@implementation GCSignInScrollView

- (id)initWithParentController:(GCSignInViewController *)controller
{
    self = [super init];
    if (self) {
        self.parentController = controller;
        self.backgroundColor = [UIColor whiteColor];
        self.delegate = self;
        [self.parentController.view addSubview:self];

        

    }
    return self;
}

- (void)updateConstraints
{
    if(!self.didSetupConstraints) {
        // Self
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.parentController.view.mas_top);
            make.left.equalTo(self.parentController.view.mas_left);
            make.bottom.equalTo(self.parentController.view.mas_bottom);
            make.right.equalTo(self.parentController.view.mas_right);
        }];
        
        // Register

        
        self.didSetupConstraints = YES;
    }
    [super updateConstraints];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
