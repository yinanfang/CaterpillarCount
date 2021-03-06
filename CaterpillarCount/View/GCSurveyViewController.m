//
//  GCSurveyViewController.m
//  CaterpillarCount
//
//  Created by Golden Compass on 9/24/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import "GCSurveyViewController.h"
#import "GCOrderTableViewCell.h"

@interface GCSurveyViewController ()

@end

@implementation GCSurveyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // UI Navigation Bar
    [GCAppSetup configureNavigationViewController:self withNavigationTitle:@"Caterpillars Count"];
    self.navigationItem.hidesBackButton = YES;
    UIButton *rightButton = [GCAppSetup configureRightButtonOfNavigationViewController:self];
    [[rightButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        DDLogVerbose(@"hit right button");
        self.alert_Logout =[[UIAlertView alloc ] initWithTitle:@"Warning!"
                                                         message:@"All unsaved data will be lost!"
                                                        delegate:self
                                               cancelButtonTitle:@"Cancel"
                                               otherButtonTitles: nil];
        [self.alert_Logout addButtonWithTitle:@"Log Out"];
        [self.alert_Logout show];
    }];
    
    // Add Survey View
    self.surveyScrollView = [[GCSurveyScrollView alloc] initWithParentController:self];
    [self.surveyScrollView setNeedsUpdateConstraints];
    [self.surveyScrollView updateConstraintsIfNeeded];
    
    [[self.surveyScrollView.btn_NewSite rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        DDLogVerbose(@"hit add site button");
        self.alertView_addSite = [[UIAlertView alloc] initWithTitle:@"Add new site" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Submit", nil];
        [self.alertView_addSite setAlertViewStyle:UIAlertViewStyleLoginAndPasswordInput];
        [[self.alertView_addSite textFieldAtIndex:0] setPlaceholder:@"Site ID"];
        [self.alertView_addSite textFieldAtIndex:0].keyboardType = UIKeyboardTypeNumberPad;
        [[self.alertView_addSite textFieldAtIndex:1] setPlaceholder:@"Site Password"];
        [[self.alertView_addSite textFieldAtIndex:1] setSecureTextEntry:YES];
        [self.alertView_addSite show];

        
    }];
    
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
    self.firePicker = [[RACCommand alloc] initWithSignalBlock:^(UIButton *button) {
        if (!self.didShowPicker) {
            DDLogVerbose(@"fire picker!");
            if (button == self.surveyScrollView.entry_Temp) {
                self.pickerType = PickerType_Temperature;
                DDLogVerbose(@"temp!!");
            } else if (button == self.surveyScrollView.entry_Site) {
                self.pickerType = PickerType_Site;
                DDLogVerbose(@"site!!");
            } else if (button == self.surveyScrollView.entry_Circle) {
                self.pickerType = PickerType_Circle;
                DDLogVerbose(@"circle!!");
            } else if (button == self.surveyScrollView.entry_Survey) {
                self.pickerType = PickerType_Survey;
                DDLogVerbose(@"survey!!");
            } else if (button == self.surveyScrollView.entry_Herbivory) {
                self.pickerType = PickerType_Herbivory;
                DDLogVerbose(@"herbivory");
            }
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
    self.surveyScrollView.entry_Temp.rac_command = self.firePicker;
    self.surveyScrollView.entry_Site.rac_command = self.firePicker;
    self.surveyScrollView.entry_Circle.rac_command = self.firePicker;
    self.surveyScrollView.entry_Survey.rac_command = self.firePicker;
    self.surveyScrollView.entry_Herbivory.rac_command = self.firePicker;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    // Info Button Control
    [[self.surveyScrollView.btn_Info_Site rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        NSLog(@"Info button for Site tapped!");
        UIAlertView * alert =[[UIAlertView alloc ] initWithTitle:@"Site Info"
                                                         message:@"Enter the Site, Circle, and Survey id’s from where you conducted a survey. Enter any notes that you may deem relevant to data reviewers."
                                                        delegate:self
                                               cancelButtonTitle:@"I got it!"
                                               otherButtonTitles: nil];
        [alert show];
    }];
    [[self.surveyScrollView.btn_Info_Order rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        NSLog(@"Info button for Order tapped!");
        UIAlertView * alert =[[UIAlertView alloc ] initWithTitle:@"Order Info"
                                                         message:@"Add a record for each Arthropod Order that you see, estimating its length in mm and noting how many you saw. If necessary, submit observations for an Order using multiple records (e.g., you saw 10 ants of size 4 mm, and 3 ants of size 12 mm). You can add multiple Arthropod Orders to each submission. IMPORTANT: If you conducted a survey but observed no arthropods at all, select ‘NONE’."
                                                        delegate:self
                                               cancelButtonTitle:@"I got it!"
                                               otherButtonTitles: nil];
        [alert show];
    }];
    [[self.surveyScrollView.btn_Info_Plant rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        NSLog(@"Info button for Plant tapped!");
        UIAlertView * alert =[[UIAlertView alloc ] initWithTitle:@"Plant Info"
                                                         message:@"Select the name of the plant species that you surveyed from the menu below, or enter it if it does not appear on the list. Choose the herbivory score that best characterizes the average level of herbivory across all leaves examined in the survey."
                                                        delegate:self
                                               cancelButtonTitle:@"I got it!"
                                               otherButtonTitles: nil];
        [alert show];
    }];
    
    // Add order button
    [[self.surveyScrollView.btn_NewOrderInfo rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        NSLog(@"add botton tapped");
        GCNewOrderViewController *orderViewController = [[GCNewOrderViewController alloc] init];
        [self.navigationController pushViewController:orderViewController animated:YES];
    }];
    
    // Configure Order Table View
    [self.surveyScrollView.orderTableView registerClass:[GCOrderTableViewCell class] forCellReuseIdentifier: CellIdentifierForOrderTableViewCell];
    self.surveyScrollView.orderTableView.delegate = self;
    self.surveyScrollView.orderTableView.dataSource = self;
    self.surveyScrollView.orderTableView.allowsMultipleSelectionDuringEditing = NO;
    
    // Image picker
    [[self.surveyScrollView.btn_PhotoPlaceHolder rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
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
    
    // Submit button
    [[self.surveyScrollView.btn_Submit rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        NSLog(@"hit button submit");
        
        //        BOOL isValidInput = YES;
        BOOL isValidInput = [self isValidInput];
        if (isValidInput) {
            [self startSubmissionProcess];
        }
//        [GCAppViewModel saveAppDataToNSUserDefaults];
    }];
}

- (void)keyboardWillShow
{
//    DDLogVerbose(@"Hiding picker");
//    [self.view layoutIfNeeded];
//    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//        [self.picker_Generic mas_updateConstraints:^(MASConstraintMaker *make){
//            make.bottom.equalTo(self.view.mas_bottom).with.offset(self.picker_Generic.frame.size.height);
//        }];
//        [self.view layoutIfNeeded];
//    }completion:nil];
}

- (BOOL)isValidInput
{
    if ([self.surveyScrollView.entry_Site.titleLabel.text isEqualToString:@"Click to choose a site"]) {
//        [self makeHUDErrorAlertWithString:@"Need to choose title lable"];
//        return  NO;
    }
    if ([self.surveyScrollView.entry_Circle.titleLabel.text isEqualToString:@"Click to choose a circle"]) {
        [self makeHUDErrorAlertWithString:@"Circle can't be empty"];
        return  NO;
    }
    if ([self.surveyScrollView.entry_Survey.titleLabel.text isEqualToString:@"Click to choose a survey"]) {
        [self makeHUDErrorAlertWithString:@"Survey can't be empty"];
        return  NO;
    }
    if ([self.surveyScrollView.entry_PlantSpecies.text isEqualToString:@""]) {
        [self makeHUDErrorAlertWithString:@"Plant Species can't be empty"];
        return  NO;
    }
    if ([self.surveyScrollView.entry_Herbivory.titleLabel.text isEqualToString:@"Click to choose a herbivory"]) {
        [self makeHUDErrorAlertWithString:@"Herbivory can't be empty"];
        return  NO;
    }
    return YES;
}

- (void)makeHUDErrorAlertWithString:(NSString *)message
{
    self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.hud.mode = MBProgressHUDModeCustomView;
    dispatch_async(dispatch_get_main_queue(), ^{
        UIImage *image = [UIImage imageNamed:@"mark_cross"];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        self.hud.customView = imageView;
        self.hud.labelText = @"Error!";
        self.hud.detailsLabelText = message;
    });
    [self.hud hide:YES afterDelay:3];
}

- (void)startSubmissionProcess
{
    // Getting Survey data
    GCUserData *userData = [GCAppViewModel sharedInstance].currentUserData;
    GCSurvey *survey = [[GCSurvey alloc] init];
    survey.userID = userData.user.userID;
    survey.siteName = [self.surveyScrollView.entry_Site.titleLabel.text isEqualToString:@"No site"] ? @"5" : self.surveyScrollView.entry_Site.titleLabel.text;
    survey.circleNumber = [[[NSNumberFormatter alloc] init] numberFromString:self.surveyScrollView.entry_Circle.titleLabel.text];
    survey.circleNumber = (survey.circleNumber) ? : @1;
    survey.surveyString = self.surveyScrollView.entry_Survey.titleLabel.text;
    survey.timeSubmitted = [NSDate date];
    survey.temperature = self.surveyScrollView.entry_Temp.titleLabel.text;
    survey.siteNotes = self.surveyScrollView.entry_SiteNotes.text;
    survey.ordersArray = [GCAppViewModel sharedInstance].currentUnsavedOrders;
    survey.plantSpecies = self.surveyScrollView.entry_PlantSpecies.text;
    survey.herbivory = [[[NSNumberFormatter alloc] init] numberFromString:self.surveyScrollView.entry_Herbivory.titleLabel.text];
    survey.herbivory = (survey.herbivory) ? : @1;
    survey.plantPhotoLocalURL = self.surveyScrollView.btn_PhotoPlaceHolder.titleLabel.text;
    [GCAppViewModel addSurveyData:survey];
    
    __block NSDictionary *surveyDictionary = [MTLJSONAdapter JSONDictionaryFromModel:survey];
    DDLogInfo(@"surveyDictionary, %@", surveyDictionary);
    __block NSURL *url_Submission = [NSURL URLWithString:[[NSString alloc] initWithFormat:@"%@/~pocket14/forsyth.im/caterpillars/submission_full.php", [GCAppAPI getCurrentDomain]]];
    __block NSDictionary *parameters = @{
                                         @"type": @"survey",
                                         @"siteID": surveyDictionary[@"siteName"],
                                         @"userID": surveyDictionary[@"userID"],
                                         
                                         @"circle": surveyDictionary[@"circleNumber"],
                                         @"survey": surveyDictionary[@"surveyString"],
                                         @"timeStart": surveyDictionary[@"timeSubmitted"],
                                         @"temperatureMin": @72,
                                         @"temperatureMax": @73,
                                         @"siteNotes": surveyDictionary[@"siteNotes"],
                                         @"plantSpecies": surveyDictionary[@"plantSpecies"],
                                         @"herbivory": surveyDictionary[@"herbivory"],
                                         };
    DDLogInfo(@"Registering Survey text content");
    [GCNetwork requestPOSTWithURL:url_Submission parameter:parameters completion:^(BOOL succeeded, NSData *data) {
        if (succeeded) {
            DDLogInfo(@"Submitting full survey");
            survey.surveyID = ((NSDictionary *)data)[@"surveyID"];
            surveyDictionary = [MTLJSONAdapter JSONDictionaryFromModel:survey];
            NSArray *ordersArray = surveyDictionary[@"ordersArray"];
            
            // Init image buffer
            self.imageBuffer = [[NSMutableArray alloc] init];
            
            // Upload Plant Picture
            NSString *filepath = surveyDictionary[@"plantPhotoLocalURL"];
            [self addToImageBufferWithFileName:filepath newName:((NSDictionary *)data)[@"leavePhoto"]];
            // Submit orders
            for (GCOrder *order in ordersArray) {
                parameters = @{
                               @"type": @"order",
                               @"userID": surveyDictionary[@"userID"],
                               @"surveyID": surveyDictionary[@"surveyID"],
                               @"orderArthropod": order.orderName,
                               @"orderLength": order.length,
                               @"orderNotes": order.note,
                               @"orderCount": order.count,
                               };
                [GCNetwork requestPOSTWithURL:url_Submission parameter:parameters completion:^(BOOL succeeded, NSData *data) {
                    DDLogVerbose(@"Submitted a order");
                    [self addToImageBufferWithFileName:order.orderPhotoLocalURL newName:((NSDictionary *)data)[@"insectPhoto"]];
                }];
            }
            self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            self.hud.mode = MBProgressHUDModeIndeterminate;
            self.hud.labelText = @"Submitting data";
            [self uploadAllImages];
        }
    }];
}

- (void)addToImageBufferWithFileName:(NSString *)oldName newName:(NSString *)newName
{
    if (![oldName isEqual:@"Capture"]) {
        // Copy the file and Rename
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSError *error;
        DDLogVerbose(@"old name: %@; new name: %@", oldName, newName);
        
        newName = [newName stringByReplacingOccurrencesOfString:@"uploads/" withString:@""];
        newName = [newName stringByReplacingOccurrencesOfString:@".jpg" withString:@".png"];
        DDLogVerbose(@"new name: %@", newName);
        
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"^[/].+[/]" options:0 error:&error];
        NSRange needleRange = [regex rangeOfFirstMatchInString:oldName options:NSMatchingAnchored range:NSMakeRange(0, oldName.length)];
        NSString *needle = [oldName substringWithRange:needleRange];
        if (error) {
            NSLog(@"regex error: %@", error);
        }
        newName = [NSString stringWithFormat:@"%@%@", needle, newName];
        DDLogVerbose(@"new : %@", newName);
        
        // Copy file over
        if ([fileManager fileExistsAtPath:newName] == YES) {
            [fileManager removeItemAtPath:newName error:&error];
        }
        [fileManager copyItemAtPath:oldName toPath:newName error:&error];
        
        // Add to buffer
        [self.imageBuffer addObject:newName];
        
    }
}

- (void)uploadAllImages
{
    DDLogVerbose(@"uploadAllImages");
    if ([self.imageBuffer count] != 0) {
        NSString *oneName = self.imageBuffer[0];
        DDLogVerbose(@"Still have images to upload. Local file: %@", oneName);
        NSData *uploadData = [NSData dataWithContentsOfFile: oneName];
        self.manager = [AFHTTPRequestOperationManager manager];
        self.manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        [self.manager POST:URLPathToImageSubmissionPHP parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            [formData appendPartWithFileData:uploadData name:@"userfile" fileName:[oneName lastPathComponent] mimeType:[self mimeTypeForPath:oneName]];
        } success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            NSLog(@"Success: %@", string);
            // Delete the image location string in buffer
            [self.imageBuffer removeObjectAtIndex:0];
            // Recursively upload the rest
            [self uploadAllImages];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error);
        }];
    } else {
        DDLogVerbose(@"Upload completed!");
        self.hud.mode = MBProgressHUDModeCustomView;
        dispatch_async(dispatch_get_main_queue(), ^{
            UIImage *image = [UIImage imageNamed:@"mark_check"];
            UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
            self.hud.customView = imageView;
            self.hud.labelText = @"Submission completed!";
        });
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2*NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            [self.hud hide:YES];
        });
    }
    
}

