//
//  GCSurveyScrollView.m
//  CaterpillarCount
//
//  Created by Golden Compass on 9/24/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import "GCSurveyViewController.h"
#import "GCSurveyScrollView.h"
#import "GCOrderTableViewCell.h"

@implementation GCSurveyScrollView

- (id)initWithParentController:(GCSurveyViewController *)controller
{
    self = [super init];
    if (self) {
        // Initialization code
        self.parentController = controller;
        self.tintColor = [GCAppAPI getColorWithRGBAinHex:ThemeColor01];
        self.backgroundColor = [UIColor whiteColor];
        self.delegate = self;
        self.shouldMoveUpToAdjustForKeyboard = YES;
        self.shouldMoveDownToAdjustForKeyboard = NO;
        [self.parentController.view addSubview:self];
        
        // Temp, Time, Date Label
        self.label_Temp = [UILabel LabelSubTitleWithString:@"Temp" align:NSTextAlignmentCenter];
        [self addSubview:self.label_Temp];
        self.label_Time = [UILabel LabelSubTitleWithString:@"Time" align:NSTextAlignmentCenter];
        [self addSubview:self.label_Time];
        self.label_Date = [UILabel LabelSubTitleWithString:@"Date" align:NSTextAlignmentCenter];
        [self addSubview:self.label_Date];
        
        // Temp, Time, Date Entry
        self.entry_Temp = [UIButton ButtonWithTitle:@"60F - 70 F" inBold:NO horizontalAlign:UIControlContentHorizontalAlignmentCenter];
        [self addSubview:self.entry_Temp];
        self.entry_Time = [UIButton ButtonWithTitle:@"Time" inBold:NO horizontalAlign:UIControlContentHorizontalAlignmentCenter];
        [self addSubview:self.entry_Time];
        self.entry_Date = [UIButton ButtonWithTitle:@"Date" inBold:NO horizontalAlign:UIControlContentHorizontalAlignmentCenter];
        [self addSubview:self.entry_Date];
        // Set Time and Date
        NSDate *currentDateAndTime = [NSDate date];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"HH:mm a"];
        NSString *timeString = [formatter stringFromDate: currentDateAndTime];
        [self.entry_Time setTitle:timeString forState:UIControlStateNormal];
        [formatter setDateFormat:@"MM/dd/yy"];
        NSString *dateString = [formatter stringFromDate: currentDateAndTime];
        [self.entry_Date setTitle:dateString forState:UIControlStateNormal];
        
        // Site Information
        self.label_SiteInfo = [UILabel LabelTitleWithString:@"Site Information" align:NSTextAlignmentLeft];
        [self addSubview:self.label_SiteInfo];
        self.btn_Info_Site = [self addInfoButton];
        
        // Site
        self.label_Site = [UILabel LabelSubTitleWithString:@"Site" align:NSTextAlignmentLeft];
        [self addSubview:self.label_Site];
        self.btn_NewSite = [FUIButton ButtonWithTitle:@"Add" inBold:YES];
        [self addSubview:self.btn_NewSite];
        self.entry_Site = [UIButton ButtonWithTitle:@"Click to choose a site" inBold:NO horizontalAlign:UIControlContentHorizontalAlignmentLeft];
        [self addSubview:self.entry_Site];
        // Circle
        self.label_Circle = [UILabel LabelSubTitleWithString:@"Circle" align:NSTextAlignmentLeft];
        [self addSubview:self.label_Circle];
        self.entry_Circle = [UIButton ButtonWithTitle:@"Click to choose a circle" inBold:NO horizontalAlign:UIControlContentHorizontalAlignmentLeft];
        [self addSubview:self.entry_Circle];
        // Survey
        self.label_Survey = [UILabel LabelSubTitleWithString:@"Survey" align:NSTextAlignmentLeft];
        [self addSubview:self.label_Survey];
        self.entry_Survey = [UIButton ButtonWithTitle:@"Click to choose a survey" inBold:NO horizontalAlign:UIControlContentHorizontalAlignmentLeft];
        [self addSubview:self.entry_Survey];
        // Site Notes
        self.label_Notes = [UILabel LabelSubTitleWithString:@"Notes" align:NSTextAlignmentLeft];
        [self addSubview:self.label_Notes];
        self.entry_SiteNotes = [UITextField TextFieldWithPlaceHolder:@"Site Notes" keyboardType:UIKeyboardTypeDefault];
        self.entry_SiteNotes.delegate = self;
        [self addSubview:self.entry_SiteNotes];
        
        // Arthropod Order Info
        self.label_ArthropodOrderInfo = [UILabel LabelTitleWithString:@"Arthropod Order Info" align:NSTextAlignmentLeft];
        [self addSubview:self.label_ArthropodOrderInfo];
        // Info Button
        self.btn_Info_Order = [self addInfoButton];
        // New Order Info Button
        self.btn_NewOrderInfo = [FUIButton ButtonWithTitle:@"New" inBold:YES];
        [self addSubview:self.btn_NewOrderInfo];

        // Order details table
        self.orderTableView = [[UITableView alloc] init];
        self.orderTableView.separatorInset = UIEdgeInsetsZero;
        [self addSubview:self.orderTableView];
        
        // Plant Information
        self.label_PlantInfo = [UILabel LabelTitleWithString:@"Plant Information" align:NSTextAlignmentLeft];
        [self addSubview:self.label_PlantInfo];
        // Info Button
        self.btn_Info_Plant = [self addInfoButton];
        // Plant Species
        self.label_PlantSpecies = [UILabel LabelSubTitleWithString:@"Plant Species" align:NSTextAlignmentLeft];
        [self addSubview:self.label_PlantSpecies];
        self.entry_PlantSpecies = [UITextField TextFieldWithPlaceHolder:@"Plant Species (if known)" keyboardType:UIKeyboardTypeDefault];
        self.entry_PlantSpecies.delegate = self;
        [self addSubview:self.entry_PlantSpecies];
        // Herbivory label
        self.label_Herbivory = [UILabel LabelSubTitleWithString:@"Herbivory" align:NSTextAlignmentLeft];
        [self addSubview:self.label_Herbivory];
        // Herbivory entry
        self.entry_Herbivory = [UIButton ButtonWithTitle:@"Click to choose a herbivory" inBold:NO horizontalAlign:UIControlContentHorizontalAlignmentLeft];
        [self addSubview:self.entry_Herbivory];
        // Plant Photo
        self.label_PlantPhoto = [UILabel LabelSubTitleWithString:@"Leaf Photo" align:NSTextAlignmentLeft];
        [self addSubview:self.label_PlantPhoto];
        // Photo thumbnail
        self.entry_PlantPhoto = [UIImageView ImageViewWithDefaultBackgroundImage:nil];
//        self.entry_PlantPhoto.image = [UIImage imageNamed:@"cover_logo"];
        [self addSubview:self.entry_PlantPhoto];
        // Photo Place Holder
        self.btn_PhotoPlaceHolder = [UIButton ButtonWithTitle:@"Capture" inBold:NO horizontalAlign:UIControlContentHorizontalAlignmentCenter];
        [self addSubview:self.btn_PhotoPlaceHolder];
        
        // Submit button and alert view
        self.btn_Submit = [FUIButton ButtonWithTitle:@"Submit" inBold:YES];
        [self addSubview:self.btn_Submit];
    }
    return self;
    
}

