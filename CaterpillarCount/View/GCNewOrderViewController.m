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
    self.singleOrderScrollView = [[GCNewOrderScrollView alloc] initWithParentController:self];
    [self.singleOrderScrollView setNeedsUpdateConstraints];
    [self.singleOrderScrollView updateConstraintsIfNeeded];
    
    [[self.singleOrderScrollView.btn_PhotoPlaceHolder rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
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
    
}

#pragma mark - UIImagePickerControllerDelegate Delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    DDLogVerbose(@"trying to set the image");
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    UIImage *originalImage, *editedImage, *imageToSave;
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
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = paths[0];
        NSString *path = [documentsDirectory stringByAppendingPathComponent:@"testImage.png"];
        NSData *data = UIImagePNGRepresentation(imageToSave);
        [data writeToFile:path atomically:YES];
    }
    // Handle a movie capture
//    if (CFStringCompare ((CFStringRef) mediaType, kUTTypeMovie, 0) == kCFCompareEqualTo) {
//        NSString *moviePath = [[info objectForKey: UIImagePickerControllerMediaURL] path];
//        if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum (moviePath)) {
//            UISaveVideoAtPathToSavedPhotosAlbum (moviePath, nil, nil, nil);
//        }
//    }
 
    [self.singleOrderScrollView.btn_PhotoPlaceHolder setTitle:@"" forState:UIControlStateNormal];
    [self.singleOrderScrollView.entry_Photo setImage:[info objectForKey:UIImagePickerControllerEditedImage]];
    [self dismissViewControllerAnimated:picker completion:nil];
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
