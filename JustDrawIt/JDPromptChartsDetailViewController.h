//
//  JDChartsDetailViewController.h
//  JustDrawIt
//
//  Created by Yanci on 16/4/4.
//  Copyright © 2016年 Yanci. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JDChartsFenShiParams;
@interface JDPromptChartsDetailViewController : UIViewController
@property (nonatomic,strong)JDChartsFenShiParams *chartFenShiParams;
@property (nonnull,strong)NSArray *points;
@end
