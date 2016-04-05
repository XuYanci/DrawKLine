//
//  JDPromptChartNavigationBar.m
//  JustDrawIt
//
//  Created by Yanci on 16/4/4.
//  Copyright © 2016年 Yanci. All rights reserved.
//

#import "JDPromptChartNavigationBar.h"

@implementation JDPromptChartNavigationBar

- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineCap(context, kCGLineCapSquare);
    CGContextSetLineWidth(context, 0.5);
    CGContextSetStrokeColorWithColor(context, [UIColor lightGrayColor].CGColor);
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, 0, CGRectGetHeight(self.frame));
    CGContextAddLineToPoint(context, CGRectGetWidth(self.frame) , CGRectGetHeight(self.frame));
    CGContextStrokePath(context);
}
@end
