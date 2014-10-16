//
//  GCRegisterScrollView.m
//  CaterpillarCount
//
//  Created by Golden Compass on 9/29/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import "GCRegisterScrollView.h"
#import "GCRegisterViewController.h"

@implementation GCRegisterScrollView

- (id)initWithParentController:(GCRegisterViewController *)controller
{
    self = [super init];
    if (self) {
        self.parentController = controller;
        self.backgroundColor = [UIColor whiteColor];
        self.delegate = self;
        [self.parentController.view addSubview:self];
        
        // Register Label
        self.label_Register = [UILabel LabelTitleWithString:@"Let's register for a new account!" align:NSTextAlignmentLeft];
        [self addSubview:self.label_Register];
        // First Name
        self.entry_NameFirst = [UITextField TextFieldWithPlaceHolder:@"First Name" keyboardType:UIKeyboardTypeDefault];
        self.entry_NameFirst.delegate = self;
        [self addSubview:self.entry_NameFirst];
        // Last Name
        self.entry_NameLast = [UITextField TextFieldWithPlaceHolder:@"Last Name" keyboardType:UIKeyboardTypeDefault];
        self.entry_NameLast.delegate = self;
        [self addSubview:self.entry_NameLast];
        // Email Address
        self.entry_Email = [UITextField TextFieldWithPlaceHolder:@"Email Address" keyboardType:UIKeyboardTypeDefault];
        self.entry_Email.delegate = self;
        [self addSubview:self.entry_Email];
        // Password
        self.entry_PasswordNew = [UITextField TextFieldWithPlaceHolder:@"Password" keyboardType:UIKeyboardTypeDefault];
        self.entry_PasswordNew.delegate = self;
        [self addSubview:self.entry_PasswordNew];
        // Confirm Password
        self.entry_PasswordConfirm = [UITextField TextFieldWithPlaceHolder:@"Confirm Password" keyboardType:UIKeyboardTypeDefault];
        self.entry_PasswordConfirm.delegate = self;
        [self addSubview:self.entry_PasswordConfirm];
        
        // Submit button and alert view
        self.btn_Submit = [FUIButton ButtonWithTitle:@"Register" inBold:YES];
        [self addSubview:self.btn_Submit];        
    }
    return self;
}

- (void)updateConstraints
{
    if(!self.didSetupConstraints) {
        // Self
        [GCAppSetup setConstraints_FillFullScreenWithView:self superview:self.parentController.view];
        
        // Register label
        [self.label_Register mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).with.offset(mas_Padding_Page_Large.top);
            make.left.equalTo(self.mas_left).with.offset(mas_Padding_Page_Large.left);
            make.right.equalTo(self.mas_right).with.offset(mas_Padding_Page_Large.right);
            make.width.mas_equalTo(ScreenWidth-2*mas_Padding_Page_Large.left);
        }];
        // First Name
        [GCAppSetup setConstraints_PinHorizontallyWithPagePaddingAndTopWithPadding:PagePaddingLarge withView:self.entry_NameFirst superview:self upperview:self.label_Register];
        // Last Name
        [GCAppSetup setConstraints_PinHorizontallyWithPagePaddingAndTopWithPadding:PagePaddingLarge withView:self.entry_NameLast superview:self upperview:self.entry_NameFirst];
        // Email
        [GCAppSetup setConstraints_PinHorizontallyWithPagePaddingAndTopWithPadding:PagePaddingLarge withView:self.entry_Email superview:self upperview:self.entry_NameLast];
        // Password
        [GCAppSetup setConstraints_PinHorizontallyWithPagePaddingAndTopWithPadding:PagePaddingLarge withView:self.entry_PasswordNew superview:self upperview:self.entry_Email];
        // Password
        [GCAppSetup setConstraints_PinHorizontallyWithPagePaddingAndTopWithPadding:PagePaddingLarge withView:self.entry_PasswordConfirm superview:self upperview:self.entry_PasswordNew];
        
        // Submit Button
        [self.btn_Submit mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.entry_PasswordConfirm.mas_bottom).with.offset(mas_Padding_Page_Large.top);
            make.left.equalTo(self.mas_left).with.offset(mas_Padding_Page_Large.left);
            make.right.equalTo(self.mas_right).with.offset(mas_Padding_Page_Large.right);
            make.height.mas_equalTo(40);
            make.bottom.equalTo(self.mas_bottom).with.offset(mas_Padding_Page_Large.bottom);
        }];
        
        self.didSetupConstraints = YES;
    }
    [super updateConstraints];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    DDLogVerbose(@"textFieldShouldReturn:");
    [textField resignFirstResponder];
    return YES;
}

@end
