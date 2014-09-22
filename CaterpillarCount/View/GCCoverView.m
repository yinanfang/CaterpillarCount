//
//  GCCoverView.m
//  CaterpillarCount
//
//  Created by Golden Compass on 9/21/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import "GCCoverView.h"
#import "FUIButton.h"
@interface GCCoverView ()

@property FUIButton *btn_Start;

@end

@implementation GCCoverView


- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code
        
        [self.superview addSubview:self];
//        [self mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.superview.mas_top); //with is an optional semantic filler
//            make.left.equalTo(self.superview.mas_left);
//            make.bottom.equalTo(self.superview.mas_bottom);
//            make.right.equalTo(self.superview.mas_right);
//        }];
        self.frame = ScreenBounds;
        
        self.btn_Start = [[FUIButton alloc] init];
        self.btn_Start.buttonColor = [UIColor turquoiseColor];
        self.btn_Start.shadowColor = [UIColor greenSeaColor];
        self.btn_Start.shadowHeight = 3.0f;
        self.btn_Start.cornerRadius = 6.0f;
        self.btn_Start.titleLabel.font = [UIFont boldFlatFontOfSize:16];
        [self.btn_Start setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
        [self.btn_Start setTitleColor:[UIColor cloudsColor] forState:UIControlStateHighlighted];
        [self addSubview:self.btn_Start];
        self.btn_Start.frame = CGRectMake(0, 0, 100, 100);
        
//        [self.btn_Start mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.size.mas_equalTo(CGSizeMake(60, 100));
//            make.center.equalTo(self.mas_centerX);
//            make.bottom.equalTo(self.mas_bottom).with.offset(-80);
//        }];
        
        
        
    }
    return self;
}


@end