- (void)uploadImageWithPath:(NSString *)path newName:(NSString *)newname
{
    // Get the file name in the middle
    
    // Upload the Image with AFNetworking
    
    NSString *urlString = @"http://forsyth.im/caterpillars/uploads/order158-75.jpg";
    
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    [manager POST:[url absoluteString] parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//        [formData appendPartWithFileData:imageData name:fieldName fileName:[imagePath lastPathComponent] mimeType:[self mimeTypeForPath:imagePath]];
//    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        NSLog(@"Success: %@", string);
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"Error: %@", error);
//    }];
    
}

- (NSString *)mimeTypeForPath:(NSString *)path
{
    // get a mime type for an extension using MobileCoreServices.framework
    CFStringRef extension = (__bridge CFStringRef)[path pathExtension];
    CFStringRef UTI = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, extension, NULL);
    assert(UTI != NULL);
    
    NSString *mimetype = CFBridgingRelease(UTTypeCopyPreferredTagWithClass(UTI, kUTTagClassMIMEType));
    assert(mimetype != NULL);
    
    CFRelease(UTI);
    
    return mimetype;
}

- (void)viewWillAppear:(BOOL)animated
{
    DDLogInfo(@"viewWillAppear");
    // Navigation Control
    self.navigationController.navigationBar.barTintColor = [GCAppAPI getColorWithRGBAinHex:ThemeColor01];
    self.navigationController.navigationBar.hidden = NO;
    
    // Reload table view
    NSLog(@"reload..");
    [self.surveyScrollView.orderTableView reloadData];
    
    if ([[GCAppViewModel sharedInstance].currentUnsavedOrders count]==0) {
        self.surveyScrollView.orderTableView.hidden = YES;
        self.surveyScrollView.label_tableTips.hidden = NO;
    } else {
        self.surveyScrollView.orderTableView.hidden = NO;
        self.surveyScrollView.label_tableTips.hidden = YES;
    }
    
    [super viewWillAppear:animated];
}

