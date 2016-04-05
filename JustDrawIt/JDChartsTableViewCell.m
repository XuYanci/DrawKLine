//
//  JDChartsTableViewCell.m
//  JustDrawIt
//
//  Created by Yanci on 16/4/3.
//  Copyright © 2016年 Yanci. All rights reserved.
//

#import "JDChartsTableViewCell.h"

@implementation JDChartsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code

    // Config segment control
    self.segmentCtrl.showsCount = false;
    self.segmentCtrl.autoAdjustSelectionIndicatorWidth = false;

}

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

 

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
