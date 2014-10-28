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
    
    // UI Navigation Bar
    [GCAppSetup configureNavigationViewController:self withNavigationTitle:@"Caterpillars Count"];
    UIButton *rightButton = [GCAppSetup configureRightButtonOfNavigationViewController:self];
    [[rightButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        DDLogVerbose(@"hit right button");
    }];
    
    // Add Survey View
    self.surveyScrollView = [[GCSurveyScrollView alloc] initWithParentController:self];
    [self.surveyScrollView setNeedsUpdateConstraints];
    [self.surveyScrollView updateConstraintsIfNeeded];
    
    // Configure the pickers
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
            [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                [self.picker_Generic mas_updateConstraints:^(MASConstraintMaker *make){
                    make.bottom.equalTo(self.view.mas_bottom);
                }];
                [self.view layoutIfNeeded];
            }completion:nil];
        }
        
        return [RACSignal empty];
    }];
    
    self.surveyScrollView.entry_Temp.rac_command = self.firePicker;
    self.surveyScrollView.entry_Site.rac_command = self.firePicker;
    self.surveyScrollView.entry_Circle.rac_command = self.firePicker;
    self.surveyScrollView.entry_Survey.rac_command = self.firePicker;
    self.surveyScrollView.entry_Herbivory.rac_command = self.firePicker;

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
    
    // Submit button
    [[self.surveyScrollView.btn_Submit rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        NSLog(@"hit button submit");
        [GCAppViewModel saveAppDataToNSUserDefaults];
    }];
}


- (void)viewWillAppear:(BOOL)animated
{
    // Navigation Control
    self.navigationController.navigationBar.barTintColor = [GCAppAPI getColorWithRGBAinHex:ThemeColor01];
    self.navigationController.navigationBar.hidden = NO;
    
    // Reload table view
    NSLog(@"reload..");
    [self.surveyScrollView.orderTableView reloadData];
    [super viewWillAppear:animated];
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

// Hide keyboard when touching the background
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    DDLogVerbose(@"touchesBegan in GCSurveyViewController");
//    UITouch *touch = [[event allTouches] anyObject];
//    if ([self.orderScrollView.entry_Length isFirstResponder] && [touch view] != self.orderScrollView.entry_Length) {
//        [self.orderScrollView.entry_Length resignFirstResponder];
//    }
//    if ([self.orderScrollView.entry_Count isFirstResponder] && [touch view] != self.orderScrollView.entry_Count) {
//        [self.orderScrollView.entry_Count resignFirstResponder];
//    }
//    if ([self.orderScrollView.entry_Notes isFirstResponder] && [touch view] != self.orderScrollView.entry_Notes) {
//        [self.orderScrollView.entry_Notes resignFirstResponder];
//    }
    [super touchesBegan:touches withEvent:event];
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
            self.pickerContent = [GCAppViewModel sharedInstance].currentUserData.sites;
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
    GCOrder *order = (GCOrder *)[GCAppViewModel sharedInstance].currentUnsavedOrders[row];
    DDLogVerbose(@"%@", order);
    cell.label_OrderName.text = order.orderName;
    cell.label_Length.text = [NSString stringWithFormat:@"%@", order.length];
    cell.label_Count.text = [NSString stringWithFormat:@"%@", order.count];
    cell.label_Notes.text = order.note;
    
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
//                                                         NSUserDomainMask, YES);
//    NSString *documentsDirectory = [paths objectAtIndex:0];
//    NSString* path = [documentsDirectory stringByAppendingPathComponent:@"testImage.png"];
//    NSLog(@"path: %@", path);
//    UIImage* image = [UIImage imageWithContentsOfFile:path];
    UIImage *image = [UIImage imageWithContentsOfFile:order.orderPhotoLocalURL];
    cell.captureImageView.image = image;
//
//    cell.captureImageView.image = [UIImage imageNamed:@"icon_menu"];

}

//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return UITableViewAutomaticDimension;
//}


#pragma mark - Other View Methods
//- (BOOL)prefersStatusBarHidden {
//    return YES;
//}
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
