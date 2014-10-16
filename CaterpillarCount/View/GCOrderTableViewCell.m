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
        [self addSubview:self.captureImageView];
        // Order Name
        self.label_OrderName = [UILabel LabelSubTitleWithString:@"Order Name" align:NSTextAlignmentLeft];
        [self addSubview:self.label_OrderName];
        // Length
        self.label_Length = [UILabel LabelSubTitleWithString:@"Length" align:NSTextAlignmentLeft];
        [self addSubview:self.label_Length];
        // Count
        self.label_Count = [UILabel LabelSubTitleWithString:@"Count" align:NSTextAlignmentLeft];
        [self addSubview:self.label_Count];
        
        self.contentView.backgroundColor = [UIColor colorWithRed:0 green:1 blue:0 alpha:0.1];
        
    }
    return self;
}

- (void)updateConstraints
{
    if (!self.didSetupConstraints) {
        [self.captureImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).with.offset(mas_Padding_Page_Default.top);
            make.left.equalTo(self.contentView.mas_left).with.offset(mas_Padding_Page_Default.left);
            make.bottom.equalTo(self.contentView.mas_bottom).with.offset(mas_Padding_Page_Default.bottom);
        }];
        [self.label_OrderName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).with.offset(mas_Padding_Page_Default.top);
            make.left.equalTo(self.captureImageView.mas_right).offset(mas_Padding_Page_Default.left);
            make.right.equalTo(self.contentView.mas_right).offset(mas_Padding_Page_Default.right);
        }];
        [self.label_Length mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.label_OrderName.mas_bottom).with.offset(mas_Padding_Page_Default.top);
            make.left.equalTo(self.captureImageView.mas_right).offset(mas_Padding_Page_Default.left);
            make.right.equalTo(self.contentView.mas_right).offset(mas_Padding_Page_Default.right);
        }];
        [self.label_Count mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.label_Length.mas_bottom).with.offset(mas_Padding_Page_Default.top);
            make.left.equalTo(self.captureImageView.mas_right).offset(mas_Padding_Page_Default.left);
            make.right.equalTo(self.contentView.mas_right).offset(mas_Padding_Page_Default.right);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(mas_Padding_Page_Default.bottom);
        }];
        self.didSetupConstraints = YES;
    }
    [super updateConstraints];
}

- (void)layoutSubviews
{
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
