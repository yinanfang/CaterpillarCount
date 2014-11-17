//
//  GCNewOrderViewController.m
//  CaterpillarCount
//
//  Created by Golden Compass on 9/28/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import "GCNewOrderViewController.h"

@interface GCNewOrderViewController ()

@end

@implementation GCNewOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // UI Navigation Bar
    [GCAppSetup configureNavigationViewController:self withNavigationTitle:@"New Arthropod Order"];
    
    // Add new order scroll view
    self.orderScrollView = [[GCNewOrderScrollView alloc] initWithParentController:self];
    self.orderScrollView.delegate = self;
    [self.orderScrollView setNeedsUpdateConstraints];
    [self.orderScrollView updateConstraintsIfNeeded];
    
    // Configure UITextField Delegate
    self.orderScrollView.entry_Length.delegate = self;
    [self addAccessaryViewToTextField:self.orderScrollView.entry_Length];
    self.orderScrollView.entry_Count.delegate = self;
    [self addAccessaryViewToTextField:self.orderScrollView.entry_Count];
    self.orderScrollView.entry_Notes.delegate = self;
    // Add Input accessary view
    
    // UIPickerView
    self.picker_Generic = [[UIPickerView alloc] init];
    self.picker_Generic.backgroundColor = [UIColor whiteColor];
    self.picker_Generic.delegate = self;
    self.picker_Generic.dataSource = self;
    [self.view addSubview:self.picker_Generic];
    [self.picker_Generic mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.mas_equalTo(self.picker_Generic.frame.size.height);
    }];
    // Show and hide motion
    self.orderScrollView.entry_Order.rac_command = [[RACCommand alloc] initWithSignalBlock:^(UIButton *button) {
        if (!self.didShowPicker) {
            DDLogVerbose(@"fire order name picker!");
            self.pickerType = PickerType_Order;
            [self.picker_Generic reloadAllComponents];
            [self.view layoutIfNeeded];
            [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                [self.picker_Generic mas_updateConstraints:^(MASConstraintMaker *make){
                    make.bottom.equalTo(self.view.mas_bottom);
                }];
                [self.view layoutIfNeeded];
            }completion:nil];
        } else {
            DDLogVerbose(@"Hiding picker");
            [self.view layoutIfNeeded];
            [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                [self.picker_Generic mas_updateConstraints:^(MASConstraintMaker *make){
                    make.bottom.equalTo(self.view.mas_bottom).with.offset(self.picker_Generic.frame.size.height);
                }];
                [self.view layoutIfNeeded];
            }completion:nil];
        }
        self.didShowPicker = !self.didShowPicker;
        return [RACSignal empty];
    }];
    
    // Image picker
    [[self.orderScrollView.btn_PhotoPlaceHolder rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        NSLog(@"should take picture");
        UIImagePickerController *camera = [[UIImagePickerController alloc] init];
        camera.sourceType = UIImagePickerControllerSourceTypeCamera;
        // Allow Video
//        camera.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
        camera.delegate = self;
        camera.cameraDevice = UIImagePickerControllerCameraDeviceRear;
        camera.showsCameraControls = YES;
        camera.allowsEditing = YES;
        [self presentViewController:camera animated:YES completion:nil];
    }];
    
    // Submission Button
    [[self.orderScrollView.btn_Submit rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        NSLog(@"New Order button submit");
        NSString *length = [self.orderScrollView.entry_Length.text isEqualToString:@""] ? @"0" : self.orderScrollView.entry_Length.text;
        NSString *count = [self.orderScrollView.entry_Count.text isEqualToString:@""] ? @"0" : self.orderScrollView.entry_Count.text;
        NSString *note = [self.orderScrollView.entry_Notes.text isEqualToString:@""] ? @" " : self.orderScrollView.entry_Notes.text;
        
        NSDictionary *newOrder = @{
                                   @"orderID": @"",
                                   @"orderName": self.orderScrollView.entry_Order.titleLabel.text,
                                   @"length": length,
                                   @"count": count,
                                   @"note": note,
                                   @"orderPhotoLocalURL": self.orderScrollView.btn_PhotoPlaceHolder.titleLabel.text,
                                   };
        [GCAppViewModel addCurrentunsavedOrdersWithDictionary:newOrder];
        [self.navigationController popViewControllerAnimated:YES];
        NSLog(@"pop...");
    }];
    
}

#pragma mark - UIPickerView Delegate
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    [self configurePickerContent];
    return self.pickerContent[row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSString *newValue = self.pickerContent[row];
    switch (self.pickerType) {
        case PickerType_Order:
            [self.orderScrollView.entry_Order setTitle:newValue forState:UIControlStateNormal];
            break;
        default:
            break;
    }
}

