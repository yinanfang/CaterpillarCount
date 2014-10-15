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

@end

@implementation GCNewOrderScrollView

- (id)initWithParentController:(GCNewOrderViewController *)controller
{
    self = [super init];
    if (self) {
        self.parentController = controller;
        self.backgroundColor = [UIColor whiteColor];
        self.delegate = self;
        [self.parentController.view addSubview:self];
        
        // Arthropod Order
        self.label_Order = [UILabel LabelTitleWithString:@"Arthropod Order" align:NSTextAlignmentLeft];
        [self addSubview:self.label_Order];
        // Entry order
        self.entry_Order = [UIButton ButtonWithTitle:@"Click to choose a order" inBold:NO horizontalAlign:UIControlContentHorizontalAlignmentLeft];
        [self addSubview:self.entry_Order];
        // Entry Length
        self.entry_Length = [UITextField TextFieldWithPlaceHolder:@"Length (mm)" keyboardType:UIKeyboardTypeNumberPad];
        self.entry_Length.delegate = self;
        [self addSubview:self.entry_Length];
        // Entry Count
        self.entry_Count = [UITextField TextFieldWithPlaceHolder:@"Count (1 to 1000)" keyboardType:UIKeyboardTypeNumberPad];
        self.entry_Count.delegate = self;
        [self addSubview:self.entry_Count];
        // Entry Notes
        self.entry_Notes = [UITextField TextFieldWithPlaceHolder:@"Notes" keyboardType:UIKeyboardTypeDefault];
        self.entry_Notes.delegate = self;
        [self addSubview:self.entry_Notes];
        
        // Photo
        self.label_Photo = [UILabel LabelTitleWithString:@"Photo" align:NSTextAlignmentLeft];
        [self addSubview:self.label_Photo];
        // Photo thumbnail
        self.entry_Photo = [[UIImageView alloc] init];
        self.entry_Photo.backgroundColor = [UIColor lightGrayColor];
        self.entry_Photo.layer.cornerRadius = CornerRadius_General;
        self.entry_Photo.clipsToBounds = YES;
        [self addSubview:self.entry_Photo];
        // Photo Place Holder
        self.btn_PhotoPlaceHolder = [UIButton ButtonWithTitle:@"Capture" inBold:NO horizontalAlign:UIControlContentHorizontalAlignmentCenter];
        [self addSubview:self.btn_PhotoPlaceHolder];
        
        // Submit button and alert view
        self.btn_Submit = [FUIButton ButtonWithTitle:@"Save Data" inBold:YES];
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

    }
    return self;
    
}

- (void)updateConstraints
{
    if(!self.didSetupConstraints) {
        // Self
        [GCAppSetup setConstraints_FillFullScreenWithView:self superview:self.parentController.view];
        // Arthropod Order
        [self.label_Order mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).with.offset(Padding_Page_Large.top);
            make.left.equalTo(self.mas_left).with.offset(Padding_Page_Large.left);
            make.right.equalTo(self.mas_right).with.offset(Padding_Page_Large.right);
            make.width.mas_equalTo(ScreenWidth-2*Padding_Page_Large.left);
        }];
        // Order
        [GCAppSetup setConstraints_PinHorizontallyWithPagePaddingAndTopWithPadding:PagePaddingLarge withView:self.entry_Order superview:self upperview:self.label_Order];
        // Length
        [GCAppSetup setConstraints_PinHorizontallyWithPagePaddingAndTopWithPadding:PagePaddingLarge withView:self.entry_Length superview:self upperview:self.entry_Order];
        // Count
        [GCAppSetup setConstraints_PinHorizontallyWithPagePaddingAndTopWithPadding:PagePaddingLarge withView:self.entry_Count superview:self upperview:self.entry_Length];
        // Notes
        [GCAppSetup setConstraints_PinHorizontallyWithPagePaddingAndTopWithPadding:PagePaddingLarge withView:self.entry_Notes superview:self upperview:self.entry_Count];
        
        // Photo
        [GCAppSetup setConstraints_PinHorizontallyWithPagePaddingAndTopWithPadding:PagePaddingLarge withView:self.label_Photo superview:self upperview:self.entry_Notes];
        [self.entry_Photo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.label_Photo.mas_bottom).with.offset(Padding_Page_Small.top);
            make.centerX.equalTo(self.mas_centerX);
            make.size.mas_equalTo(CGSizeMake(100, 100));
        }];
        [self.btn_PhotoPlaceHolder mas_makeConstraints:^(MASConstraintMaker *make) {
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
        
        self.didSetupConstraints = YES;
    }
    [super updateConstraints];
}


@end
