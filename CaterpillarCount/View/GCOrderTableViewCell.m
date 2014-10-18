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
//        self.contentView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
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
        [self.contentView addSubview:self.label_Length];
        // Count
        self.label_Count = [UILabel LabelSubTitleWithString:@"Count" align:NSTextAlignmentLeft];
        [self.contentView addSubview:self.label_Count];
        
        self.contentView.backgroundColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:1];
        
    }
    return self;
}

- (void)updateConstraints
{
    NSLog(@"updateConstraints table cell.");
    if (!self.didSetupConstraints) {
        self.contentView.bounds = CGRectMake(0.0f, 0.0f, 1000.0f, 1000.0f);
        
        [self.captureImageView setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
        [self.captureImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).with.offset(mas_Padding_Page_Default.top);
            make.leading.equalTo(self.contentView.mas_left).with.offset(mas_Padding_Page_Default.left);
            make.bottom.equalTo(self.contentView.mas_bottom).with.offset(mas_Padding_Page_Default.bottom).priority(999);
            make.height.mas_equalTo(100);
            make.width.mas_equalTo(100);

            //            make.left.equalTo(self.mas_left).with.offset(mas_Padding_Page_Default.left);
////            make.right.equalTo(self.contentView.mas_right).with.offset(5*mas_Padding_Page_Default.right);
//            make.width.mas_equalTo(100);
////            make.width.mas_equalTo(100);
//            make.bottom.equalTo(self.mas_bottom).with.offset(mas_Padding_Page_Default.bottom);
//            make.size.mas_equalTo(CGRectMake(0, 0, 60, 60).size);
            
        }];
        
//        [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.mas_top).with.offset(mas_Padding_Page_Default.top);
//            make.left.equalTo(self.mas_left).offset(mas_Padding_Page_Default.left);
//            make.right.equalTo(self.mas_right).offset(mas_Padding_Page_Default.right);
//            make.bottom.equalTo(self.mas_bottom).with.offset(mas_Padding_Page_Default.bottom);
//        }];
        
//        [self.label_OrderName setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
//        [self.label_OrderName setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
//        [self.label_OrderName mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.contentView.mas_top).with.offset(mas_Padding_Page_Default.top);
//            make.left.equalTo(self.contentView.mas_left).offset(mas_Padding_Page_Default.left);
//            make.right.equalTo(self.contentView.mas_right).offset(mas_Padding_Page_Default.right);
//            make.size.mas_equalTo(CGSizeMake(100, 100));
//            make.bottom.equalTo(self.contentView.mas_bottom).with.offset(mas_Padding_Page_Default.bottom);
//        }];
        
        
//        [self.label_Length mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.label_OrderName.mas_bottom).with.offset(mas_Padding_Page_Default.top);
//            make.left.equalTo(self.captureImageView.mas_right).offset(mas_Padding_Page_Default.left);
//            make.right.equalTo(self.contentView.mas_right).offset(mas_Padding_Page_Default.right);
//        }];
//        [self.label_Count mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.label_Length.mas_bottom).with.offset(mas_Padding_Page_Default.top);
//            make.left.equalTo(self.captureImageView.mas_right).offset(mas_Padding_Page_Default.left);
//            make.right.equalTo(self.contentView.mas_right).offset(mas_Padding_Page_Default.right);
//            make.bottom.equalTo(self.contentView.mas_bottom).offset(mas_Padding_Page_Default.bottom);
//        }];
        self.didSetupConstraints = YES;
    }
//    self.contentView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
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
