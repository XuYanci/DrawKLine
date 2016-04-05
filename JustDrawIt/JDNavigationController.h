//
//  JDNavigationController.h
//  JustDrawIt
//
//  Created by Yanci on 16/4/2.
//  Copyright © 2016年 Yanci. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  导航栏控制器
 */
@interface JDNavigationController : UINavigationController
/*! 控制器Orientation方向由orientation参数控制,暂支持单个Orientation */
@property (nonatomic,assign)UIInterfaceOrientation orientation;
@end