// Hide keyboard when touching the background
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    DDLogVerbose(@"touchesBegan in GCSurveyViewController");
    [super touchesBegan:touches withEvent:event];
}

#pragma mark - UIPickerView Delegate
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSString *newValue = self.pickerContent[row];
    switch (self.pickerType) {
        case PickerType_Temperature:
            [self.surveyScrollView.entry_Temp setTitle:newValue forState:UIControlStateNormal];
            break;
        case PickerType_Site:
            [self.surveyScrollView.entry_Site setTitle:newValue forState:UIControlStateNormal];
            break;
        case PickerType_Circle:
            [self.surveyScrollView.entry_Circle setTitle:newValue forState:UIControlStateNormal];
            break;
        case PickerType_Survey:
            [self.surveyScrollView.entry_Survey setTitle:newValue forState:UIControlStateNormal];
            break;
        case PickerType_Herbivory:
            [self.surveyScrollView.entry_Herbivory setTitle:newValue forState:UIControlStateNormal];
            break;
        case PickerType_Order:
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

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    [self configurePickerContent];
    return self.pickerContent[row];
}

- (void)configurePickerContent
{
    GCStore *store = [GCStore sharedInstance];
    switch (self.pickerType) {
        case PickerType_Temperature:
            self.pickerContent = store.temperatureRanges;
            break;
        case PickerType_Site:
            if ([[GCAppViewModel sharedInstance].currentUserData.sites count] == 0) {
                self.pickerContent = [@[@"No site",] mutableCopy];
            } else {
                self.pickerContent = [GCAppViewModel sharedInstance].currentUserData.sites;
            }
            break;
        case PickerType_Circle:
            self.pickerContent = store.circles;
            break;
        case PickerType_Survey:
            self.pickerContent = store.surveyStrings;
            break;
        case PickerType_Herbivory:
            self.pickerContent = store.herbivory;
            break;
        case PickerType_Order:
        default:
            break;
    }
}

