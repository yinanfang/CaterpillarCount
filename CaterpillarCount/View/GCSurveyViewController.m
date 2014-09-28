//
//  GCSurveyViewController.m
//  CaterpillarCount
//
//  Created by Golden Compass on 9/24/14.
//  Copyright (c) 2014 Golden Compass. All rights reserved.
//

#import "GCSurveyViewController.h"
#import "GCSurveyScrollView.h"
#import "OrderTableViewCell.h"

@interface GCSurveyViewController ()
@property GCAppAPI *AppAPI;
@property GCSurveyScrollView *surveyScrollView;


@end

@implementation GCSurveyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.AppAPI = [GCAppAPI sharedInstance];
    self.view.frame = ScreenBounds;
    
    // UI Navigation Bar
    // Set Title
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 120, 30)];
    label.textAlignment = NSTextAlignmentCenter;
    [label setFont:[UIFont boldSystemFontOfSize:16.0]];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setTextColor:[UIColor whiteColor]];
    [label setText:@"CaterpillarCount"];
    self.navigationItem.titleView = label;
    [label sizeToFit];
    // Back Button
    UIButton *backButton = [[UIButton alloc] initWithFrame: CGRectMake(0, 0, 45.0f, 30.0f)];
    backButton.backgroundColor = [UIColor clearColor];
    [backButton setTitle:@"Back" forState:UIControlStateNormal];
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = backButtonItem;
    self.navigationController.interactivePopGestureRecognizer.delegate = (id<UIGestureRecognizerDelegate>)self;
    [[backButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    // Add Survey View
    self.surveyScrollView = [[GCSurveyScrollView alloc] initWithParentController:self];
    
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
    
    // Configure Order Table View
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
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *OrderTableIdentifier = @"OrderTableCell";
    OrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:OrderTableIdentifier];
    if (cell == nil) {
        cell = [[OrderTableViewCell alloc] init];
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
