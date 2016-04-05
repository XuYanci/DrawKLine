//
//  JDChartsDetailViewController.m
//  JustDrawIt
//
//  Created by Yanci on 16/4/4.
//  Copyright © 2016年 Yanci. All rights reserved.
//

#import "JDPromptChartsDetailViewController.h"
#import "JDChartsFenShiView.h"
#import <DZNSegmentedControl/DZNSegmentedControl.h>
#import "JDPromptChartNavigationBar.h"

#define kSegmentCtrlHeigth                     50.0f
#define kDZNSegmentedControlDefaultIndex        0
#define kDZNSegmentedControlTineColor           [UIColor blueColor]

@interface JDPromptChartsDetailViewController ()<DZNSegmentedControlDelegate>
@property (nonatomic,strong)DZNSegmentedControl *control;
@property (nonatomic,strong)JDChartsFenShiView *fenshiView;
@property (nonatomic,strong)JDPromptChartNavigationBar *chartNavigaionBar;
@property (nonatomic,strong)NSArray *menuItems;
@end

@implementation JDPromptChartsDetailViewController


 

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _menuItems = @[@"分时",@"5日",@"日k",@"周k",@"月k"];
    
    /*! Setup Segement Control */
    self.control.frame = CGRectMake(0,
                                    CGRectGetHeight(self.view.frame) - kSegmentCtrlHeigth,
                                    CGRectGetWidth(self.view.frame),
                                    kSegmentCtrlHeigth);
    [self.view addSubview:self.control];

    /*! Setup FenshiView */
    _fenshiView = [[JDChartsFenShiView alloc]initWithFrame:CGRectMake(0,
                                                                     50.0f,
                                                                     CGRectGetWidth(self.view.frame),
                                                                     CGRectGetHeight(self.view.frame) - kSegmentCtrlHeigth  - kSegmentCtrlHeigth)];
    _fenshiView.params = _chartFenShiParams;
    _fenshiView.points = _points;
    [self.view addSubview:_fenshiView];
    
    /*! Set Background */
    self.view.backgroundColor = [UIColor whiteColor];
    
    /*! Setup NaviItem */
    self.navigationController.navigationBarHidden = true;
    
    /*! Setup Bar */
    _chartNavigaionBar = [[[NSBundle mainBundle]loadNibNamed:@"JDPromptChartNavigationBar" owner:nil options:nil]objectAtIndex:0];
    _chartNavigaionBar.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 44.0);
    [_chartNavigaionBar.closeBtn addTarget:self
                                    action:@selector(done:)
                          forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_chartNavigaionBar];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)didChangeSegment:(id)sender {
    
}

- (void)done:(id)sender {
    [self dismissViewControllerAnimated:false completion:nil];
}

#pragma mark - UIBarPositioningDelegate Methods

- (UIBarPosition)positionForBar:(id <UIBarPositioning>)view
{
    return UIBarPositionBottom;
}


 

#pragma mark - getter and setter

- (DZNSegmentedControl *)control
{
    if (!_control)
    {
        _control = [[DZNSegmentedControl alloc] initWithItems:self.menuItems];
        _control.delegate = self;
        _control.selectedSegmentIndex = kDZNSegmentedControlDefaultIndex;
        _control.showsCount = NO;
        _control.autoAdjustSelectionIndicatorWidth = false;
        [_control addTarget:self action:@selector(didChangeSegment:) forControlEvents:UIControlEventValueChanged];
    }
    return _control;
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
