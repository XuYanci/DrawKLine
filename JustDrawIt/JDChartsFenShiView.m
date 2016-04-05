//
//  JDChartsFenShiView.m
//  JustDrawIt
//
//  Created by Yanci on 16/4/4.
//  Copyright © 2016年 Yanci. All rights reserved.
//

#import "JDChartsFenShiView.h"

#define PADDING_TOP             0.0f
#define PADDING_BOTTOM          5.0f
#define PADDING_LEFT            10.0f
#define PADDING_RIGHT           10.0f
#define TIME_HEIGHT             15.0f


@implementation JDChartsFenShiParams
@end

@implementation JDChartsFenShiPoint
@end

@interface JDChartsFenShiView ()
@end

@implementation JDChartsFenShiView
@synthesize params;

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self commonInit];
    }
    return self;
}
 

//// Only override drawRect: if you perform custom drawing.
//// An empty implementation adversely affects performance during animation.

- (void)drawFenShiLine:(CGContextRef)context Type:(NSUInteger)type Color:(CGColorRef)colorRef lineWidth:(CGFloat)lineWidth {
    
    CGFloat height = self.bounds.size.height;
    height -= PADDING_BOTTOM;
    
    CGFloat divideHeight = height / 3.0f;
    CGFloat zuoShouJia = self.params.ZuoShouJia;
    
    if (zuoShouJia == 0) {
        zuoShouJia = self.params.KaiPanJia;
    }
    
    if (zuoShouJia == 0) {
        zuoShouJia = (self.params.ZuiGaoJia + self.params.ZuiDiJia);
    }
    
    CGFloat tempA = fabs(zuoShouJia - self.params.ZuiDiJia);
    CGFloat tempB = fabs(self.params.ZuiGaoJia - zuoShouJia);
    CGFloat tempBiggerValue = (tempA > tempB ? tempA : tempB) * 1.1;
    CGFloat tempC = zuoShouJia * 0.001;
    CGFloat intervalValue = tempC > tempBiggerValue ? tempC : tempBiggerValue;
    CGFloat highestValue = zuoShouJia + intervalValue;
    CGFloat lowestValue = zuoShouJia - intervalValue;
    CGFloat ChengJiaoJiaIntervalY = (divideHeight * 2.00) / (highestValue - lowestValue);
    CGFloat ChengJiaoJiaIntervalX = (self.bounds.size.width - PADDING_LEFT - PADDING_RIGHT) / 14400;
    
    
    CGContextSetLineCap(context, kCGLineCapSquare);
    CGContextSetLineWidth(context, lineWidth);
    CGContextSetStrokeColorWithColor(context, colorRef);
    CGContextBeginPath(context);
    
    BOOL needMoveToPoint = true;
    
    for (JDChartsFenShiPoint *point in self.points) {
        NSUInteger timerInterval = point.ShiJian; // 相对于当天的秒数
        CGFloat price = type == 0 ? point.ChengJiaoJia : point.JunJia;
        CGFloat PriceY =(divideHeight * 2.00) - ((price - lowestValue) * ChengJiaoJiaIntervalY) ;
        CGFloat PriceX = 0.0;
        /*! 9:30 ~ 11: 30  */
        if (timerInterval>= 34200 && timerInterval <= 41400) {
            PriceX  = PADDING_LEFT + ((timerInterval - 34200) * ChengJiaoJiaIntervalX);
        }
        /*! 13:00 ~ 15:00 */
        else if(timerInterval >= 46800 && timerInterval <= 54000) {
            PriceX  = PADDING_LEFT + ((timerInterval - 34200 - 5400) * ChengJiaoJiaIntervalX);
        }
        if (needMoveToPoint) {
            CGContextMoveToPoint(context, PriceX, PriceY);
            needMoveToPoint = false;
        }
        else {
            CGContextAddLineToPoint(context, PriceX, PriceY);
        }
    }
    
    CGContextStrokePath(context);
    
}

