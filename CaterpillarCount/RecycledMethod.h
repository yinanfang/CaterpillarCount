//
//  RecycledMethod.h
//  CaterpillarCount
//
//  Created by Golden Compass on 10/14/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#ifndef CaterpillarCount_RecycledMethod_h
#define CaterpillarCount_RecycledMethod_h

#endif

/*
 
 
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
 UIImageWriteToSavedPhotosAlbum(imageToSave, nil, nil, nil);
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
 
 
 
 // Setup Navigation Controller
 //    UINavigationController *navigationController = [[UINavigationController alloc] init];
 //    [navigationController pushViewController:coverViewController animated:YES];
  
 
 AFNetworking POST and cancel
 
 [manager.operationQueue cancelAllOperations];
 
 /*   OR   ///////////////
 
 AFHTTPRequestOperation *post =[manager POST:nil parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
 //doing something
 } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
 // error handling.
 }];
 //Cancel operation
 [post cancel];
 
 
 // Submit Control
 [[self.registerScrollView.btn_Submit rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {

 }];

 
 // FUIAlert
 //        FUIAlertView *alertView = [[FUIAlertView alloc] initWithTitle:@"Well Done!" message:@"Submitting the data..." delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil, nil];
 //        alertView.alertViewStyle = FUIAlertViewStylePlainTextInput;
 //        alertView.delegate = self;
 //        alertView.titleLabel.textColor = [UIColor cloudsColor];
 //        alertView.titleLabel.font = [UIFont boldFlatFontOfSize:16];
 //        alertView.messageLabel.textColor = [UIColor cloudsColor];
 //        alertView.messageLabel.font = [UIFont flatFontOfSize:14];
 //        alertView.backgroundOverlay.backgroundColor = [[UIColor cloudsColor] colorWithAlphaComponent:0.8];
 //        alertView.alertContainer.backgroundColor = [UIColor midnightBlueColor];
 //        alertView.defaultButtonColor = [UIColor cloudsColor];
 //        alertView.defaultButtonShadowColor = [UIColor asbestosColor];
 //        alertView.defaultButtonFont = [UIFont boldFlatFontOfSize:16];
 //        alertView.defaultButtonTitleColor = [UIColor asbestosColor];
 //        [alertView show];
 