#pragma mark - UIPickerView DataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    [self configurePickerContent];
    return self.pickerContent.count;
}

- (void)configurePickerContent
{
    GCStore *store = [GCStore sharedInstance];
    switch (self.pickerType) {
        case PickerType_Order:
            self.pickerContent = store.arthropodOrder;
            break;
        default:
            break;
    }
}

#pragma mark - UITextField Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    DDLogVerbose(@"textFieldShouldReturn:");
    NSInteger nextTag = textField.tag + 1;
    // Try to find next responder
    UIResponder* nextResponder = [textField.superview viewWithTag:nextTag];
    DDLogVerbose(@"%@", nextResponder);
    if (nextResponder) {
        // Found next responder, so set it.
        [nextResponder becomeFirstResponder];
    } else {
        // Not found, so remove keyboard.
        [textField resignFirstResponder];
    }
    return NO; // We do not want UITextField to insert line-breaks.
}

// Hide keyboard when touching the background
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    DDLogVerbose(@"touchesBegan in GCNewOrderViewController");
    UITouch *touch = [[event allTouches] anyObject];
    if ([self.orderScrollView.entry_Length isFirstResponder] && [touch view] != self.orderScrollView.entry_Length) {
        [self.orderScrollView.entry_Length resignFirstResponder];
    }
    if ([self.orderScrollView.entry_Count isFirstResponder] && [touch view] != self.orderScrollView.entry_Count) {
        [self.orderScrollView.entry_Count resignFirstResponder];
    }
    if ([self.orderScrollView.entry_Notes isFirstResponder] && [touch view] != self.orderScrollView.entry_Notes) {
        [self.orderScrollView.entry_Notes resignFirstResponder];
    }
    [super touchesBegan:touches withEvent:event];
}

- (void)addAccessaryViewToTextField:(UITextField *)textField
{
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 50)];
    numberToolbar.barStyle = UIBarStyleBlackTranslucent;
    numberToolbar.items = [NSArray arrayWithObjects:
                           [[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelNumberPad)],
                           [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                           [[UIBarButtonItem alloc]initWithTitle:@"Next" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)],
                           nil];
    numberToolbar.tintColor = [UIColor whiteColor];
    [numberToolbar sizeToFit];
    textField.inputAccessoryView = numberToolbar;
}

-(void)cancelNumberPad{
    if ([self.orderScrollView.entry_Length isFirstResponder]) {
        self.orderScrollView.entry_Length.text = @"";
        [self.orderScrollView.entry_Length resignFirstResponder];
    }
    if ([self.orderScrollView.entry_Count isFirstResponder]) {
        self.orderScrollView.entry_Count.text = @"";
        [self.orderScrollView.entry_Count resignFirstResponder];
    }
}

-(void)doneWithNumberPad{
    if ([self.orderScrollView.entry_Length isFirstResponder]) {
        [self.orderScrollView.entry_Count becomeFirstResponder];
    } else if ([self.orderScrollView.entry_Count isFirstResponder]) {
        [self.orderScrollView.entry_Notes becomeFirstResponder];
    }
}

#pragma mark - UIImagePickerControllerDelegate Delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    DDLogVerbose(@"trying to set the image");
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    UIImage *originalImage, *editedImage, *imageToSave;
    NSString *imagePath;
    // Handle a still image capture
    if (CFStringCompare((CFStringRef) mediaType, kUTTypeImage, 0) == kCFCompareEqualTo) {
        editedImage = (UIImage *) [info objectForKey:UIImagePickerControllerEditedImage];
        originalImage =  (UIImage *) [info objectForKey:UIImagePickerControllerOriginalImage];
        if (editedImage) {
            imageToSave = editedImage;
        } else {
            imageToSave = originalImage;
        }
        // Save the image to Camera Roll
//        UIImageWriteToSavedPhotosAlbum(imageToSave, nil, nil, nil);
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = paths[0];
        NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
        [objDateformat setDateFormat:@"yyyy_MM_dd_HH_mm_ss"];
        NSString *strTime = [objDateformat stringFromDate:[NSDate date]];
        imagePath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png", strTime]];
        NSLog(@"image Path: %@", imagePath);
        NSData *data = UIImagePNGRepresentation(imageToSave);
        NSError *error = nil;
        [data writeToFile:imagePath options:NSDataWritingAtomic error:&error];
        if (error) {
            NSLog(@"Fail: %@", [error localizedDescription]);
        }
    }
 
    [self.orderScrollView.btn_PhotoPlaceHolder setTitle:imagePath forState:UIControlStateNormal];
    [self.orderScrollView.btn_PhotoPlaceHolder setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
    [self.orderScrollView.entry_Photo setImage:[info objectForKey:UIImagePickerControllerEditedImage]];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Other View Controller methods
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