// !!! 是否会占用高内存
- (void)drawRect:(CGRect)rect {
    /*! 绘制左边分区价格,lowest , low , middle , high , highest */
    CGFloat height = self.bounds.size.height;
    CGFloat width = self.bounds.size.width;
    height -= PADDING_BOTTOM;
    CGFloat divideHeight = height / 3.0f;
    
    /*! 参考第一路演app计算左边最高,最低等值 */
    CGFloat zuoShouJia = self.params.ZuoShouJia;
    if (zuoShouJia == 0) {
        zuoShouJia = self.params.KaiPanJia;
    }
    
    if (zuoShouJia == 0) {
        zuoShouJia = (self.params.ZuiGaoJia + self.params.ZuiDiJia);
    }
    
    CGFloat tempA = fabs(zuoShouJia - self.params.ZuiDiJia);
    CGFloat tempB = fabs(self.params.ZuiGaoJia - zuoShouJia);
    CGFloat tempBiggerValue = (tempA > tempB ? tempA : tempB) * 1.1;
    CGFloat tempC = zuoShouJia * 0.001;
    CGFloat intervalValue = tempC > tempBiggerValue ? tempC : tempBiggerValue;
    
    CGFloat middleValue = zuoShouJia;
    CGFloat highestValue = zuoShouJia + intervalValue;
    CGFloat higherValue = zuoShouJia + intervalValue / 2;
    CGFloat lowerValue = zuoShouJia - intervalValue/2;
    CGFloat lowestValue = zuoShouJia - intervalValue;
    
    CGFloat highestPercentValue = fabs((highestValue - middleValue)/middleValue * 100);
    CGFloat lowestPercentValue =  fabs((highestValue - middleValue)/middleValue * 100);
    
    NSString *middleValueStr = [NSString stringWithFormat:@"%.2f",middleValue];
    NSString *highestValueStr= [NSString stringWithFormat:@"%.2f",highestValue];
    NSString *higherValueStr = [NSString stringWithFormat:@"%.2f",higherValue];
    NSString *lowerValueStr = [NSString stringWithFormat:@"%.2f",lowerValue];
    NSString *lowestValueStr = [NSString stringWithFormat:@"%.2f",lowestValue];
    NSString *highestPercentValueStr = [NSString stringWithFormat:@"+%.2f",highestPercentValue];
    NSString *lowestPercentValueStr = [NSString stringWithFormat:@"-%.2f",lowestPercentValue];
    
    /*! 绘制字符串 */
    NSDictionary* fontDict = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:12.0f], NSFontAttributeName, [UIColor colorWithRed:114/255.0f green:128/255.0f blue:137/255.0f alpha:1.0f], NSForegroundColorAttributeName,nil];
    [highestValueStr drawAtPoint:CGPointMake(PADDING_LEFT, PADDING_TOP) withAttributes:fontDict];
    [higherValueStr drawAtPoint:CGPointMake(PADDING_LEFT, divideHeight / 2 - 12.0f) withAttributes:fontDict];
    [middleValueStr drawAtPoint:CGPointMake(PADDING_LEFT, divideHeight - 12.0f) withAttributes:fontDict];
    [lowerValueStr drawAtPoint:CGPointMake(PADDING_LEFT, divideHeight + divideHeight / 2 - 12.0f) withAttributes:fontDict];
    [lowestValueStr drawAtPoint:CGPointMake(PADDING_LEFT, divideHeight + divideHeight - 12.0f) withAttributes:fontDict];
    
    [highestPercentValueStr drawAtPoint:CGPointMake(width - PADDING_RIGHT - 30.0f, PADDING_TOP) withAttributes:fontDict];
    [lowestPercentValueStr drawAtPoint:CGPointMake(width - PADDING_RIGHT - 30.0f, divideHeight + divideHeight - 12.0f) withAttributes:fontDict];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
   
    [self drawFenShiLine:context Type:0 Color:[UIColor orangeColor].CGColor lineWidth:0.5];
    [self drawFenShiLine:context Type:1 Color:[UIColor blueColor].CGColor lineWidth:0.5];
}

- (void)layoutSubviews {
    [self commonInit];
}

