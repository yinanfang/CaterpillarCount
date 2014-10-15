//
//  GCSurveyViewController.m
//  CaterpillarCount
//
//  Created by Golden Compass on 9/24/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import "GCSurveyViewController.h"
#import "GCSurveyScrollView.h"
#import "GCOrderTableViewCell.h"
#import "GCNewOrderViewController.h"

@interface GCSurveyViewController ()
@property GCSurveyScrollView *surveyScrollView;


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
        GCNewOrderViewController *newOrderViewController = [[GCNewOrderViewController alloc] init];
        [self.navigationController pushViewController:newOrderViewController animated:YES];
    }];
    
    // Configure Order Table View
//    self.surveyScrollView.orderTableView.allowsSelection = YES;
    self.surveyScrollView.orderTableView.delegate = self;
    self.surveyScrollView.orderTableView.dataSource = self;
    
    
    
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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *OrderTableIdentifier = @"OrderTableCell";
    GCOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:OrderTableIdentifier];
    if (cell == nil) {
        cell = [[GCOrderTableViewCell alloc] init];
    }
    // Customize cell
    
    return cell;
    
}



#pragma mark - Other View Methods
- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.barTintColor = [GCAppAPI getColorWithRGBAinHex:ThemeColor01];
    self.navigationController.navigationBar.hidden = NO;
}
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
