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
        DDLogWarn(@"initWithStyle");
        // Thumbnail picture
        self.captureImageView = [UIImageView ImageViewWithDefaultBackgroundImage:nil];
        [self.captureImageView setImage:[UIImage imageNamed:@"Checkmark"]];
        [self.contentView addSubview:self.captureImageView];
        // Order Name
        self.label_OrderName = [UILabel LabelSubTitleWithString:@"Order Name" align:NSTextAlignmentLeft];
        self.label_OrderName.numberOfLines = 0;
//        self.label_OrderName.backgroundColor = [UIColor emerlandColor];
        [self.contentView addSubview:self.label_OrderName];
        // Length
        self.label_Length = [UILabel LabelSubTitleWithString:@"Length" align:NSTextAlignmentLeft];
//        self.label_Length.backgroundColor = [UIColor greenColor];
        [self.contentView addSubview:self.label_Length];
        // Count
        self.label_Count = [UILabel LabelSubTitleWithString:@"Count" align:NSTextAlignmentLeft];
//        self.label_Count.backgroundColor = [UIColor yellowColor];
        [self.contentView addSubview:self.label_Count];
        // Notes
        self.label_Notes = [UILabel LabelSubTitleWithString:@"Notes" align:NSTextAlignmentLeft];
        self.label_Notes.numberOfLines = 0;
//        self.label_Notes.backgroundColor = [UIColor blackColor];
        [self.contentView addSubview:self.label_Notes];
        
        // Add and Minus Button
        self.btn_Add = [FUIButton ButtonWithTitle:@"+" inBold:YES];
        [self.contentView addSubview:self.btn_Add];
        self.btn_Minus = [FUIButton ButtonWithTitle:@"-" inBold:YES];
        [self.contentView addSubview:self.btn_Minus];
        
//        self.contentView.backgroundColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:1];
        
    }
    return self;
}

- (void)updateConstraints
{
    NSLog(@"updateConstraints table cell.");
    if (!self.didSetupConstraints) {
        // Expand the content view temporariry
        self.contentView.bounds = CGRectMake(0.0f, 0.0f, 1000.0f, 1000.0f);
        
        // Set compression resistance to ensure vertical height
        [self.label_OrderName setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
        [self.label_OrderName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).with.offset(mas_Padding_Page_Small.top);
            make.left.equalTo(self.contentView.mas_left).with.offset(mas_Padding_Page_Small.left);
            make.right.equalTo(self.contentView.mas_right).offset(mas_Padding_Page_Small.right);
        }];
        
        [self.captureImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.label_OrderName.mas_bottom).with.offset(mas_Padding_Page_Small.top);
            make.left.equalTo(self.contentView.mas_left).with.offset(mas_Padding_Page_Small.left);
            make.size.mas_equalTo(CGSizeMake(60, 60));
        }];
        
        [self.label_Length setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
        [self.label_Length mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.label_OrderName.mas_bottom).with.offset(mas_Padding_Page_Small.top);
            make.leading.equalTo(self.captureImageView.mas_trailing).with.offset(mas_Padding_Page_Small.left);
        }];
        
        [self.label_Count setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
        [self.label_Count mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.label_Length.mas_bottom).with.offset(mas_Padding_Page_Small.top);
            make.leading.equalTo(self.label_Length.mas_leading);
            make.trailing.equalTo(self.label_Length.mas_trailing);
        }];

        [self.label_Notes setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
        [self.label_Notes mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.label_Count.mas_bottom).with.offset(mas_Padding_Page_Small.top);
            make.leading.equalTo(self.label_Count.mas_leading);
            make.trailing.equalTo(self.label_Count.mas_trailing);
            make.bottom.equalTo(self.contentView.mas_bottom).with.offset(mas_Padding_Page_Small.bottom);
        }];
        
        [self.btn_Add mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.label_OrderName.mas_bottom).with.offset(mas_Padding_Page_Small.top);
            make.leading.equalTo(self.label_Length.mas_trailing).with.offset(mas_Padding_Page_Small.left);
            make.size.mas_equalTo(CGSizeMake(40, 40));
        }];

        [self.btn_Minus mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.label_OrderName.mas_bottom).with.offset(mas_Padding_Page_Small.top);
            make.leading.equalTo(self.btn_Add.mas_trailing).with.offset(mas_Padding_Page_Small.left);
            make.size.mas_equalTo(CGSizeMake(40, 40));
            make.right.equalTo(self.contentView.mas_right).with.offset(mas_Padding_Page_Small.right);
        }];
        
        // Might need to use one NSLayoutRelationGreaterThanOrEqual to account for 1.0 point added for the 0.5 separator in iOS 7.0
        
        self.didSetupConstraints = YES;
    }
    [super updateConstraints];
}

- (void)layoutSubviews
{
    NSLog(@"layoutSubviews table cell.");
    [super layoutSubviews];
    // Make sure the contentView does a layout pass, which set the frames in order to calculate the preferredMaxLayoutWidth
    [self.contentView setNeedsLayout];
    [self.contentView layoutIfNeeded];
    
    // Solve multi-line UILabel issue. Calculate actual height depends on the label width
    self.label_OrderName.preferredMaxLayoutWidth = CGRectGetWidth(self.label_OrderName.frame);
    self.label_Length.preferredMaxLayoutWidth = CGRectGetWidth(self.label_Length.frame);
    self.label_Count.preferredMaxLayoutWidth = CGRectGetWidth(self.label_Count.frame);
    self.label_Notes.preferredMaxLayoutWidth = CGRectGetWidth(self.label_Notes.frame);
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