- (void)commonInit {
    
    /*! 移除所有layer  */
    [self.layer.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
    
    /*! 初始化ShapeLayer */
    CAShapeLayer *_backgroundLayer;
    _backgroundLayer = [CAShapeLayer new];
    _backgroundLayer.fillColor = nil;
    _backgroundLayer.strokeColor = [UIColor lightGrayColor].CGColor;
    _backgroundLayer.lineWidth = 0.5f;
    _backgroundLayer.lineCap = kCALineCapRound;
    [self.layer addSublayer:_backgroundLayer];
    _backgroundLayer.frame = self.bounds;
    
    /*! 绘制分时图画板背景 */
    CGFloat height = self.bounds.size.height;
    CGFloat width = self.bounds.size.width;
    height -= PADDING_BOTTOM;
    CGFloat divideHeight = height / 3.0f;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(PADDING_LEFT, PADDING_TOP)];
    [path addLineToPoint:CGPointMake(PADDING_LEFT, divideHeight * 2)];
    [path addLineToPoint:CGPointMake(width - PADDING_RIGHT, divideHeight * 2)];
    [path addLineToPoint:CGPointMake(width - PADDING_RIGHT, PADDING_TOP)];
    
  
    [path moveToPoint:CGPointMake(PADDING_LEFT, divideHeight * 2 + TIME_HEIGHT)];
    [path addLineToPoint:CGPointMake(PADDING_LEFT, height - PADDING_BOTTOM)];
    [path addLineToPoint:CGPointMake(width - PADDING_RIGHT, height - PADDING_BOTTOM)];
    [path addLineToPoint:CGPointMake(width - PADDING_RIGHT, divideHeight * 2 + TIME_HEIGHT)];
    [path addLineToPoint:CGPointMake(PADDING_LEFT, divideHeight * 2 + TIME_HEIGHT)];
    
    _backgroundLayer.path = path.CGPath;
    
    /*! 绘制红色虚线 */
    CAShapeLayer *redDotLineShapeLayer = [CAShapeLayer new];
    redDotLineShapeLayer.fillColor = nil;
    redDotLineShapeLayer.strokeColor = [UIColor redColor].CGColor;
    redDotLineShapeLayer.lineWidth = 0.5;
    [redDotLineShapeLayer setLineJoin:kCALineJoinRound];
    [redDotLineShapeLayer setLineDashPattern:[NSArray arrayWithObjects:
                                              [NSNumber numberWithInt:3],
                                              [NSNumber numberWithInt:1],nil]];
    redDotLineShapeLayer.frame = self.bounds;
    [self.layer addSublayer:redDotLineShapeLayer];
    
    
    UIBezierPath *pathDotLine = [UIBezierPath bezierPath];
    [pathDotLine moveToPoint:CGPointMake(PADDING_LEFT, divideHeight * 1)];
    [pathDotLine addLineToPoint:CGPointMake(width - PADDING_RIGHT, divideHeight * 1)];
    redDotLineShapeLayer.path = pathDotLine.CGPath;
    
    
    /*! 绘制均分线 */
    CAShapeLayer *divideLineShapeLayer = [CAShapeLayer new];
    divideLineShapeLayer.fillColor = nil;
    divideLineShapeLayer.strokeColor = [UIColor lightGrayColor].CGColor;
    divideLineShapeLayer.lineWidth = 0.1;
    divideLineShapeLayer.frame = self.bounds;
    [self.layer addSublayer:divideLineShapeLayer];
    
    
    UIBezierPath *pathDividerLine = [UIBezierPath bezierPath];
    [pathDividerLine moveToPoint:CGPointMake(PADDING_LEFT, divideHeight / 2.0f)];
    [pathDividerLine addLineToPoint:CGPointMake(width - PADDING_RIGHT, divideHeight / 2.0f)];
    
    [pathDividerLine moveToPoint:CGPointMake(PADDING_LEFT, (divideHeight / 2.0f) * 3)];
    [pathDividerLine addLineToPoint:CGPointMake(width - PADDING_RIGHT, (divideHeight / 2.0f) * 3)];
    
    [pathDividerLine moveToPoint:CGPointMake((width / 4.0f) * 1,PADDING_TOP)];
    [pathDividerLine addLineToPoint:CGPointMake((width / 4.0f) * 1, divideHeight * 2)];
    
    [pathDividerLine moveToPoint:CGPointMake((width / 4.0f) * 2,PADDING_TOP)];
    [pathDividerLine addLineToPoint:CGPointMake((width / 4.0f) * 2, divideHeight * 2)];
    
    [pathDividerLine moveToPoint:CGPointMake((width / 4.0f) * 3,PADDING_TOP)];
    [pathDividerLine addLineToPoint:CGPointMake((width / 4.0f) * 3, divideHeight * 2)];
    
    divideLineShapeLayer.path = pathDividerLine.CGPath;
    
    self.backgroundColor = [UIColor whiteColor];
    
}


@end
