//
//  JDChartsFenShiView.h
//  JustDrawIt
//
//  Created by Yanci on 16/4/4.
//  Copyright © 2016年 Yanci. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JDChartsFenShiParams : NSObject
@property (nonatomic,assign)CGFloat ZuiGaoJia;   /*! 最高价 */
@property (nonatomic,assign)CGFloat ZuiDiJia;    /*! 最低价 */
@property (nonatomic,assign)CGFloat ZuoShouJia;  /*! 昨收价 */
@property (nonatomic,assign)CGFloat KaiPanJia;   /*! 开盘价 */
@end

@interface JDChartsFenShiPoint : NSObject
@property (nonatomic,assign)NSInteger ShiJian;          /*! 时间 从9:30开始到15:00结束 ,interval */
@property (nonatomic,assign)CGFloat ChengJiaoJia;       /*! 成交价 */
@property (nonatomic,assign)NSUInteger ChengJiaoLiang;  /*! 成交量 */
@property (nonatomic,assign)NSUInteger ChengJiaoE;      /*! 成交额 */
@property (nonatomic,assign)CGFloat JunJia;             /*! 均价 */
@end

@interface JDChartsFenShiView : UIView
@property (nonatomic,strong)JDChartsFenShiParams *params;
@property (nonatomic,strong)NSArray *points;  /*! 结构以 JDChartsFenShiPoint 传入 */

- (id)initWithFrame:(CGRect)frame;

@end
