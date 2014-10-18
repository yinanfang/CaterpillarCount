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
    [GCAppSetup configureRightButtonOfNavigationViewController:self];
    
    // Add Survey View
    self.surveyScrollView = [[GCSurveyScrollView alloc] initWithParentController:self];
    [self.surveyScrollView setNeedsUpdateConstraints];
    [self.surveyScrollView updateConstraintsIfNeeded];
    
    // Configure the pickers
    self.picker_Temp = [[UIPickerView alloc] init];
    self.picker_Temp.backgroundColor = [UIColor whiteColor];
    self.picker_Temp.delegate = self;
    self.picker_Temp.dataSource = self;
    [self.view addSubview:self.picker_Temp];
    [self.picker_Temp mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.mas_equalTo(self.picker_Temp.frame.size.height);
    }];
    self.pickerContentArray = [[NSMutableArray alloc] init];
    self.pickerContentArray = [@[@"Below 40F", @"40F - 50F", @"50F - 60F", @"60F - 70F", @"70F - 80F", @"80F - 90F", @"90F - 100F", @"Above 100F"] mutableCopy];
    self.picker_Temp.delegate = self;
    self.picker_Temp.dataSource = self;
    // Show and hide motion
    __block BOOL shouldDisplayPicker = NO;
    [[self.surveyScrollView.entry_Temp rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        NSLog(@"botton tapped");
        shouldDisplayPicker = !shouldDisplayPicker;
        [self.view layoutIfNeeded];
        [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            [self.picker_Temp mas_updateConstraints:^(MASConstraintMaker *make){
                if (shouldDisplayPicker == YES) {
                    make.bottom.equalTo(self.view.mas_bottom);
                }else{
                    make.bottom.equalTo(self.view.mas_bottom).with.offset(self.picker_Temp.frame.size.height);
                }
            }];
            [self.view layoutIfNeeded];
        }completion:nil];
        // reload content for different options
//        [self.picker_Temp reloadAllComponents]
    }];
    
    // Add order button
    [[self.surveyScrollView.btn_NewOrderInfo rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        NSLog(@"add botton tapped");
        GCNewOrderViewController *orderViewController = [[GCNewOrderViewController alloc] init];
        [self.navigationController pushViewController:orderViewController animated:YES];
    }];
    
    // Configure Order Table View
//    self.surveyScrollView.orderTableView.allowsSelection = YES;
//    self.surveyScrollView.orderTableView.estimatedRowHeight = UITableViewAutomaticDimension;
    [self.surveyScrollView.orderTableView registerClass:[GCOrderTableViewCell class] forCellReuseIdentifier: CellIdentifierForOrderTableViewCell];
    self.surveyScrollView.orderTableView.delegate = self;
    self.surveyScrollView.orderTableView.dataSource = self;
    
    // Submit button
    [[self.surveyScrollView.btn_Submit rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        NSLog(@"hit button submit");
    }];
    
    
//    ui
    
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
    [self.surveyScrollView.entry_Temp setTitle:self.pickerContentArray[row] forState:UIControlStateNormal];
}

#pragma mark - UIPickerView DataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.pickerContentArray.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return self.pickerContentArray[row];
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
    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"heightForRowAtIndexPath");
    static GCOrderTableViewCell *cell;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cell = [self.surveyScrollView.orderTableView dequeueReusableCellWithIdentifier: CellIdentifierForOrderTableViewCell];
    });

    cell.bounds = CGRectMake(0.0f, 0.0f, self.surveyScrollView.orderTableView.bounds.size.width, cell.bounds.size.height);
    cell.contentView.bounds = cell.bounds;
    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];
    [cell setNeedsLayout];
    [cell layoutIfNeeded];
    NSLog(@"cell.bounds: %@", [NSValue valueWithCGRect:cell.bounds]);

    CGSize s = [cell.contentView systemLayoutSizeFittingSize: UILayoutFittingCompressedSize];
    NSLog(@"image view height: %@", [NSValue valueWithCGRect:cell.captureImageView.bounds]);

    NSLog(@"compression height: %@", [NSValue valueWithCGSize:s]);
    NSLog(@"expandable height: %@", [NSValue valueWithCGSize:s]);

//    return s.height + 1;
    return 130;
    
    
//    GCOrderTableViewCell *cell = self.offscreenCells[CellIdentifierForOrderTableViewCell];
//    if (!cell) {
//        cell = [[GCOrderTableViewCell alloc] init];
//        [self.offscreenCells setObject:cell forKey:CellIdentifierForOrderTableViewCell];
//    }
//    [cell setNeedsUpdateConstraints];
//    [cell updateConstraintsIfNeeded];
////    [cell setNeedsLayout];
////    [cell layoutIfNeeded];
//    NSLog(@"after constratintcell bounds: %@", [NSValue valueWithCGRect:cell.contentView.bounds]);
//    NSLog(@"cell # %ld; cell height: %f", (long)indexPath.row, [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height);
//
//    
//    
//    
//    cell.bounds = CGRectMake(0.0f, 0.0f, CGRectGetWidth(self.surveyScrollView.orderTableView.bounds), CGRectGetHeight(cell.bounds));
//    NSLog(@"set bounds.. bounds: %@", [NSValue valueWithCGRect:cell.bounds]);
//
//    
//    [cell setNeedsLayout];
//    [cell layoutIfNeeded];
//    CGFloat height = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
//    NSLog(@"cell # %ld; cell height: %f", (long)indexPath.row, height);
//    NSLog(@"cell bounds: %@", [NSValue valueWithCGRect:cell.contentView.bounds]);
//    NSLog(@"label dimension: %@", [NSValue valueWithCGRect:cell.captureImageView.bounds]);
//
//    height += 1;
//    return 88;
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