- (void)updateConstraints
{
    if(!self.didSetupConstraints) {
        // Self
        [GCAppSetup setConstraints_FillFullScreenWithView:self superview:self.parentController.view];
        // Temp, Time, Date Label
        [self.label_Temp mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).with.offset(mas_Padding_Page_Large.top);
            make.left.equalTo(self.mas_left).with.offset(mas_Padding_Page_Large.left);
        }];
        [self.label_Time mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).with.offset(mas_Padding_Page_Large.top);
            make.left.equalTo(self.label_Temp.mas_right);
            make.width.equalTo(self.label_Temp.mas_width);
            make.centerX.equalTo(self.mas_centerX);
        }];
        [self.label_Date mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).with.offset(mas_Padding_Page_Large.top);
            make.left.equalTo(self.label_Time.mas_right);
            make.right.equalTo(self.mas_right).with.offset(mas_Padding_Page_Large.right);
            make.width.equalTo(self.label_Time.mas_width);
        }];
        
        // Temp, Time, Date Entry
        [self.entry_Temp mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.label_Temp.mas_bottom).with.offset(mas_Padding_Page_Default.top);
            make.left.equalTo(self.mas_left).with.offset(mas_Padding_Page_Large.left);
            make.bottom.equalTo(self.label_SiteInfo.mas_top).with.offset(mas_Padding_Page_Large.bottom);
        }];
        [self.entry_Time mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.label_Time.mas_bottom).with.offset(mas_Padding_Page_Default.top);
            make.left.equalTo(self.entry_Temp.mas_right).with.offset(mas_Padding_Page_Default.left);
            make.bottom.equalTo(self.label_SiteInfo.mas_top).with.offset(mas_Padding_Page_Large.bottom);
            make.right.equalTo(self.entry_Date.mas_left).with.offset(mas_Padding_Page_Default.right);
            make.width.equalTo(self.entry_Temp.mas_width);
            make.centerX.equalTo(self.mas_centerX);
        }];
        [self.entry_Date mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.label_Date.mas_bottom).with.offset(mas_Padding_Page_Default.top);
            make.right.equalTo(self.mas_right).with.offset(mas_Padding_Page_Large.right);
            make.bottom.equalTo(self.label_SiteInfo.mas_top).with.offset(mas_Padding_Page_Large.bottom);
            make.width.equalTo(self.entry_Time.mas_width);
        }];
        
        // Site Information
        [self.label_SiteInfo mas_makeConstraints:^(MASConstraintMaker *make) {
            // top is defined by three entries above
            make.left.equalTo(self.mas_left).with.offset(mas_Padding_Page_Large.left);
        }];
        [self.btn_Info_Site mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.label_SiteInfo.mas_top);
            make.left.equalTo(self.label_SiteInfo.mas_right).with.offset(mas_Padding_Page_Default.left);
            make.size.mas_equalTo(CGSizeMake(20, 20));
        }];
        
        // Site
