//
//  JDStockDetialViewController.m
//  JustDrawIt
//
//  Created by Yanci on 16/4/2.
//  Copyright © 2016年 Yanci. All rights reserved.
//

#import "JDStockDetialViewController.h"
#import "JDStockDynamicDetailTableViewCell.h"
#import "UIViewController+MBProgressHUD.h"
#import "MXRequest+WisdomFinancialInformationCloud.h"
#import "NSDictionary+Validation.h"
#import "JDPriceBtn.h"
#import "JDChartsTableViewCell.h"
#import "JDChartsFenShiView.h"
#import "JDNavigationController.h"
#import "JDPromptChartsDetailViewController.h"
#import "NSArray+SafeAccess.h"

#define kStockCode      @"SH600000"
#define kCellIdentifier_StockDynamicDetail  @"CellIdentifierStockDynamiDetail"
#define kCellIdentifier_ChartsDetail        @"CellIdentifierChartsDetail"

@interface JDStockDetialViewController () <UITableViewDataSource,UITableViewDelegate,DZNSegmentedControlDelegate>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSDictionary *RepDataQuoteDynaSingleDict;  /*! 动态详情字典 */
@property (nonatomic,strong) NSDictionary *RepDataQuoteMinDict;         /*! 动态分时字典 */
@property (nonatomic,strong) DZNSegmentedControl *sectionModuleHeaderView;

@end



@implementation JDStockDetialViewController




#pragma mark - Life Cycle 
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
 
    /*[self showHUDWithMessage:@"loading ..."];*/
  
    /*! 请求动态详情 */
    [MXRequest sendQuoteDynaRequest:kStockCode
                              field:nil
                             output:nil
                             token:[[[NSUserDefaults standardUserDefaults] objectForKey:@"JD_USERDEFAULT_REPDATATOKEN"] objectForKey:@"token"]
                           callback:^(NSInteger error, id result)
     {
     
         if (error == 0) {
             /*[self hideHUDWithCompletionMessage:@"network error!"];*/
         }
         else if(error == 1) {
             NSDictionary *resultDict = result;
             NSNumber *error = [resultDict numberForKey:@"Err"];
             if (error.intValue == 0) {
                 /* Get the reponse quote dyanmic dictionary */
                 //[self hideHUDWithCompletionMessage:@"Get quote dynamic success"];
                 _RepDataQuoteDynaSingleDict = [[[resultDict dictionaryForKey:@"Data"]arrayForKey:@"RepDataQuoteDynaSingle"] objectAtIndex:0];
                 [self.tableView reloadData];
             }
             else {
                 //[self hideHUDWithCompletionMessage:@"Get quote dynamic fail!"];
             }
         }
    }];
    
    /*! 请求分时详情 (分时详情必须获取当天数据) */
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"YYYYMMdd"];
    NSString *currentDay = [dateFormatter stringFromDate:currentDate];
    NSString *begin_time = [NSString stringWithFormat:@"%@-093000-000-8",currentDay];
    NSString *end_time = [NSString stringWithFormat:@"%@-150000-000-8",currentDay];
 
    [MXRequest sendQuoteMinRequest:kStockCode
                             field:nil
                            output:@"json"
                        begin_time:begin_time
                           endtime:end_time
                             start:nil
                             count:nil
                            prefix:nil
                             token:[[[NSUserDefaults standardUserDefaults] objectForKey:@"JD_USERDEFAULT_REPDATATOKEN"] objectForKey:@"token"]
                          callback:^(NSInteger error, id result)
     {
         if (error == 0) {
                // Network Error
         }
         else {
          
             NSDictionary *resultDict = result;
             NSNumber *error = [resultDict numberForKey:@"Err"];
             if (error.intValue == 0) {
                 _RepDataQuoteMinDict = [[resultDict dictionaryForKey:@"Data"] dictionaryForKey:@"JsonTbl"];
                 
                [self.tableView reloadData];
             }
             else {
                 // Error Response
             }
         }
     }];
    
