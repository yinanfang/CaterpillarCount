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
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.parentController.view.mas_top);
            make.left.equalTo(self.parentController.view.mas_left);
            make.bottom.equalTo(self.parentController.view.mas_bottom);
            make.right.equalTo(self.parentController.view.mas_right);
        }];
        
#pragma mark - Content Initialization
        // Arthropod Order
        self.label_Order = [[UILabel alloc] init];
        self.label_Order.textAlignment = NSTextAlignmentLeft;
        [self.label_Order setFont:[UIFont fontWithName:@"Helvetica" size:FontSize_p1]];
        [self.label_Order setBackgroundColor:[UIColor clearColor]];
        [self.label_Order setTextColor:[GCAppAPI getColorWithRGBAinHex:ThemeColor01]];
        [self.label_Order setText:@"Arthropod Order"];
        [self addSubview:self.label_Order];
        // Entry order
        self.entry_Order = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.entry_Order.contentEdgeInsets = Insets_Button;
        [self.entry_Order setTitle:@"Click to choose a order" forState:UIControlStateNormal];
        self.entry_Order.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:FontSize_p1];
        [self.entry_Order setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.entry_Order.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [[self.entry_Order layer] setBorderWidth:WidthForEntryfieldBorder];
        [[self.entry_Order layer] setBorderColor:[UIColor lightGrayColor].CGColor];
        self.entry_Order.layer.cornerRadius = CornerRadius_General;
        self.entry_Order.clipsToBounds = YES;
        [self addSubview:self.entry_Order];
        // Entry Length
        self.entry_Length = [[UITextField alloc] init];
        self.entry_Length.borderStyle = UITextBorderStyleRoundedRect;
        self.entry_Length.font = [UIFont systemFontOfSize:FontSize_p1];
        self.entry_Length.placeholder = @"Length (mm)";
        self.entry_Length.autocorrectionType = UITextAutocorrectionTypeNo;
        self.entry_Length.keyboardType = UIKeyboardTypeDefault;
        self.entry_Length.returnKeyType = UIReturnKeyDone;
        self.entry_Length.clearButtonMode = UITextFieldViewModeWhileEditing;
        self.entry_Length.contentVerticalAlignment = UIControlContentHorizontalAlignmentLeft;
        self.entry_Length.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        self.entry_Length.delegate = self;
        [self addSubview:self.entry_Length];
        // Entry Count
        self.entry_Count = [[UITextField alloc] init];
        self.entry_Count.borderStyle = UITextBorderStyleRoundedRect;
        self.entry_Count.font = [UIFont systemFontOfSize:FontSize_p1];
        self.entry_Count.placeholder = @"Count (1 to 1000)";
        self.entry_Count.autocorrectionType = UITextAutocorrectionTypeNo;
        self.entry_Count.keyboardType = UIKeyboardTypeDefault;
        self.entry_Count.returnKeyType = UIReturnKeyDone;
        self.entry_Count.clearButtonMode = UITextFieldViewModeWhileEditing;
        self.entry_Count.contentVerticalAlignment = UIControlContentHorizontalAlignmentLeft;
        self.entry_Count.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        self.entry_Count.delegate = self;
        [self addSubview:self.entry_Count];
        // Entry Notes
        self.entry_Notes = [[UITextField alloc] init];
        self.entry_Notes.borderStyle = UITextBorderStyleRoundedRect;
        self.entry_Notes.font = [UIFont systemFontOfSize:FontSize_p1];
        self.entry_Notes.placeholder = @"Notes";
        self.entry_Notes.autocorrectionType = UITextAutocorrectionTypeNo;
        self.entry_Notes.keyboardType = UIKeyboardTypeDefault;
        self.entry_Notes.returnKeyType = UIReturnKeyDone;
        self.entry_Notes.clearButtonMode = UITextFieldViewModeWhileEditing;
        self.entry_Notes.contentVerticalAlignment = UIControlContentHorizontalAlignmentLeft;
        self.entry_Notes.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        self.entry_Notes.delegate = self;
        [self addSubview:self.entry_Notes];
        
        // Photo
        self.label_Photo = [[UILabel alloc] init];
        self.label_Photo.textAlignment = NSTextAlignmentLeft;
        [self.label_Photo setFont:[UIFont fontWithName:@"Helvetica" size:FontSize_p1]];
        [self.label_Photo setBackgroundColor:[UIColor clearColor]];
        [self.label_Photo setTextColor:[GCAppAPI getColorWithRGBAinHex:ThemeColor01]];
        [self.label_Photo setText:@"Photo"];
        [self addSubview:self.label_Photo];
        // Photo thumbnail
        self.entry_Photo = [[UIImageView alloc] init];
        [self addSubview:self.entry_Photo];
        // Photo Place Holder
        self.label_PhotoPlaceHolder = [[UILabel alloc] init];
        self.label_PhotoPlaceHolder.textAlignment = NSTextAlignmentCenter;
        [self.label_PhotoPlaceHolder setFont:[UIFont fontWithName:@"Helvetica" size:FontSize_p1]];
        [self.label_PhotoPlaceHolder setBackgroundColor:[UIColor lightGrayColor]];
        [self.label_PhotoPlaceHolder setTextColor:[GCAppAPI getColorWithRGBAinHex:ThemeColor01]];
        [self.label_PhotoPlaceHolder setText:@"Capture"];
        self.label_PhotoPlaceHolder.layer.cornerRadius = CornerRadius_General;
        self.label_PhotoPlaceHolder.clipsToBounds = YES;
        [self addSubview:self.label_PhotoPlaceHolder];
        
        // Submit button and alert view
        self.btn_Submit = [[FUIButton alloc] init];
        self.btn_Submit.buttonColor = [GCAppAPI getColorWithRGBAinHex:ThemeColor01];
        self.btn_Submit.shadowColor = [UIColor greenSeaColor];
        self.btn_Submit.shadowHeight = 1.0f;
        self.btn_Submit.cornerRadius = 6.0f;
        self.btn_Submit.titleLabel.font = [UIFont boldFlatFontOfSize:16];
        [self.btn_Submit setTitle:@"Submit" forState:UIControlStateNormal];
        [self.btn_Submit setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
        [self.btn_Submit setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [self addSubview:self.btn_Submit];
        [[self.btn_Submit rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            NSLog(@"hit button submit");
            FUIAlertView *alertView = [[FUIAlertView alloc] initWithTitle:@"Well Done!" message:@"Submitting the data..." delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil, nil];
            alertView.alertViewStyle = FUIAlertViewStylePlainTextInput;
            alertView.delegate = self;
            alertView.titleLabel.textColor = [UIColor cloudsColor];
            alertView.titleLabel.font = [UIFont boldFlatFontOfSize:16];
            alertView.messageLabel.textColor = [UIColor cloudsColor];
            alertView.messageLabel.font = [UIFont flatFontOfSize:14];
            alertView.backgroundOverlay.backgroundColor = [[UIColor cloudsColor] colorWithAlphaComponent:0.8];
            alertView.alertContainer.backgroundColor = [UIColor midnightBlueColor];
            alertView.defaultButtonColor = [UIColor cloudsColor];
            alertView.defaultButtonShadowColor = [UIColor asbestosColor];
            alertView.defaultButtonFont = [UIFont boldFlatFontOfSize:16];
            alertView.defaultButtonTitleColor = [UIColor asbestosColor];
            [alertView show];
        }];

#pragma mark - Content Layout
        // Arthropod Order
        [self.label_Order mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).with.offset(Padding_Page_Large.top);
            make.left.equalTo(self.mas_left).with.offset(Padding_Page_Large.left);
            make.right.equalTo(self.mas_right).with.offset(Padding_Page_Large.right);
            make.width.mas_equalTo(ScreenWidth-2*Padding_Page_Large.left);
        }];
        [self.entry_Order mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.label_Order.mas_bottom).with.offset(Padding_Page_Small.top);
            make.left.equalTo(self.mas_left).with.offset(Padding_Page_Large.left);
            make.right.equalTo(self.mas_right).with.offset(Padding_Page_Large.right);
        }];
        [self.entry_Length mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.entry_Order.mas_bottom).with.offset(Padding_Page_Small.top);
            make.left.equalTo(self.mas_left).with.offset(Padding_Page_Large.left);
            make.right.equalTo(self.mas_right).with.offset(Padding_Page_Large.right);
