//
//  JDChartsTableViewCell.h
//  JustDrawIt
//
//  Created by Yanci on 16/4/3.
//  Copyright © 2016年 Yanci. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <DZNSegmentedControl/DZNSegmentedControl.h>
@interface JDChartsTableViewCell : UITableViewCell
@property (nonatomic,weak)IBOutlet DZNSegmentedControl *segmentCtrl;
@property (nonatomic,weak)IBOutlet UIView *containerView;
@end
