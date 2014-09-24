//
//  GCCoverView.m
//  CaterpillarCount
//
//  Created by Golden Compass on 9/21/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import "GCCoverView.h"
#import "GCCoverViewController.h"

@interface GCCoverView ()
@property FUIButton *btn_Start;

@end

@implementation GCCoverView

- (id)initWithParentController:(GCCoverViewController *)controller
{
    self = [super init];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor redColor];
        [controller.view addSubview:self];
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(controller.view.mas_top);
            make.left.equalTo(controller.view.mas_left);
            make.right.equalTo(controller.view.mas_right);
            make.bottom.equalTo(controller.view.mas_bottom);
        }];
        
        self.btn_Start = [[FUIButton alloc] init];
        self.btn_Start.buttonColor = [UIColor turquoiseColor];
        self.btn_Start.shadowColor = [UIColor greenSeaColor];
        self.btn_Start.shadowHeight = 1.0f;
        self.btn_Start.cornerRadius = 6.0f;
        self.btn_Start.titleLabel.font = [UIFont boldFlatFontOfSize:16];
        [self.btn_Start setTitle:@"Start" forState:UIControlStateNormal];
        [self.btn_Start setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
        [self.btn_Start setTitleColor:[UIColor cloudsColor] forState:UIControlStateHighlighted];
        [self addSubview:self.btn_Start];
        [self.btn_Start mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(200, 50));
            make.centerX.equalTo(self.mas_centerX);
            make.bottom.equalTo(self.mas_bottom).with.offset(-50);
        }];
    }
    return self;
}



- (void)drawRect:(CGRect)rect{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect myFrame = self.bounds;
    CGContextSetLineWidth(context, 10);
    CGRectInset(myFrame, 5, 5);
    [[UIColor redColor] set];
    UIRectFrame(myFrame);
    

}


@end