//        [GCAppSetup setConstraints_PinHorizontallyWithPagePaddingAndTopWithPadding:PagePaddingSmall withView:self.label_Site superview:self upperview:self.label_SiteInfo];
        [self.label_Site mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.label_SiteInfo.mas_bottom).with.offset(mas_Padding_Page_Small.top);
            make.left.equalTo(self.mas_left).with.offset(mas_Padding_Page_Large.left);
        }];
        [self.btn_NewSite mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.label_SiteInfo.mas_bottom).with.offset(mas_Padding_Page_Small.top);
            make.left.equalTo(self.label_Site.mas_right).with.offset(mas_Padding_Page_Large.left);
            make.right.equalTo(self.mas_right).with.offset(mas_Padding_Page_Large.right);
            make.size.mas_equalTo(CGSizeMake(60, 20));
        }];
        
        [GCAppSetup setConstraints_PinHorizontallyWithPagePaddingAndTopWithPadding:PagePaddingSmall withView:self.entry_Site superview:self upperview:self.label_Site];
        // Circle
        [GCAppSetup setConstraints_PinHorizontallyWithPagePaddingAndTopWithPadding:PagePaddingSmall withView:self.label_Circle superview:self upperview:self.entry_Site];
        [GCAppSetup setConstraints_PinHorizontallyWithPagePaddingAndTopWithPadding:PagePaddingSmall withView:self.entry_Circle superview:self upperview:self.label_Circle];
        // Survey
        [GCAppSetup setConstraints_PinHorizontallyWithPagePaddingAndTopWithPadding:PagePaddingSmall withView:self.label_Survey superview:self upperview:self.entry_Circle];
        [GCAppSetup setConstraints_PinHorizontallyWithPagePaddingAndTopWithPadding:PagePaddingSmall withView:self.entry_Survey superview:self upperview:self.label_Survey];
        // Notes
        [GCAppSetup setConstraints_PinHorizontallyWithPagePaddingAndTopWithPadding:PagePaddingSmall withView:self.label_Notes superview:self upperview:self.entry_Survey];
        [GCAppSetup setConstraints_PinHorizontallyWithPagePaddingAndTopWithPadding:PagePaddingSmall withView:self.entry_SiteNotes superview:self upperview:self.label_Notes];
        
        // Arthropod Order Info
        [self.label_ArthropodOrderInfo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.entry_SiteNotes.mas_bottom).with.offset(mas_Padding_Page_Large.top);
            make.left.equalTo(self.mas_left).with.offset(mas_Padding_Page_Large.left);
            make.height.mas_equalTo(20);
        }];
        [self.btn_Info_Order mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.label_ArthropodOrderInfo.mas_top);
            make.left.equalTo(self.label_ArthropodOrderInfo.mas_right).with.offset(mas_Padding_Page_Default.left);
            make.size.mas_equalTo(CGSizeMake(20, 20));
        }];
        // Add button
        [self.btn_NewOrderInfo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.entry_SiteNotes.mas_bottom).with.offset(mas_Padding_Page_Large.top);
            make.left.equalTo(self.btn_Info_Order.mas_right).with.offset(mas_Padding_Page_Default.left);
            make.right.equalTo(self.mas_right).with.offset(mas_Padding_Page_Large.right);
            make.size.mas_equalTo(CGSizeMake(60, 23));
            //            make.bottom.equalTo(self.mas_bottom);
        }];
        // Order detail table
        [self.orderTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.label_ArthropodOrderInfo.mas_bottom).with.offset(mas_Padding_Page_Default.top);
            make.left.equalTo(self.mas_left).with.offset(mas_Padding_Page_Large.left);   // wrong offset??
            make.right.equalTo(self.mas_right).with.offset(mas_Padding_Page_Large.right);
            make.height.mas_equalTo(300);
        }];
        
        // Plant Information
        [self.label_PlantInfo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.orderTableView.mas_bottom).with.offset(mas_Padding_Page_Large.top);
            make.left.equalTo(self.mas_left).with.offset(mas_Padding_Page_Large.left);
        }];
        // Info Button
        [self.btn_Info_Plant mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.label_PlantInfo.mas_top);
            make.left.equalTo(self.label_PlantInfo.mas_right).with.offset(mas_Padding_Page_Default.left);
            make.size.mas_equalTo(CGSizeMake(20, 20));
        }];
        // Species
        [GCAppSetup setConstraints_PinHorizontallyWithPagePaddingAndTopWithPadding:PagePaddingSmall withView:self.label_PlantSpecies superview:self upperview:self.label_PlantInfo];
        [GCAppSetup setConstraints_PinHorizontallyWithPagePaddingAndTopWithPadding:PagePaddingSmall withView:self.entry_PlantSpecies superview:self upperview:self.label_PlantSpecies];
        // Herbivory
        [GCAppSetup setConstraints_PinHorizontallyWithPagePaddingAndTopWithPadding:PagePaddingSmall withView:self.label_Herbivory superview:self upperview:self.entry_PlantSpecies];
        [GCAppSetup setConstraints_PinHorizontallyWithPagePaddingAndTopWithPadding:PagePaddingSmall withView:self.entry_Herbivory superview:self upperview:self.label_Herbivory];
        // Plant Photo
        [GCAppSetup setConstraints_PinHorizontallyWithPagePaddingAndTopWithPadding:PagePaddingSmall withView:self.label_PlantPhoto superview:self upperview:self.entry_Herbivory];
        [self.entry_PlantPhoto mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.label_PlantPhoto.mas_bottom).with.offset(mas_Padding_Page_Default.top);
            make.centerX.equalTo(self.mas_centerX);
            make.size.mas_equalTo(CGSizeMake(100, 100));
        }];
        [self.btn_PhotoPlaceHolder mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.label_PlantPhoto.mas_bottom).with.offset(mas_Padding_Page_Default.top);
            make.centerX.equalTo(self.mas_centerX);
            make.size.mas_equalTo(CGSizeMake(100, 100));
        }];
        [self.btn_Submit mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.entry_PlantPhoto.mas_bottom).with.offset(mas_Padding_Page_Large.top);
            make.left.equalTo(self.mas_left).with.offset(mas_Padding_Page_Large.left);
            make.right.equalTo(self.mas_right).with.offset(mas_Padding_Page_Large.right);
            make.height.mas_equalTo(40);
            make.bottom.equalTo(self.mas_bottom).with.offset(mas_Padding_Page_Large.bottom);
        }];
        
        self.didSetupConstraints = YES;
    }
    [super updateConstraints];
}