//            make.bottom.equalTo(self.mas_bottom).with.offset(Padding_Page_Large.bottom);
        }];
        [self.entry_Count mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.entry_Length.mas_bottom).with.offset(Padding_Page_Small.top);
            make.left.equalTo(self.mas_left).with.offset(Padding_Page_Large.left);
            make.right.equalTo(self.mas_right).with.offset(Padding_Page_Large.right);
        }];
        [self.entry_Notes mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.entry_Count.mas_bottom).with.offset(Padding_Page_Small.top);
            make.left.equalTo(self.mas_left).with.offset(Padding_Page_Large.left);
            make.right.equalTo(self.mas_right).with.offset(Padding_Page_Large.right);
        }];
        [self.label_Photo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.entry_Notes.mas_bottom).with.offset(Padding_Page_Large.top);
            make.left.equalTo(self.mas_left).with.offset(Padding_Page_Large.left);
            make.right.equalTo(self.mas_right).with.offset(Padding_Page_Large.right);
//            make.bottom.equalTo(self.mas_bottom).with.offset(Padding_Page_Large.bottom);

        }];
        [self.entry_Photo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.label_Photo.mas_bottom).with.offset(Padding_Page_Small.top);
            make.centerX.equalTo(self.mas_centerX);
            make.size.mas_equalTo(CGSizeMake(100, 100));
        }];
        [self.label_PhotoPlaceHolder mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.label_Photo.mas_bottom).with.offset(Padding_Page_Small.top);
            make.centerX.equalTo(self.mas_centerX);
            make.size.mas_equalTo(CGSizeMake(100, 100));
        }];
        [self.btn_Submit mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.entry_Photo.mas_bottom).with.offset(Padding_Page_Large.top);
            make.left.equalTo(self.mas_left).with.offset(Padding_Page_Large.left);
            make.right.equalTo(self.mas_right).with.offset(Padding_Page_Large.right);
            make.height.mas_equalTo(40);
            make.bottom.equalTo(self.mas_bottom).with.offset(Padding_Page_Large.bottom);
        }];

        
        
        
        
        
        
        
    }
    return self;
    
}

@end