//-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
//{
//    GCStore *store = [GCStore sharedInstance];
//    if (self.pickerType == PickerType_Herbivory) {
//        return store.herbivoryViews[row];
//    }
//    return nil;
//}

#pragma mark - UITableView Delegate


#pragma mark - UITableView DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[GCAppViewModel sharedInstance].currentUnsavedOrders count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"cellForRowAtIndexPath...");
    DDLogWarn(@"%li", (long)indexPath.row);
    GCOrderTableViewCell *cell = [self.surveyScrollView.orderTableView dequeueReusableCellWithIdentifier:CellIdentifierForOrderTableViewCell];
    [self configureCellContent:cell atRow:indexPath.row];
    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"heightForRowAtIndexPath");
    // Init a static instance of cell
    static GCOrderTableViewCell *cell;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cell = [self.surveyScrollView.orderTableView dequeueReusableCellWithIdentifier: CellIdentifierForOrderTableViewCell];
    });
    [self configureCellContent:cell atRow:indexPath.row];
    
    // Make sure the constraints have been added to this cell, since it may have just been created from scratch
    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];
    // Set width of the tableview. Important for calculating multi-line & word-wraping UILabel. This happens automatically in cellForRowAtIndexPath
    cell.bounds = CGRectMake(0.0f, 0.0f, self.surveyScrollView.orderTableView.bounds.size.width, cell.bounds.size.height);
    // Do the layout pass on the cell, which will calculate the frames for all the views based on the constraints
    [cell setNeedsLayout];
    [cell layoutIfNeeded];
    
    CGSize s = [cell.contentView systemLayoutSizeFittingSize: UILayoutFittingCompressedSize];
    DDLogVerbose(@"cell height: %f", s.height + 1);
    return s.height + 1;
}

