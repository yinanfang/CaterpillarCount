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
    self.orderScrollView.entry_Notes.delegate = self;
    self.orderScrollView.entry_Count.delegate = self;
    self.orderScrollView.entry_Length.delegate = self;

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
    
    [[self.orderScrollView.btn_Submit rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        NSLog(@"New Order button submit");
        NSDictionary *newOrder = @{
                                   @"orderID": @"",
                                   @"orderName": @"orderName test",
                                   @"length": self.orderScrollView.entry_Length,
                                   @"count": self.orderScrollView.entry_Count,
                                   @"note": self.orderScrollView.entry_Notes,
                                   @"orderPhotoLocalURL": self.orderScrollView.btn_PhotoPlaceHolder.titleLabel.text,
                                   };
        [GCAppViewModel addCurrentunsavedOrdersWithDictionary:newOrder];
        [self.navigationController popViewControllerAnimated:YES];
        NSLog(@"pop...");
    }];
    
}

#pragma mark - UITextField Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    DDLogVerbose(@"textFieldShouldReturn:");
    NSInteger nextTag = textField.tag + 1;
    // Try to find next responder
    UIResponder* nextResponder = [textField.superview viewWithTag:nextTag];
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
        UIImageWriteToSavedPhotosAlbum(imageToSave, nil, nil, nil);
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = paths[0];
        imagePath = [documentsDirectory stringByAppendingPathComponent:@"testImage.png"];
        NSData *data = UIImagePNGRepresentation(imageToSave);
        [data writeToFile:imagePath atomically:YES];
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