#pragma mark - UITextField Delegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    DDLogVerbose(@"textFieldShouldBeginEditing");
    if (self.shouldMoveUpToAdjustForKeyboard) {
        [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            DDLogVerbose(@"Adjusting content offset for keyboard");
            self.center = CGPointMake(self.center.x, self.center.y-kOFFSET_FOR_KEYBOARD);
        }completion:nil];
        self.shouldMoveUpToAdjustForKeyboard = NO;
        self.shouldMoveDownToAdjustForKeyboard = YES;
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    DDLogVerbose(@"textFieldShouldReturn:");
    [textField resignFirstResponder];
    if (self.shouldMoveDownToAdjustForKeyboard) {
        [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            DDLogVerbose(@"Adjusting content offset for keyboard");
            self.center = CGPointMake(self.center.x, self.center.y+kOFFSET_FOR_KEYBOARD);
        }completion:nil];
        self.shouldMoveUpToAdjustForKeyboard = YES;
        self.shouldMoveDownToAdjustForKeyboard = NO;
    }
    return YES;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    DDLogVerbose(@"touchesBegan:withEvent:");
    DDLogVerbose(@"Hide keyboard...");
    [self endEditing:YES];
    if (self.shouldMoveDownToAdjustForKeyboard) {
        [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            DDLogVerbose(@"Adjusting content offset for keyboard");
            self.center = CGPointMake(self.center.x, self.center.y+kOFFSET_FOR_KEYBOARD);
        }completion:nil];
        self.shouldMoveUpToAdjustForKeyboard = YES;
        self.shouldMoveDownToAdjustForKeyboard = NO;
    }
    [super touchesBegan:touches withEvent:event];
    // Don't let UIScrollView eats up all the touch events. Pass it to nextResponder
    [self.nextResponder touchesBegan: touches withEvent:event];
}

#pragma mark - Factory Methods
- (UIButton *)addInfoButton
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setImage:[UIImage imageNamed:@"icon_info"] forState:UIControlStateNormal];
    [self addSubview:button];
    return button;
}
@end