- (void)configureCellContent:(GCOrderTableViewCell *)cell atRow:(NSInteger)row
{
//    DDLogVerbose(@"hit add button at index: %li", (long)[self.surveyScrollView.orderTableView indexPathForCell:cell].row);
    DDLogWarn(@"cell tag: %li", (long)cell.tag);
    
    GCOrder *order = (GCOrder *)[GCAppViewModel sharedInstance].currentUnsavedOrders[row];
    DDLogVerbose(@"%@", order);
    cell.label_OrderName.text = order.orderName;
    cell.label_Length.text = [NSString stringWithFormat:@"Length: %@", order.length];
    cell.label_Count.text = [NSString stringWithFormat:@"Count: %@", order.count];
    cell.label_Notes.text = [NSString stringWithFormat:@"Notes: %@", order.note];
    if ([order.orderPhotoLocalURL isEqualToString:@"Capture"]) {
        cell.captureImageView.image = [UIImage imageNamed:@"cover_logo"];
    } else {
        UIImage *image = [UIImage imageWithContentsOfFile:order.orderPhotoLocalURL];
        cell.captureImageView.image = image;
    }
    
    
    cell.btn_Add.tag = row;
    [cell.btn_Add addTarget:self action:@selector(addCount:) forControlEvents:UIControlEventTouchUpInside];
    cell.btn_Minus.tag = row;
    [cell.btn_Minus addTarget:self action:@selector(minusCount:) forControlEvents:UIControlEventTouchUpInside];

}

