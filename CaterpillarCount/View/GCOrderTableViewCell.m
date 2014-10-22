//
//  GCOrderTableViewCell.m
//  CaterpillarCount
//
//  Created by Golden Compass on 9/28/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import "GCOrderTableViewCell.h"

@implementation GCOrderTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Thumbnail picture
        self.captureImageView = [UIImageView ImageViewWithDefaultBackgroundImage:nil];
        [self.captureImageView setImage:[UIImage imageNamed:@"Checkmark"]];
        [self.contentView addSubview:self.captureImageView];
        // Order Name
        self.label_OrderName = [UILabel LabelSubTitleWithString:@"Order Name" align:NSTextAlignmentLeft];
        self.label_OrderName.backgroundColor = [UIColor blueColor];
        [self.contentView addSubview:self.label_OrderName];
        // Length
        self.label_Length = [UILabel LabelSubTitleWithString:@"Length" align:NSTextAlignmentLeft];
        self.label_Length.backgroundColor = [UIColor greenColor];
        [self.contentView addSubview:self.label_Length];
        // Count
        self.label_Count = [UILabel LabelSubTitleWithString:@"Count" align:NSTextAlignmentLeft];
        self.label_Count.backgroundColor = [UIColor yellowColor];
        [self.contentView addSubview:self.label_Count];
        // Notes
        self.label_Notes = [UILabel LabelSubTitleWithString:@"test message that should be ignore but is quite long, which is good for testing." align:NSTextAlignmentLeft];
        self.label_Notes.numberOfLines = 0;
        self.label_Notes.backgroundColor = [UIColor blackColor];
        [self.contentView addSubview:self.label_Notes];
        
        // Add and Minus Button
        self.btn_Add = [FUIButton ButtonWithTitle:@"+" inBold:YES];
        [self.contentView addSubview:self.btn_Add];
        self.btn_Minus = [FUIButton ButtonWithTitle:@"-" inBold:YES];
        [self.contentView addSubview:self.btn_Minus];
        
        self.contentView.backgroundColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:1];
        
    }
    return self;
}

- (void)updateConstraints
{
    NSLog(@"updateConstraints table cell.");
    if (!self.didSetupConstraints) {
        self.contentView.bounds = CGRectMake(0.0f, 0.0f, 1000.0f, 1000.0f);
        
        [self.label_OrderName setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
        [self.label_OrderName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).with.offset(mas_Padding_Page_Small.top);
            make.left.equalTo(self.contentView.mas_left).with.offset(mas_Padding_Page_Small.left);
            make.right.equalTo(self.contentView.mas_right).offset(mas_Padding_Page_Small.right);
            
            
        }];
        
//        [self.captureImageView setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
//        [self.captureImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.label_OrderName.mas_bottom).with.offset(mas_Padding_Page_Small.top);
//            make.left.equalTo(self.contentView.mas_left).with.offset(mas_Padding_Page_Small.left);
//            make.size.mas_equalTo(CGSizeMake(60, 60));
//            make.bottom.equalTo(self.contentView.mas_bottom).with.offset(mas_Padding_Page_Small.bottom).priority(999);
//        }];
//        
//        [self.label_Length setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
//        [self.label_Length mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.label_OrderName.mas_bottom).with.offset(mas_Padding_Page_Default.top);
//            make.leading.equalTo(self.captureImageView.mas_trailing).with.offset(mas_Padding_Page_Small.left).with.offset(mas_Padding_Page_Small.left);
//            make.trailing.equalTo(self.label_Count.mas_trailing);
//        }];
//        
//        [self.label_Count setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
//        [self.label_Count mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.label_Length.mas_bottom).with.offset(mas_Padding_Page_Small.top);
//            make.leading.equalTo(self.captureImageView.mas_trailing).with.offset(mas_Padding_Page_Small.left);
//            make.trailing.equalTo(self.label_Count.mas_trailing);
//            make.height.equalTo(self.label_Length.mas_height);
//        }];
//        
//        [self.label_Notes setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
//        [self.label_Notes mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.label_Count.mas_bottom).with.offset(mas_Padding_Page_Small.top);
//            make.leading.equalTo(self.captureImageView.mas_trailing).with.offset(mas_Padding_Page_Small.left);
//            make.bottom.equalTo(self.mas_bottom).with.offset(mas_Padding_Page_Small.bottom);
//            self.label_Notes.preferredMaxLayoutWidth = self.label_Notes.bounds.size.width;
//        }];
//        
//        [self.btn_Add mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerY.equalTo(self.contentView.mas_centerY);
//            make.leading.equalTo(self.label_Notes.mas_trailing).with.offset(mas_Padding_Page_Small.left);
//            make.size.mas_equalTo(CGSizeMake(40, 40));
//            make.trailing.equalTo(self.contentView.mas_trailing).with.offset(mas_Padding_Page_Small.right).priority(999);
//
//        }];
//        
//        [self.btn_Minus mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerY.equalTo(self.contentView.mas_centerY);
//            make.leading.equalTo(self.btn_Add.mas_trailing).with.offset(mas_Padding_Page_Small.left);
//            make.size.mas_equalTo(CGSizeMake(40, 40));
//            make.trailing.equalTo(self.contentView.mas_trailing).with.offset(mas_Padding_Page_Small.right);
//        }];
        self.didSetupConstraints = YES;
    }
    [super updateConstraints];
}

- (void)layoutSubviews
{
    NSLog(@"layoutSubviews table cell.");

    [super layoutSubviews];
    [self.contentView setNeedsLayout];
    [self.contentView layoutIfNeeded];
}

// Other default method
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

//    self.contentView
    
    // Configure the view for the selected state
}



@end
