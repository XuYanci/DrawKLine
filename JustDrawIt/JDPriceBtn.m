//
//  JDPriceBtn.m
//  JustDrawIt
//
//  Created by Yanci on 16/4/3.
//  Copyright © 2016年 Yanci. All rights reserved.
//

#import "JDPriceBtn.h"

@implementation JDPriceBtn

- (void)awakeFromNib {
    self.titleLabel.numberOfLines = 2;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineCap(context, kCGLineCapSquare);
    CGContextSetLineWidth(context, 0.5);
    CGContextSetStrokeColorWithColor(context, [UIColor lightGrayColor].CGColor);
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, 0, 0);
    CGContextAddLineToPoint(context, CGRectGetWidth(self.frame) , 0);
    CGContextAddLineToPoint(context, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
    CGContextStrokePath(context);
}

- (void)setTitle:(NSString *)title {
    title_ = title;
    [self configButtonTitle:title];
}

- (void)setValue:(NSString *)value {
    value_ = value;
    [self configButtonTitle:title_];
}

- (void)configButtonTitle:(NSString *)title {
    NSMutableString *mutableTitle = [NSMutableString stringWithString:(title == nil ? @"" : title)];
    NSString *valueString = (value_ == nil ? @"" : value_);
    NSString *breakString = @"\n";
   
    NSString *resultString =   [breakString stringByAppendingString:valueString];
    [mutableTitle insertString:resultString atIndex:title.length];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:mutableTitle];
 
    NSMutableParagraphStyle *style  = [[NSMutableParagraphStyle alloc] init];
    style.alignment = NSTextAlignmentCenter;
    style.lineBreakMode = NSLineBreakByWordWrapping;
    
    /*! 文字居中 */
   [attributedString addAttribute:NSParagraphStyleAttributeName
                            value:style
                            range:NSMakeRange(0, attributedString.string.length)];
    
    /*! 文字字体大小 */
    [attributedString addAttribute:NSFontAttributeName
                             value:[UIFont systemFontOfSize:12.0]
                             range:[attributedString.string
                                    rangeOfString:(value_ == nil ? @"" : value_)]];
    [attributedString addAttribute:NSFontAttributeName
                             value:[UIFont systemFontOfSize:12.0]
                             range:[attributedString.string
                                    rangeOfString:(title == nil ? @"" : title)]];
    
    /*! 文字颜色 */
    [attributedString addAttribute:NSForegroundColorAttributeName
                             value:[UIColor lightGrayColor]
                             range:[attributedString.string
                                    rangeOfString:(title == nil ? @"" : title)]];
 
    
    
    [self setAttributedTitle:attributedString forState:UIControlStateNormal];
    
    
    
}

@end
