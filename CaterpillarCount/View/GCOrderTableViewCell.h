//
//  GCOrderTableViewCell.h
//  CaterpillarCount
//
//  Created by Golden Compass on 9/28/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GCOrderTableViewCell : UITableViewCell

// Self
@property (assign) BOOL didSetupConstraints;

// Cell item
@property (strong) UIImageView *captureImageView;
@property (strong) UILabel *label_OrderName, *label_Length, *label_Count;




@property (strong) NSString *orderName;
@property (strong) NSNumber *length;
@property (strong) NSNumber *count;

@end
