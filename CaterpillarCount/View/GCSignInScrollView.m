//
//  GCSignInScrollView.m
//  CaterpillarCount
//
//  Created by Golden Compass on 9/29/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import "GCSignInViewController.h"
#import "GCSignInScrollView.h"

@interface GCSignInScrollView ()


@end

@implementation GCSignInScrollView

- (id)initWithParentController:(GCSignInViewController *)controller
{
    self = [super init];
    if (self) {
        self.parentController = controller;
        self.backgroundColor = [UIColor whiteColor];
        self.delegate = self;
        [self.parentController.view addSubview:self];

        // Login Label
        self.label_Login = [UILabel LabelTitleWithString:@"Log In to Your Account:" align:NSTextAlignmentLeft];
        [self addSubview:self.label_Login];
        // Entry order
        self.entry_Username = [UITextField TextFieldWithPlaceHolder:@"Username / Email" keyboardType:UIKeyboardTypeDefault];
        self.entry_Username.delegate = self;
        [self addSubview:self.entry_Username];
        // Entry Length
        self.entry_Password = [UITextField TextFieldWithPlaceHolder:@"Password" keyboardType:UIKeyboardTypeDefault];
        self.entry_Password.delegate = self;
        [self addSubview:self.entry_Password];

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
        
        // Login label
        [self.label_Login mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).with.offset(mas_Padding_Page_Large.top);
            make.left.equalTo(self.mas_left).with.offset(mas_Padding_Page_Large.left);
            make.right.equalTo(self.mas_right).with.offset(mas_Padding_Page_Large.right);
            make.width.mas_equalTo(ScreenWidth-2*mas_Padding_Page_Large.left);
        }];
        // Username
        [GCAppSetup setConstraints_PinHorizontallyWithPagePaddingAndTopWithPadding:PagePaddingLarge withView:self.entry_Username superview:self upperview:self.label_Login];
        // Password
        [GCAppSetup setConstraints_PinHorizontallyWithPagePaddingAndTopWithPadding:PagePaddingLarge withView:self.entry_Password superview:self upperview:self.entry_Username];
        
        // Submit Button
        [self.btn_Submit mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.entry_Password.mas_bottom).with.offset(mas_Padding_Page_Large.top);
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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
