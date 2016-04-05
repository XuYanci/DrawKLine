//
//  JDStockDynamicDetailTableViewCell.h
//  JustDrawIt
//
//  Created by Yanci on 16/4/3.
//  Copyright © 2016年 Yanci. All rights reserved.
//

#import <UIKit/UIKit.h>

 

@interface JDStockDynamicDetailTableViewCell : UITableViewCell
@property (nonatomic,weak)IBOutlet UILabel *ZuiXinJiaLabel;     /*! 最新价 */
@property (nonatomic,weak)IBOutlet UILabel *ZhangDieLabel;      /*! 涨跌 */
@property (nonatomic,weak)IBOutlet UILabel *ZhangFuLable;       /*! 涨幅 */
@property (nonatomic,weak)IBOutlet UILabel *ShiJianLabel;       /*! 时间 */
@property (nonatomic,weak)IBOutlet UIButton *DingZengXinXiBtn;  /* !定增信息 */
@property (nonatomic,strong)IBOutletCollection(UIButton) NSArray *priceBtns; /* 其他价格集合 */

- (IBAction)dingZengXinXiBtnClick:(id)sender;
@end