//#if 1
//    NSString* string = @"1459819800";
//    NSDate *date = [NSDate dateWithTimeIntervalSince1970:string.integerValue];
//    /*! Convert UTC Date to GMT Date */
//    NSTimeZone *zone = [NSTimeZone systemTimeZone];
//    NSInteger interval = [zone secondsFromGMTForDate:date];
//    NSDate *localeDate = [date dateByAddingTimeInterval:interval];
//    
//#endif
    
}
#pragma mark - tableview datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return  3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 2) {
        return 50;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    if (indexPath.section == 0 && indexPath.row == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier_StockDynamicDetail forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        NSString *ZuiXinJia =  [NSString stringWithFormat:@"%.2f",[[_RepDataQuoteDynaSingleDict dictionaryForKey:@"Data"] numberForKey:@"ZuiXinJia"].doubleValue];
        NSString *ZhangDie  = [NSString stringWithFormat:@"%.2f",[[_RepDataQuoteDynaSingleDict dictionaryForKey:@"Data"] numberForKey:@"ZhangDie"].doubleValue];
        NSString *ZhangFu   = [NSString stringWithFormat:@"%.2f%%",[[_RepDataQuoteDynaSingleDict dictionaryForKey:@"Data"] numberForKey:@"ZhangFu"].doubleValue];
        NSDate *ShiJian   = [NSDate dateWithTimeIntervalSince1970:[[_RepDataQuoteDynaSingleDict dictionaryForKey:@"Data"] numberForKey:@"ZhangFu"].integerValue];
        
        
        ((JDStockDynamicDetailTableViewCell *)cell).ZuiXinJiaLabel.text = ZuiXinJia;
        ((JDStockDynamicDetailTableViewCell *)cell).ZhangDieLabel.text = ZhangDie;
        ((JDStockDynamicDetailTableViewCell *)cell).ZhangFuLable.text =ZhangFu;
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"MM-dd HH:mm"];
        ((JDStockDynamicDetailTableViewCell *)cell).ShiJianLabel.text = [dateFormatter stringFromDate:ShiJian];
        
        NSArray *priceTitles = @[@"今开",@"昨收",@"最高",@"最低",@"成交量(股)",@"市盈率TTM",@"市总值(亿)",@"换手率(%)"];
        NSArray *priceValues = @[@"0.00",@"0.00",@"0.00",@"0.00",@"0.00",@"0.00",@"0.00",@"0.00"];
        
        NSUInteger i = 0;
        for (JDPriceBtn *priceBtn in  ((JDStockDynamicDetailTableViewCell *)cell).priceBtns) {
            [priceBtn setTitle:[priceTitles objectAtIndex:i]];
            [priceBtn setValue:[priceValues objectAtIndex:i]];
            i++;
        }
    }
    else if(indexPath.section == 1 && indexPath.row == 0) {
        
        static NSUInteger TAG_FENSHI = 0xF1;
      
        cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier_ChartsDetail forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [((JDChartsTableViewCell*)cell).segmentCtrl setItems:@[@"分时",@"5日",@"日k",@"周k",@"月K"]];
        ((JDChartsTableViewCell*)cell).segmentCtrl.delegate = self;
        ((JDChartsTableViewCell*)cell).segmentCtrl.selectedSegmentIndex = 0;
        [((JDChartsTableViewCell*)cell).segmentCtrl addTarget:self action:@selector(selectedChartsSegment:) forControlEvents:UIControlEventValueChanged];
       
        // 分时
        if (((JDChartsTableViewCell*)cell).segmentCtrl.selectedSegmentIndex == 0) {
            
            JDChartsFenShiView *fenshiView = [((JDChartsTableViewCell*)cell).containerView viewWithTag:TAG_FENSHI];
            UIView *containerView = ((JDChartsTableViewCell*)cell).containerView;
            if (fenshiView == nil) {
                /*! 分时图的大小与ContainerView大小一致*/
                fenshiView = [[JDChartsFenShiView alloc]initWithFrame:CGRectZero];
                fenshiView.tag = TAG_FENSHI;
                fenshiView.backgroundColor  = [UIColor whiteColor];
                fenshiView.translatesAutoresizingMaskIntoConstraints = NO;
                [containerView addSubview:fenshiView];
          
                 
                [containerView addConstraint:[NSLayoutConstraint constraintWithItem:fenshiView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:containerView attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
                
                [containerView addConstraint:[NSLayoutConstraint constraintWithItem:fenshiView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:containerView attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
                
                [containerView addConstraint:[NSLayoutConstraint constraintWithItem:fenshiView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:containerView attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
                
                [containerView addConstraint:[NSLayoutConstraint constraintWithItem:fenshiView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:containerView attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
            }
            
            JDChartsFenShiParams *params = [[JDChartsFenShiParams alloc]init];
            params.ZuiGaoJia = [[_RepDataQuoteDynaSingleDict dictionaryForKey:@"Data"]numberForKey:@"ZuiGaoJia"].doubleValue;
            params.ZuiDiJia = [[_RepDataQuoteDynaSingleDict dictionaryForKey:@"Data"]numberForKey:@"ZuiDiJia"].doubleValue;
            params.ZuoShouJia = [[_RepDataQuoteDynaSingleDict dictionaryForKey:@"Data"]numberForKey:@"ZuoShouJia"].doubleValue;
            params.KaiPanJia = [[_RepDataQuoteDynaSingleDict dictionaryForKey:@"Data"]numberForKey:@"KaiPanJia"].doubleValue;
            fenshiView.params = params;
            
            [fenshiView setPoints:[self getFenShiPoints]];
            [fenshiView setNeedsDisplay];
            
            [((JDChartsTableViewCell*)cell).containerView bringSubviewToFront:fenshiView];
        }
        // 5日
        else if (((JDChartsTableViewCell*)cell).segmentCtrl.selectedSegmentIndex == 1) {}
        // 日k
        else if (((JDChartsTableViewCell*)cell).segmentCtrl.selectedSegmentIndex == 2) {}
        // 周k
        else if (((JDChartsTableViewCell*)cell).segmentCtrl.selectedSegmentIndex == 3) {}
        // 月k
        else if (((JDChartsTableViewCell*)cell).segmentCtrl.selectedSegmentIndex == 4) {}
        
    }
    else if(indexPath.section == 2) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"DD"];
        NSArray *data = @[@"资料",@"财报",@"公告",@"新闻",@"研报"];
        cell.textLabel.text = data[_sectionModuleHeaderView.selectedSegmentIndex];
    }
    return cell;
}

#pragma mark - tableview delegate
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 2) {
        if (_sectionModuleHeaderView == nil) {
            _sectionModuleHeaderView = [[DZNSegmentedControl alloc]initWithItems:@[@"资料",@"财报",@"公告",@"新闻",@"研报"]];
            _sectionModuleHeaderView.showsCount = false;
            _sectionModuleHeaderView.autoAdjustSelectionIndicatorWidth = false;
            _sectionModuleHeaderView.selectedSegmentIndex = 0;
            _sectionModuleHeaderView.delegate = self;
            [_sectionModuleHeaderView addTarget:self action:@selector(selectedModuleSegment:) forControlEvents:UIControlEventValueChanged];
        }
        return _sectionModuleHeaderView;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 0) {
        return 210.f;
    }
    else if(indexPath.section == 1 && indexPath.row == 0) {
        return 250.f;
    }
    else if(indexPath.section == 2) {
        return 44.0;
    }
    return 0.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 2) {
        return 44.0;
    }
    return 0.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        JDPromptChartsDetailViewController *promptCtrl = [[JDPromptChartsDetailViewController alloc]init];
        JDNavigationController *naviCtrl = [[JDNavigationController alloc]initWithRootViewController:promptCtrl];
        naviCtrl.orientation = UIInterfaceOrientationLandscapeRight;
        
    
        JDChartsFenShiParams *params = [[JDChartsFenShiParams alloc]init];
        params.ZuiGaoJia = [[_RepDataQuoteDynaSingleDict dictionaryForKey:@"Data"]numberForKey:@"ZuiGaoJia"].doubleValue;
        params.ZuiDiJia = [[_RepDataQuoteDynaSingleDict dictionaryForKey:@"Data"]numberForKey:@"ZuiDiJia"].doubleValue;
        params.ZuoShouJia = [[_RepDataQuoteDynaSingleDict dictionaryForKey:@"Data"]numberForKey:@"ZuoShouJia"].doubleValue;
        params.KaiPanJia = [[_RepDataQuoteDynaSingleDict dictionaryForKey:@"Data"]numberForKey:@"KaiPanJia"].doubleValue;
        promptCtrl.chartFenShiParams = params;
        promptCtrl.points = [self getFenShiPoints];
        
        // ! 效果过渡并不好看
        [self presentViewController:naviCtrl animated:NO completion:nil];
    }
    
}
#pragma mark - DZNSegmentControl Delegate 
- (UIBarPosition)positionForBar:(id <UIBarPositioning>)view
{
    return UIBarPositionBottom;
}


#pragma mark - user events 
- (void)selectedChartsSegment:(DZNSegmentedControl *)sender {
   // JDChartsTableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    NSLog(@"SELECT CHARTS SEGMENT %ld",(long)sender.selectedSegmentIndex);
}

- (void)selectedModuleSegment:(DZNSegmentedControl *)sender {
    NSLog(@"SELECT MODULE SEGMENT %ld",(long)sender.selectedSegmentIndex);
 
    [self.tableView reloadData];
 
}

#pragma mark - Getter and Setter 
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.frame];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.tableFooterView = [[UIView alloc]init];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [_tableView registerNib:[UINib nibWithNibName:@"JDStockDynamicDetailTableViewCell" bundle:nil] forCellReuseIdentifier:kCellIdentifier_StockDynamicDetail];
        [_tableView registerNib:[UINib nibWithNibName:@"JDChartsTableViewCell" bundle:nil] forCellReuseIdentifier:kCellIdentifier_ChartsDetail];
    }
    return _tableView;
}