- (void)addCount:(FUIButton *)addButton
{
    DDLogVerbose(@"hit add button. tag: %li", (long)addButton.tag);
    GCOrder *order = (GCOrder *)[GCAppViewModel sharedInstance].currentUnsavedOrders[addButton.tag];
    order.count = [NSNumber numberWithInt:[order.count intValue]+1];
    DDLogVerbose(@"%@", [GCAppViewModel sharedInstance].currentUnsavedOrders);
    [self.surveyScrollView.orderTableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:addButton.tag inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
}

- (void)minusCount:(FUIButton *)addButton
{
    DDLogVerbose(@"hit minus button. tag: %li", (long)addButton.tag);
    GCOrder *order = (GCOrder *)[GCAppViewModel sharedInstance].currentUnsavedOrders[addButton.tag];
    order.count = [NSNumber numberWithInt:[order.count intValue]-1];
    DDLogVerbose(@"%@", [GCAppViewModel sharedInstance].currentUnsavedOrders);
    [self.surveyScrollView.orderTableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:addButton.tag inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GCNewOrderViewController *orderViewController = [[GCNewOrderViewController alloc] init];
    [self.navigationController pushViewController:orderViewController animated:YES];
    orderViewController.isModifying = YES;
    orderViewController.row = indexPath.row;
}

// Override to support conditional editing of the table view.
// This only needs to be implemented if you are going to be returning NO
// for some items. By default, all items are editable.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [[GCAppViewModel sharedInstance].currentUnsavedOrders removeObjectAtIndex:indexPath.row];
        [self.surveyScrollView.orderTableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return UITableViewAutomaticDimension;
//}

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
    
    [self.surveyScrollView.btn_PhotoPlaceHolder setTitle:imagePath forState:UIControlStateNormal];
    [self.surveyScrollView.btn_PhotoPlaceHolder setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
    [self.surveyScrollView.entry_PlantPhoto setImage:[info objectForKey:UIImagePickerControllerEditedImage]];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UIAlertView Delegate
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (alertView == self.alert_Logout)
    {
        if (buttonIndex == 1) {
            [self.navigationController popToRootViewControllerAnimated:YES];
            [GCAppViewModel sharedInstance].appData.didLogedIn = NO;
            [GCAppViewModel saveAppDataToNSUserDefaults];
        }
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView == self.alertView_addSite) {
        if (buttonIndex == 1) {
            NSURL *url = [NSURL URLWithString:[[NSString alloc] initWithFormat:@"%@%@", [GCAppAPI getCurrentDomain], URIPathToSitesPHP]];
            NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
            [f setNumberStyle:NSNumberFormatterDecimalStyle];
            NSDictionary *parameter = @{
                                        @"action": @"checkSitePassword",
                                        @"siteID": [f numberFromString:[alertView textFieldAtIndex:0].text],
                                        @"sitePasswordCheck": [alertView textFieldAtIndex:1].text,
//                                        @"siteID": @10,
//                                        @"sitePasswordCheck": @"sitePass",
                                        };
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            [GCNetwork requestPOSTWithURL:url parameter:parameter completion:^(BOOL succeeded, NSData *data) {
                if (succeeded && [((NSDictionary *)data)[@"validSitePassword"] isEqual: @1]) {
                    hud.mode = MBProgressHUDModeCustomView;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        UIImage *image = [UIImage imageNamed:@"mark_check"];
                        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
                        hud.customView = imageView;
                        hud.labelText = [NSString stringWithFormat:@"Add site succeeded!"];
                    });
                    [[GCAppViewModel sharedInstance].currentUserData.sites addObject:[alertView textFieldAtIndex:0].text];
                } else {
                    hud.mode = MBProgressHUDModeCustomView;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        UIImage *image = [UIImage imageNamed:@"mark_cross"];
                        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
                        hud.customView = imageView;
                        hud.labelText = [NSString stringWithFormat:@"Add site failed!"];
                    });
                }
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1*NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                    [hud hide:YES];
                });
            }];
        }
        
    }
    

}

#pragma mark - Class Instance
+ (NSDateFormatter *)dateFormatter {
    
    static NSDateFormatter *kDateFormatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        kDateFormatter = [[NSDateFormatter alloc] init];
        kDateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
        kDateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";  // you configure this based on the strings that your webservice uses!!
    });
    return kDateFormatter;
}

#pragma mark - Other View Methods
//- (BOOL)prefersStatusBarHidden {
//    return YES;
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