- (NSArray *)getFenShiPoints {
    NSArray *repQuoteMinData =  [[[[[[[_RepDataQuoteMinDict arrayForKey:@"data"]objectAtIndexOrNil:0] objectAtIndexOrNil:0]arrayForKey:@"data"] objectAtIndexOrNil:0] objectAtIndexOrNil:1]arrayForKey:@"data"] ;
    NSMutableArray *points = [ NSMutableArray array];
    
    
    for (NSArray *repQuoteMinDataValue in repQuoteMinData) {
        JDChartsFenShiPoint *point = [[JDChartsFenShiPoint alloc]init];
        NSUInteger ShiJianInterval =  ((NSNumber *)[repQuoteMinDataValue objectAtIndexOrNil:0]).integerValue;
        
        /*! 获取时,分,秒 */
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:ShiJianInterval];
        NSCalendar *calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierChinese];
        NSDateComponents *comps = [[NSDateComponents alloc]init];
        NSInteger unitFlags = NSCalendarUnitHour | NSCalendarUnitMinute| NSCalendarUnitSecond;
        comps = [calendar components:unitFlags fromDate:date];
        
        point.ShiJian = [comps hour] * 3600 + [comps minute] * 60 + [comps second];
        point.ChengJiaoJia = ((NSNumber *)[repQuoteMinDataValue objectAtIndexOrNil:1]).floatValue;
        point.ChengJiaoLiang = ((NSNumber *)[repQuoteMinDataValue objectAtIndex:2]).integerValue;
        point.ChengJiaoE = ((NSNumber *)[repQuoteMinDataValue objectAtIndex:3]).integerValue;
        point.JunJia = ((NSNumber *)[repQuoteMinDataValue objectAtIndex:4]).floatValue;
        [points addObject:point];
    }
    return points;
}




@end
